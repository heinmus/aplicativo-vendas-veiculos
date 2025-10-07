import 'package:flutter/material.dart';
import 'package:myapp/features/home_screen.dart';
import 'package:myapp/features/details_screen.dart';
import 'package:myapp/features/about_screen.dart';

// ponto de entrada para o aplicativo
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyApp Veículos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: false, 
      ),
      debugShowCheckedModeBanner: false, 
      initialRoute: '/', //rota para a pagina inicial
      routes: {
        '/': (context) => const HomeScreen(),
        '/details': (context) => const DetailsScreen(),
        '/about': (context) => const AboutScreen(),
      },
    );
  }
}
