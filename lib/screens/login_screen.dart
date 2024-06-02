import 'package:flutter/material.dart';
import 'pokemon_list_screen.dart'; // Importa la pantalla principa
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() {
    // Aquí puedes agregar la lógica de autenticación con Firebase u otro backend
    // Simulamos un inicio de sesión exitoso
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const PokemonListScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('https://i.pinimg.com/1200x/59/04/4b/59044bbcb0e4cccf82635e0c08ced47b.jpg'), // URL de tu imagen de fondo
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    fillColor: Colors.transparent, // Fondo blanco del campo de texto
                    filled: true,
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    fillColor: Colors.transparent, // Fondo blanco del campo de texto
                    filled: true,
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _login,
                  child: const Text('Login'),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    // Aquí puedes agregar la navegación para ir a la pantalla de registro
                  },
                  child: const Text('Registrarse'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(const MyApp());
}

ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (_, ThemeMode currentMode, __) {
        return MaterialApp(
          title: 'Pokémon App',
          theme: ThemeData(
            primarySwatch: Colors.brown,
            brightness: Brightness.light,
            primaryColor: const Color(0xFFD7CCC8), // Beige claro
            scaffoldBackgroundColor: Colors.white, // Fondo blanco en tema claro
            appBarTheme: const AppBarTheme(
              color: Color(0xFFD7CCC8), // Beige claro
            ),
            drawerTheme: const DrawerThemeData(
              backgroundColor: Color(0xFFF5F5F5), // Beige claro
            ),
          ),
          darkTheme: ThemeData(
            primarySwatch: Colors.grey,
            brightness: Brightness.dark,
            primaryColor: Colors.black,
            scaffoldBackgroundColor: Colors.black, // Fondo negro en tema oscuro
            appBarTheme: const AppBarTheme(
              color: Colors.black,
            ),
            drawerTheme: const DrawerThemeData(
              backgroundColor: Colors.black,
            ),
          ),
          themeMode: currentMode, // Controla el modo del tema desde el notifier
          home: const LoginScreen(), // Iniciamos con la pantalla de inicio de sesión
        );
      },
    );
  }
}
