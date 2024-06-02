//pokemon_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/pokemon.dart';

final pokemonProvider = FutureProvider<List<Pokemon>>((ref) async {
  final response = await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=100'));
  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final List<Pokemon> pokemons = (data['results'] as List)
        .map((json) => Pokemon.fromJson(json))
        .toList();
    return pokemons;
  } else {
    throw Exception('Failed to load Pokemon');
  }
});
