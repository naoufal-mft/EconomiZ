import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page de connexion'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo de l'application
            Image.asset(
              'assets/logo.png',
              width: 150,
              height: 150,
            ),
            SizedBox(height: 32.0),
            // Champ de texte pour l'adresse e-mail
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Adresse e-mail',
              ),
            ),
            SizedBox(height: 16.0),
            // Champ de texte pour le mot de passe
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Mot de passe',
              ),
              obscureText: true,
            ),
            SizedBox(height: 32.0),
            // Bouton pour se connecter
            ElevatedButton(
              onPressed: () {
                // Ajoutez ici la logique de connexion
                String email = _emailController.text;
                String password = _passwordController.text;
                // Vérifiez les informations d'identification et effectuez les actions nécessaires (par exemple, navigation vers une autre page)
              },
              child: Text('Se connecter'),
            ),
            SizedBox(height: 16.0),
            // Bouton pour s'inscrire
            OutlinedButton(
              onPressed: () {
                // Ajoutez ici la logique pour rediriger l'utilisateur vers la page d'inscription
              },
              child: Text('S\'inscrire'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Ajoutez ici la logique pour gérer le bouton d'aide
        },
        child: Icon(Icons.help),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
