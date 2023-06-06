import 'package:flutter/material.dart';
import 'login_page.dart'; // Importez la page de connexion

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Votre application',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(), // Lancez la page de connexion comme page d'accueil
    );
  }
}
