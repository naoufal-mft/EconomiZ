import 'package:flutter/material.dart';

class CustomLoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Center(
                  child: Image.asset(
                    'assets/logo2.png', // Remplacez "mon_logo.png" par le chemin de votre propre fichier de logo
                    width: 200.0,
                    height: 200.0,
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Nom d\'utilisateur',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Mot de passe',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                obscureText: true,
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  // Actions à effectuer lors de la connexion
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                ),
                child: Text(
                  'Se connecter',
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
              SizedBox(height: 10.0),
              TextButton(
                onPressed: () {
                  // Actions à effectuer lors de l'inscription
                },
                child: Text(
                  'S\'inscrire',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              Spacer(),
              Align(
                alignment: Alignment.bottomRight,
                child: IconButton(
                  onPressed: () {
                    // Actions à effectuer lors du clic sur le bouton d'aide
                  },
                  icon: Icon(
                    Icons.help,
                    color: Colors.white,
                    size: 30.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
