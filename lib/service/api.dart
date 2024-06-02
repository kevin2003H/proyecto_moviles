// lib/service/api.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/pokemon.dart';

Future<List<Pokemon>> fetchPokemonList() async {
  final response = await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=20'));
  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body)['results'];
    final List<Pokemon> pokemonList = await Future.wait(data.map((pokemonJson) async {
      final pokemonInfoResponse = await http.get(Uri.parse(pokemonJson['url']));
      if (pokemonInfoResponse.statusCode == 200) {
        final pokemonInfo = json.decode(pokemonInfoResponse.body);
        return Pokemon.fromJson(pokemonInfo);
      } else {
        throw Exception('Failed to load Pokémon information');
      }
    }).toList());
    return pokemonList;
  } else {
    throw Exception('Failed to load Pokémon list');
  }
}

