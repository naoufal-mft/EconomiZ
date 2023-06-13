import 'package:flutter/material.dart';
import 'budget_page.dart';
import 'basedd.dart';
import 'package:intl/intl.dart';

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
  late TextEditingController dateNaissanceEditingController;
  DateTime? selectedDate;
  TextEditingController confirmationMotDePasseController =
  TextEditingController();

  DateTime? selectedDate;
  TextEditingController dateNaissanceController = TextEditingController();

  String? selectedSituationFamiliale;
  List<String> situationsFamiliales = [
    'Célibataire',
    'Marié(e)',
    'Divorcé(e)',
    'Veuf/Veuve'
  ];

  String? selectedRegion;
  List<String> regions = [
    'Région 1',
    'Région 2',
    'Région 3',
    'Région 4',
    'Région 5'
  ];

  TextEditingController nbreEnfantsController = TextEditingController(); // Ajout du champ de texte pour le nombre d'enfants

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
    dateNaissanceEditingController = TextEditingController();

  }

  @override
  void dispose() {
    _controleurAnimation.dispose();
    dateNaissanceEditingController.dispose();
    super.dispose();
  }
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
        dateNaissanceEditingController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
      });
    }
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
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.cyan.shade300, Colors.cyan.shade50],
            ),
          ),
          padding: EdgeInsets.all(20.0),
          child: FadeTransition(
            opacity: _animation,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Champs de texte pour les informations de l'utilisateur
                TextFormField(
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
                SizedBox(height: 20.0),
                TextFormField(
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
                SizedBox(height: 20.0),
                TextFormField(
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
                SizedBox(height: 20.0),
                TextFormField(
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
                SizedBox(height: 20.0),
                TextFormField(
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
                  onPressed: () {
                    // Vérifier les informations de l'utilisateur
                    String nom = nomController.text;
                    String prenom = prenomController.text;
                    String dateNaissance = dateNaissanceController.text;
                    String email = emailController.text;
                    String nomUtilisateur = nomUtilisateurController.text;
                    String motDePasse = motDePasseController.text;
                    String confirmationMotDePasse =
                        confirmationMotDePasseController.text;

                    if (nom.isNotEmpty &&
                        prenom.isNotEmpty &&
                        dateNaissance.isNotEmpty &&
                        email.isNotEmpty &&
                        nomUtilisateur.isNotEmpty &&
                        motDePasse.isNotEmpty &&
                        confirmationMotDePasse.isNotEmpty &&
                        selectedSituationFamiliale != null &&
                        selectedRegion != null) {
                      if (motDePasse == confirmationMotDePasse) {
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
                    backgroundColor: Colors.cyan.shade800,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
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
