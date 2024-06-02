// lib/screens/pokemon_detail_screen.dart
import 'package:flutter/material.dart';
import '../models/pokemon.dart';

class PokemonDetailScreen extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonDetailScreen({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pokemon.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image.network(pokemon.imageUrl, height: 200, width: 200),
            const SizedBox(height: 16),
            Text('Name: ${pokemon.name}', style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 8),
            Text('Types: ${pokemon.types.join(', ')}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text('Abilities: ${pokemon.abilities.join(', ')}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text('Base Attack: ${pokemon.baseAttack}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text('Base Defense: ${pokemon.baseDefense}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text('Base Speed: ${pokemon.baseSpeed}', style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
