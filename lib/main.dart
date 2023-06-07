import 'package:flutter/material.dart';
import 'login_page.dart'; // Importez le fichier login_page.dart que vous avez créé

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mon Application',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CustomLoginPage(), // Utilisez la page de connexion personnalisée que vous avez créée
    );
  }
}
