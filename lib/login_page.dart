import 'package:flutter/material.dart';
import 'basedd.dart';
import 'registration_page.dart';
import 'budget_page.dart';

class CustomLoginPage extends StatefulWidget {
  @override
  _CustomLoginPageState createState() => _CustomLoginPageState();
}

class _CustomLoginPageState extends State<CustomLoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController reponseQuestionController = TextEditingController();
  String? selectedQuestion;
  List<String> questions = [
    'Quel est le nom de votre ville natale ?',
    'Quel est le nom de votre meilleur ami ?',
  ];

  bool isQuestionAnswered = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.lightBlue.shade900,
              Colors.lightBlue.shade500,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
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
                            Colors.white.withOpacity(0.2),
                            Colors.transparent,
                          ],
                          stops: [0.0, 0.8, 1.0],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ).createShader(bounds);
                      },
                      child: Image.asset(
                        'assets/user.png',
                        width: 250.0,
                        height: 250.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 5.0),
                Center(
                  child: TextField(
                    controller: emailController,
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
                  onPressed: () {
                    // Actions à effectuer lors de la connexion
                    String email = emailController.text;
                    String password = passwordController.text;
                    // Faites quelque chose avec l'e-mail et le mot de passe (vérification, connexion, etc.)
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
                    "S'inscrire",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Mot de passe oublié'),
                        content: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxWidth: MediaQuery.of(context).size.width - 100, // Ajustez la valeur selon vos besoins
                                ),
                                child: DropdownButtonFormField<String>(
                                  value: selectedQuestion,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedQuestion = newValue;
                                      isQuestionAnswered = false;
                                    });
                                  },
                                  isExpanded: true, // Permet d'élargir le champ pour afficher toutes les questions
                                  items: questions.map((String question) {
                                    return DropdownMenuItem<String>(
                                      value: question,
                                      child: Text(question),
                                    );
                                  }).toList(),
                                  decoration: InputDecoration(
                                    labelText: 'Question de sécurité',
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.0),
                              TextFormField(
                                controller: reponseQuestionController,
                                decoration: InputDecoration(
                                  labelText: 'Réponse à la question',
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () async {
                              basedd database = basedd();
                              if (selectedQuestion != null &&
                                  reponseQuestionController.text.isNotEmpty) {

                                String question = selectedQuestion!;
                                String reponse = reponseQuestionController.text;
                                String mail=emailController.text;
                                bool isQuestionAnswered = await database.fortgot_password(mail,question,reponse);

                                // Vérifier la réponse à la question
                                if (isQuestionAnswered) {
                                  // Actions à effectuer si la réponse est correcte pour la première question
                                  setState(() {
                                    this.isQuestionAnswered = true;
                                  });
                                  Navigator.pop(context);
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: Text('Réinitialiser le mot de passe'),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text('Entrez un nouveau mot de passe'),
                                          TextField(
                                            onChanged: (newPassword) async {
                                              await database.updateData('UPDATE auth  SET mdp = "$newPassword" WHERE iduser=2');
                                              // Do something with the new password
                                            },
                                          ),
                                        ],
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            // Réinitialiser le mot de passe
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            'Valider',
                                            style: TextStyle(color: Colors.cyan),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }  else {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: Text('Erreur'),
                                      content: Text('La réponse à la question de sécurité est incorrecte.'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            'OK',
                                            style: TextStyle(color: Colors.cyan),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              }
                            },
                            child: Text(
                              'Valider',
                              style: TextStyle(color: Colors.cyan),
                            ),
                          ),
                        ],
                      ),
                    ).then((value) {
                      // Réinitialiser les champs
                      reponseQuestionController.clear();
                      setState(() {
                        selectedQuestion = null;
                      });
                    });
                  },
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                  ),
                  child: Text(
                    'Mot de passe oublié ?',
                    style: TextStyle(
                      fontSize: 16.0,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
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
      ),
    );
  }
}