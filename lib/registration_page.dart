import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  TextEditingController emailController = TextEditingController();
  TextEditingController nomUtilisateurController = TextEditingController();
  TextEditingController motDePasseController = TextEditingController();
  TextEditingController confirmationMotDePasseController = TextEditingController();
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
    'Région 3'
  ];

  TextEditingController nbreEnfantsController =
  TextEditingController(); // Ajout du champ de texte pour le nombre d'enfants

  String? selectedQuestion;
  List<String> questions = [
    'Quel est le nom de votre ville natale ?',
    'Quel est le nom de votre meilleur ami ?',
  ];

  TextEditingController reponseQuestionController = TextEditingController();

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
        dateNaissanceController.text =
            DateFormat('dd/MM/yyyy').format(selectedDate!);
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inscription'),
        backgroundColor: Colors.cyan.shade700,
      ),
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
                  ),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: prenomController,
                  decoration: InputDecoration(
                    labelText: 'Prénom',
                  ),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Adresse e-mail',
                  ),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: nomUtilisateurController,
                  decoration: InputDecoration(
                    labelText: 'Nom d\'utilisateur',
                  ),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: motDePasseController,
                  decoration: InputDecoration(
                    labelText: 'Mot de passe',
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: confirmationMotDePasseController,
                  decoration: InputDecoration(
                    labelText: 'Confirmation du mot de passe',
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 20.0),
                InkWell(
                  onTap: () {
                    _selectDate(context);
                  },
                  child: IgnorePointer(
                    child: TextFormField(
                      controller: dateNaissanceController,
                      decoration: InputDecoration(
                        labelText: 'Date de naissance',
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                DropdownButtonFormField<String>(
                  value: selectedSituationFamiliale,
                  onChanged: (newValue) {
                    setState(() {
                      selectedSituationFamiliale = newValue;
                    });
                  },
                  items: situationsFamiliales.map((situation) {
                    return DropdownMenuItem<String>(
                      value: situation,
                      child: Text(situation),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Situation familiale',
                  ),
                ),
                SizedBox(height: 20.0),
                DropdownButtonFormField<String>(
                  value: selectedRegion,
                  onChanged: (newValue) {
                    setState(() {
                      selectedRegion = newValue;
                    });
                  },
                  items: regions.map((region) {
                    return DropdownMenuItem<String>(
                      value: region,
                      child: Text(region),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Région',
                  ),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: nbreEnfantsController,
                  decoration: InputDecoration(
                    labelText: 'Nombre d\'enfants',
                  ),
                ),
                SizedBox(height: 20.0),
                DropdownButtonFormField<String>(
                  value: selectedQuestion,
                  onChanged: (newValue) {
                    setState(() {
                      selectedQuestion = newValue;
                    });
                  },
                  items: questions.map((question) {
                    return DropdownMenuItem<String>(
                      value: question,
                      child: Text(question),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Question pour récupérer le mot de passe',
                  ),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: reponseQuestionController,
                  decoration: InputDecoration(
                    labelText: 'Réponse à la question',
                  ),
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () async {
                    // Vérifier les informations de l'utilisateur
                    String nom = nomController.text;
                    String prenom = prenomController.text;
                    String email = emailController.text;
                    String nomUtilisateur = nomUtilisateurController.text;
                    String motDePasse = motDePasseController.text;
                    String confirmationMotDePasse = confirmationMotDePasseController.text;
                    String reponseQuestion = reponseQuestionController.text;
                    String nb_enfant = nbreEnfantsController.text;
                    if (nom.isNotEmpty &&
                        prenom.isNotEmpty &&
                        email.isNotEmpty &&
                        nomUtilisateur.isNotEmpty &&
                        motDePasse.isNotEmpty &&
                        confirmationMotDePasse.isNotEmpty &&
                        selectedSituationFamiliale != null &&
                        selectedRegion != null &&
                        selectedQuestion != null &&
                        reponseQuestion.isNotEmpty &&
                        nb_enfant.isNotEmpty) {
                      if (motDePasse == confirmationMotDePasse) {
                        // Rediriger vers la page de gestion du budget
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BudgetPage(
                              nom: nomController.text,
                              prenom: prenomController.text,
                              selectedDate: selectedDate,
                              email: emailController.text,
                              motDePasse: motDePasseController.text,
                              selectedQuestion: selectedQuestion!,
                              reponseQuestion: reponseQuestionController.text,
                              selectedSituationFamiliale: selectedSituationFamiliale!,
                              selectedRegion: selectedRegion!,
                              nb_enfant: nbreEnfantsController.text,
                            ),
                          ),
                        );
                      } else {
                        // Afficher un message d'erreur si les mots de passe ne correspondent pas
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Erreur'),
                            content:
                            Text('Les mots de passe ne correspondent pas'),
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
                    'Suivant',
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