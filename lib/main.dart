import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

// Función principal que se ejecuta al iniciar la aplicación.
void main() {
  runApp(const MyApp());
}
// Definición de un ValueNotifier para gestionar el modo de tema (claro/oscuro).
ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);

// Clase principal de la aplicación, extiende StatelessWidget.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Utiliza ValueListenableBuilder para reconstruir la UI cuando el tema cambia.
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (_, ThemeMode currentMode, __) {
        return MaterialApp(
          title: 'Pokémon App',
          theme: ThemeData(// Tema claro de la aplicación.
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
          darkTheme: ThemeData(// Tema oscuro de la aplicación.
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
