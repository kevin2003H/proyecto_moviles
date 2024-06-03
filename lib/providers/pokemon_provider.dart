//pokemon_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart'; // Importa el paquete flutter_riverpod para el manejo del estado en Flutter.
import 'package:http/http.dart' as http;// Importa el paquete http para realizar solicitudes HTTP.
import 'dart:convert';// Importa el paquete dart:convert para trabajar con JSON.
import '../models/pokemon.dart';// Importa el archivo de modelos de Pokémon.


// Define un proveedor de tipo FutureProvider que proporciona una lista de objetos Pokémon.
final pokemonProvider = FutureProvider<List<Pokemon>>((ref) async {
  final response = await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=100'));
  if (response.statusCode == 200) {
    final data = json.decode(response.body); // Decodifica la respuesta JSON.
    final List<Pokemon> pokemons = (data['results'] as List)// Mapea los resultados JSON a una lista de objetos Pokémon.
        .map((json) => Pokemon.fromJson(json))
        .toList();
    return pokemons;
  } else {
     // Lanza una excepción si la carga de Pokémon falla.
    throw Exception('Failed to load Pokemon');
  }
});
