// lib/models/pokemon.dart
class Pokemon {
  // Propiedades finales (inmutables) de la clase Pokemon.
  final String name;
  final String imageUrl;
  final List<String> types;
  final List<String> abilities;
  final int baseAttack;
  final int baseDefense;
  final int baseSpeed;

// Constructor de la clase Pokemon que requiere todos los atributos.
  Pokemon({
    required this.name,
    required this.imageUrl,
    required this.types,
    required this.abilities,
    required this.baseAttack,
    required this.baseDefense,
    required this.baseSpeed,
  });

 // Fábrica que crea una instancia de Pokemon a partir de un JSON.
  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      name: json['name'],
      imageUrl: json['sprites']['front_default'],
      types: (json['types'] as List<dynamic>)
          .map((typeInfo) => typeInfo['type']['name'] as String)
          .toList(),
      abilities: (json['abilities'] as List<dynamic>)
          .map((abilityInfo) => abilityInfo['ability']['name'] as String)
          .toList(),
      baseAttack: json['stats'][1]['base_stat'],
      baseDefense: json['stats'][2]['base_stat'],
      baseSpeed: json['stats'][5]['base_stat'],
    );
  }
}
