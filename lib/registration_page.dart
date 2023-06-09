import 'package:flutter/material.dart';
import 'budget_page.dart';
import 'basedd.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> with SingleTickerProviderStateMixin {
  late AnimationController _controleurAnimation;
  late Animation<double> _animation;

  TextEditingController nomController = TextEditingController();
  TextEditingController prenomController = TextEditingController();
  TextEditingController dateNaissanceController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nomUtilisateurController = TextEditingController();
  TextEditingController motDePasseController = TextEditingController();
  TextEditingController confirmationMotDePasseController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _controleurAnimation = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );

    _animation = CurvedAnimation(
      parent: _controleurAnimation,
      curve: Curves.easeInOut,
    );

    _controleurAnimation.forward();
  }

  @override
  void dispose() {
    _controleurAnimation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inscription'),
        backgroundColor: Color(0xFFFFD700), // Couleur dorée
      ),
      backgroundColor: Color(0xFF2C2C2C), // Couleur de fond sombre
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: FadeTransition(
            opacity: _animation,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Champs de texte pour les informations de l'utilisateur
                TextField(
                  controller: nomController,
                  decoration: InputDecoration(
                    labelText: 'Nom',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                TextField(
                  controller: prenomController,
                  decoration: InputDecoration(
                    labelText: 'Prénom',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                TextField(
                  controller: dateNaissanceController,
                  decoration: InputDecoration(
                    labelText: 'Date de naissance',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Adresse e-mail',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                TextField(
                  controller: nomUtilisateurController,
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
                  controller: motDePasseController,
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
                SizedBox(height: 10.0),
                TextField(
                  controller: confirmationMotDePasseController,
                  decoration: InputDecoration(
                    labelText: 'Confirmation du mot de passe',
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
                  onPressed: () async {
                    // Vérifier les informations de l'utilisateur
                    String nom = nomController.text;
                    String prenom = prenomController.text;
                    String dateNaissance = dateNaissanceController.text;
                    String email = emailController.text;
                    String nomUtilisateur = nomUtilisateurController.text;
                    String motDePasse = motDePasseController.text;
                    String confirmationMotDePasse = confirmationMotDePasseController.text;

                    if (nom.isNotEmpty &&
                        prenom.isNotEmpty &&
                        dateNaissance.isNotEmpty &&
                        email.isNotEmpty &&
                        nomUtilisateur.isNotEmpty &&
                        motDePasse.isNotEmpty &&
                        confirmationMotDePasse.isNotEmpty) {
                      if (motDePasse == confirmationMotDePasse) {
                        basedd database = basedd();
                        // Insérer les données dans la table "coordonnees"
                        String coordonneesInsertQuery = "INSERT INTO coordonnees(Nom, Prenom) VALUES('$nom', '$prenom')";
                        int insertedCoordonneesId = await database.insertData(coordonneesInsertQuery);
                        // Insérer les données dans la table "auth"
                        String authInsertQuery = "INSERT INTO auth(iduser, mail, mdp) VALUES($insertedCoordonneesId, '$email', '$motDePasse')";
                        int insertedAuthId = await database.insertData(authInsertQuery);
                        // Rediriger vers la page de gestion du budget
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BudgetPage(),
                          ),
                        );
                      } else {
                        // Afficher un message d'erreur si les mots de passe ne correspondent pas
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Erreur'),
                            content: Text('Les mots de passe ne correspondent pas'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('OK'),
                              ),
                            ],
                          ),
                        );
                      }
                    } else {
                      // Afficher un message d'erreur si tous les champs ne sont pas remplis
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Erreur'),
                          content: Text('Veuillez remplir tous les champs'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('OK'),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFFD700), // Couleur dorée
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                  ),
                  child: Text(
                    'S\'inscrire',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}