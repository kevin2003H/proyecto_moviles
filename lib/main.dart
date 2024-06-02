import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

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
