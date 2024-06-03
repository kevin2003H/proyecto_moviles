// lib/service/api.dart

import 'dart:convert';// Importa la biblioteca 'dart:convert' para trabajar con datos JSON.
import 'package:http/http.dart' as http;
import '../models/pokemon.dart';

Future<List<Pokemon>> fetchPokemonList() async {// Define una función asincrónica para obtener la lista de Pokémon.
  final response = await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=20'));// Realiza una solicitud HTTP GET a la API de Pokémon.

  if (response.statusCode == 200) {// Verifica si la solicitud fue exitosa (código de estado 200).

    final List<dynamic> data = json.decode(response.body)['results'];
    // Para cada elemento de la lista, realiza otra solicitud para obtener información detallada del Pokémon.
    final List<Pokemon> pokemonList = await Future.wait(data.map((pokemonJson) async {
      final pokemonInfoResponse = await http.get(Uri.parse(pokemonJson['url']));

      if (pokemonInfoResponse.statusCode == 200) {// Verifica si la solicitud de información del Pokémon fue exitosa.
        final pokemonInfo = json.decode(pokemonInfoResponse.body);
        return Pokemon.fromJson(pokemonInfo);
      } else {
         // Lanza una excepción si no se pudo cargar la información del Pokémon.
        throw Exception('Failed to load Pokémon information');
      }
    }).toList());
    // Retorna la lista de Pokémon.
    return pokemonList;
  } else {
    throw Exception('Failed to load Pokémon list');
  }
}

