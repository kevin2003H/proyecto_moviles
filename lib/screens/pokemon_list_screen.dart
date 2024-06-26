// pokemon_list_screen.dart

import 'package:flutter/material.dart';
import '../service/api.dart';
import '../models/pokemon.dart';
import 'pokemon_detail_screen.dart';
import '../main.dart'; // Importar themeNotifier

class PokemonListScreen extends StatefulWidget {
  const PokemonListScreen({super.key});

  @override
  _PokemonListScreenState createState() => _PokemonListScreenState();
}

class _PokemonListScreenState extends State<PokemonListScreen> { // Define el estado asociado a PokemonListScreen.
  late Future<List<Pokemon>> _pokemonListFuture; // Variable que almacena el futuro de la lista de Pokémon.
  List<Pokemon> _pokemonList = [];// Lista completa de Pokémon.
  List<Pokemon> _filteredPokemonList = [];// Lista filtrada de Pokémon.
  final TextEditingController _searchController = TextEditingController();// Controlador para el campo de búsqueda.

  @override
  void initState() {
    super.initState();
    // Inicializa el futuro de la lista de Pokémon llamando a fetchPokemonList().
    _pokemonListFuture = fetchPokemonList();
    // Añade un listener al controlador de búsqueda para filtrar la lista de Pokémon.
    _searchController.addListener(_filterPokemonList);
  }

// Función para filtrar la lista de Pokémon en función del texto de búsqueda.
  void _filterPokemonList() {
    setState(() {
      _filteredPokemonList = _pokemonList.where((pokemon) {
        return pokemon.name.toLowerCase().contains(_searchController.text.toLowerCase());
      }).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();// Libera los recursos del controlador de búsqueda cuando se destruye el widget.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokémon List'),
        // Barra de búsqueda en la parte inferior de la AppBar.
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search Pokémon',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const UserAccountsDrawerHeader(
              accountName: Text("User Name"),
              accountEmail: Text("user@example.com"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  "U",
                  style: TextStyle(fontSize: 24.0),
                ),
              ),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 187, 158, 147),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('About'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            // Toggle para cambiar entre modo claro y oscuro.
            SwitchListTile(
              title: const Text("Dark Mode"),
              value: themeNotifier.value == ThemeMode.dark,
              onChanged: (value) {
                setState(() {
                  themeNotifier.value =
                      value ? ThemeMode.dark : ThemeMode.light;
                });
              },
              secondary: const Icon(Icons.brightness_6),
            ),
          ],
        ),
      ),
      body: FutureBuilder<List<Pokemon>>(
        // Construcción del cuerpo con un FutureBuilder.
        future: _pokemonListFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            _pokemonList = snapshot.data!;
            _filteredPokemonList = _pokemonList.where((pokemon) {
              return pokemon.name.toLowerCase().contains(_searchController.text.toLowerCase());
            }).toList();
            // Muestra la lista de Pokémon.
            return ListView.builder(
              itemCount: _filteredPokemonList.length,
              itemBuilder: (context, index) {
                final pokemon = _filteredPokemonList[index];
                return ListTile(
                  leading: Image.network(pokemon.imageUrl),
                  title: Text(pokemon.name),
                  onTap: () {
                    // Navega a la pantalla de detalles del Pokémon al hacer clic.
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PokemonDetailScreen(pokemon: pokemon),
                      ),
                    );
                  },
                );
              },
            );
          } else {
            return const Center(child: Text('No Pokémon found.'));
          }
        },
      ),
    );
  }
}
