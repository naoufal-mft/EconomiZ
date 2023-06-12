import 'package:flutter/material.dart';
import 'registration_page.dart';
import 'budget_page.dart';
import 'basedd.dart';

class CustomLoginPage extends StatelessWidget {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan.shade900,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Center(
                  child: ShaderMask(
                    blendMode: BlendMode.srcATop,
                    shaderCallback: (Rect bounds) {
                      return LinearGradient(
                        colors: [
                          Colors.white,
                          Colors.white38.withOpacity(0.8),
                          Colors.transparent,
                        ],
                        stops: [0.0, 0.4, 1.0],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ).createShader(bounds);
                    },
                    child: Image.asset(
                      'assets/user.png',
                      width: 400.0,
                      height: 400.0,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Center(
                child: TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    labelText: 'Adresse mail',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              Center(
                child: TextField(
                  controller: passwordController,
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
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () async {
                  String username = usernameController.text;
                  String password = passwordController.text;
                  print("Username: $username");
                  print("Password: $password");
                  basedd bdd = basedd();
                  await bdd.initialDb();
                  bool isAuthenticated = await bdd.authenticate(username, password);
                  if (isAuthenticated) {
                    // Authentification réussie, effectuez les actions souhaitées
                    print("Authentification réussie !");
                  } else {
                    // Authentification échouée, affichez un message d'erreur ou effectuez d'autres actions
                    print("Nom d'utilisateur ou mot de passe incorrect !");
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.cyan,
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegistrationPage(),
                    ),
                  );
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
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Aide'),
                        content: Text('Voici une description de l\'application.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Fermer',
                              style: TextStyle(color: Colors.cyan),
                            ),
                          ),
                        ],
                      ),
                    );
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