import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'basedd.dart';

class MonProfilPage extends StatefulWidget {
  @override
  _MonProfilPageState createState() => _MonProfilPageState();
}

class _MonProfilPageState extends State<MonProfilPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _dateNaissanceController = TextEditingController();
  TextEditingController _nomController = TextEditingController();
  TextEditingController _adresseController = TextEditingController();
  TextEditingController _telephoneController = TextEditingController();
  DateTime? _selectedDate;
  File? _profileImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Mon profil'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: _pickProfileImage,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: _profileImage != null ? FileImage(_profileImage!) as ImageProvider<Object> : AssetImage('assets/photo_vide.png'),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
              ),
              SizedBox(height: 16.0),
              GestureDetector(
                onTap: () {
                  _selectDate(context);
                },
                child: AbsorbPointer(
                  child: TextField(
                    controller: _dateNaissanceController,
                    decoration: InputDecoration(
                      labelText: 'Date de naissance',
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _nomController,
                decoration: InputDecoration(
                  labelText: 'Nom complet',
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _adresseController,
                decoration: InputDecoration(
                  labelText: 'Adresse',
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _telephoneController,
                decoration: InputDecoration(
                  labelText: 'Numéro de téléphone',
                ),
                keyboardType: TextInputType.phone,
              ),

              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // Code pour enregistrer les modifications du profil
                  String newEmail = _emailController.text;
                  String newDateNaissance = DateFormat('dd/MM/yyyy').format(_selectedDate!);
                  String newNom = _nomController.text;
                  String newAdresse = _adresseController.text;
                  String newTelephone = _telephoneController.text;
                  // Code pour effectuer les opérations nécessaires avec les nouvelles informations du profil
                },
                child: Text('Enregistrer'),
              ),
              ElevatedButton(
                onPressed: _removeProfileImage,
                child: Text('Supprimer la photo'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateNaissanceController.text = DateFormat('dd/MM/yyyy').format(_selectedDate!);
      });
    }
  }

  Future<void> _pickProfileImage() async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  void _removeProfileImage() {
    setState(() {
      _profileImage = null;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _dateNaissanceController.dispose();
    _nomController.dispose();
    _adresseController.dispose();
    _telephoneController.dispose();
    super.dispose();
  }
}

class MotDePassePage extends StatefulWidget {
  @override
  _MotDePassePageState createState() => _MotDePassePageState();
}

class _MotDePassePageState extends State<MotDePassePage> {
  TextEditingController _ancienMotDePasseController = TextEditingController();
  TextEditingController _nouveauMotDePasseController = TextEditingController();
  TextEditingController _confirmationMotDePasseController =
  TextEditingController();

  String _errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Changer de mot de passe',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16.0),
          TextField(
            controller: _ancienMotDePasseController,
            obscureText: true,
            decoration: InputDecoration(labelText: 'Ancien mot de passe'),
          ),
          SizedBox(height: 16.0),
          TextField(
            controller: _nouveauMotDePasseController,
            obscureText: true,
            decoration: InputDecoration(labelText: 'Nouveau mot de passe'),
          ),
          SizedBox(height: 16.0),
          TextField(
            controller: _confirmationMotDePasseController,
            obscureText: true,
            decoration: InputDecoration(labelText: 'Confirmer le mot de passe'),
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              _changerMotDePasse();
            },
            child: Text('Enregistrer'),
          ),
          if (_errorMessage.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(top: 16.0),
              child: Text(
                _errorMessage,
                style: TextStyle(color: Colors.red),
              ),
            ),
        ],
      ),
    );
  }

  void _changerMotDePasse() {
    String ancienMotDePasse = _ancienMotDePasseController.text;
    String nouveauMotDePasse = _nouveauMotDePasseController.text;
    String confirmationMotDePasse = _confirmationMotDePasseController.text;

    if (ancienMotDePasse.isEmpty ||
        nouveauMotDePasse.isEmpty ||
        confirmationMotDePasse.isEmpty) {
      setState(() {
        _errorMessage = 'Veuillez remplir tous les champs.';
      });
      return;
    }

    if (nouveauMotDePasse != confirmationMotDePasse) {
      setState(() {
        _errorMessage = 'Les mots de passe ne correspondent pas.';
      });
      return;
    }

    // Effectuer les opérations nécessaires pour changer le mot de passe
    // ...

    // Réinitialiser les champs de saisie
    _ancienMotDePasseController.clear();
    _nouveauMotDePasseController.clear();
    _confirmationMotDePasseController.clear();

    setState(() {
      _errorMessage = '';
    });

    // Afficher un message de succès ou de redirection vers une autre page
    // ...
  }
}

class PreferenceNotificationPage extends StatefulWidget {
  @override
  _PreferenceNotificationPageState createState() =>
      _PreferenceNotificationPageState();
}

class _PreferenceNotificationPageState extends State<PreferenceNotificationPage> {
  bool _isNotificationEnabled = true;
  List<String> _selectedNotificationTypes = [];
  String _selectedNotificationFrequency = 'Instantanément';
  bool _isCustomizationEnabled = false;
  bool _isDoNotDisturbModeEnabled = false;
  TimeOfDay _selectedDoNotDisturbStart = TimeOfDay(hour: 22, minute: 0);
  TimeOfDay _selectedDoNotDisturbEnd = TimeOfDay(hour: 8, minute: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Préférence de notification'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          SwitchListTile(
            title: Text('Activer les notifications'),
            value: _isNotificationEnabled,
            onChanged: (value) {
              setState(() {
                _isNotificationEnabled = value;
              });
            },
          ),
          Divider(),
          ListTile(
            title: Text('Types de notifications'),
            subtitle: Text(_selectedNotificationTypes.isEmpty
                ? 'Aucun type sélectionné'
                : _selectedNotificationTypes.join(', ')),
            onTap: () {
              _showNotificationTypesDialog();
            },
          ),
          Divider(),
          ListTile(
            title: Text('Fréquence des notifications'),
            subtitle: Text(_selectedNotificationFrequency),
            onTap: () {
              _showNotificationFrequencyDialog();
            },
          ),
          Divider(),
          SwitchListTile(
            title: Text('Personnaliser les notifications'),
            value: _isCustomizationEnabled,
            onChanged: (value) {
              setState(() {
                _isCustomizationEnabled = value;
              });
            },
          ),
          Divider(),
          SwitchListTile(
            title: Text('Mode "Ne pas déranger"'),
            value: _isDoNotDisturbModeEnabled,
            onChanged: (value) {
              setState(() {
                _isDoNotDisturbModeEnabled = value;
              });
            },
          ),
          ListTile(
            title: Text('Heure de début'),
            subtitle: Text(_selectedDoNotDisturbStart.format(context)),
            onTap: () {
              _showDoNotDisturbTimePicker(true);
            },
          ),
          ListTile(
            title: Text('Heure de fin'),
            subtitle: Text(_selectedDoNotDisturbEnd.format(context)),
            onTap: () {
              _showDoNotDisturbTimePicker(false);
            },
          ),
        ],
      ),
    );
  }

  void _showNotificationTypesDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Types de notifications'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CheckboxListTile(
                title: Text('Nouvelles fonctionnalités'),
                value: _selectedNotificationTypes.contains('Nouvelles fonctionnalités'),
                onChanged: (value) {
                  setState(() {
                    if (value!) {
                      _selectedNotificationTypes.add('Nouvelles fonctionnalités');
                    } else {
                      _selectedNotificationTypes.remove('Nouvelles fonctionnalités');
                    }
                  });
                },
              ),
              CheckboxListTile(
                title: Text('Mises à jour'),
                value: _selectedNotificationTypes.contains('Mises à jour'),
                onChanged: (value) {
                  setState(() {
                    if (value!) {
                      _selectedNotificationTypes.add('Mises à jour');
                    } else {
                      _selectedNotificationTypes.remove('Mises à jour');
                    }
                  });
                },
              ),
              CheckboxListTile(
                title: Text('Rappels'),
                value: _selectedNotificationTypes.contains('Rappels'),
                onChanged: (value) {
                  setState(() {
                    if (value!) {
                      _selectedNotificationTypes.add('Rappels');
                    } else {
                      _selectedNotificationTypes.remove('Rappels');
                    }
                  });
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Fermer'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showNotificationFrequencyDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Fréquence des notifications'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile<String>(
                title: Text('Instantanément'),
                value: 'Instantanément',
                groupValue: _selectedNotificationFrequency,
                onChanged: (value) {
                  setState(() {
                    _selectedNotificationFrequency = value!;
                  });
                  Navigator.of(context).pop();
                },
              ),
              RadioListTile<String>(
                title: Text('Toutes les heures'),
                value: 'Toutes les heures',
                groupValue: _selectedNotificationFrequency,
                onChanged: (value) {
                  setState(() {
                    _selectedNotificationFrequency = value!;
                  });
                  Navigator.of(context).pop();
                },
              ),
              RadioListTile<String>(
                title: Text('Une fois par jour'),
                value: 'Une fois par jour',
                groupValue: _selectedNotificationFrequency,
                onChanged: (value) {
                  setState(() {
                    _selectedNotificationFrequency = value!;
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _showDoNotDisturbTimePicker(bool isStartTime) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: isStartTime ? _selectedDoNotDisturbStart : _selectedDoNotDisturbEnd,
    );
    if (pickedTime != null) {
      setState(() {
        if (isStartTime) {
          _selectedDoNotDisturbStart = pickedTime;
        } else {
          _selectedDoNotDisturbEnd = pickedTime;
        }
      });
    }
  }
}

class ConfidentialitePage extends StatefulWidget {
  @override
  _ConfidentialitePageState createState() => _ConfidentialitePageState();
}

class _ConfidentialitePageState extends State<ConfidentialitePage> {
  bool _isProfileVisible = true;
  String _postVisibility = 'public';
  String _contactEmail = '';
  String _contactPhone = '';
  bool _subscribeToNewsletter = true;
  bool _enablePushNotifications = true;
  bool _locationPermission = true;
  bool _cameraPermission = true;
  bool _activityLogging = false;
  String _defaultPostVisibility = 'public';
  bool _enableSecureMessaging = true;
  bool _enableTrackingConsent = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confidentialité'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          SwitchListTile(
            title: Text('Visibilité du profil'),
            value: _isProfileVisible,
            onChanged: (value) {
              setState(() {
                _isProfileVisible = value;
              });
            },
          ),
          ListTile(
            title: Text('Confidentialité des publications'),
            subtitle: Text('Qui peut voir vos publications'),
            trailing: DropdownButton<String>(
              value: _postVisibility,
              onChanged: (newValue) {
                setState(() {
                  _postVisibility = newValue!;
                });
              },
              items: <String>[
                'public',
                'amis uniquement',
                'privé',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          TextFormField(
            initialValue: _contactEmail,
            decoration: InputDecoration(labelText: 'Adresse e-mail'),
            onChanged: (value) {
              setState(() {
                _contactEmail = value;
              });
            },
          ),
          TextFormField(
            initialValue: _contactPhone,
            decoration: InputDecoration(labelText: 'Numéro de téléphone'),
            onChanged: (value) {
              setState(() {
                _contactPhone = value;
              });
            },
          ),
          SwitchListTile(
            title: Text('Abonnement aux newsletters'),
            value: _subscribeToNewsletter,
            onChanged: (value) {
              setState(() {
                _subscribeToNewsletter = value;
              });
            },
          ),
          SwitchListTile(
            title: Text('Notifications push'),
            value: _enablePushNotifications,
            onChanged: (value) {
              setState(() {
                _enablePushNotifications = value;
              });
            },
          ),
          SwitchListTile(
            title: Text('Autorisation de localisation'),
            value: _locationPermission,
            onChanged: (value) {
              setState(() {
                _locationPermission = value;
              });
            },
          ),
          SwitchListTile(
            title: Text('Autorisation de la caméra'),
            value: _cameraPermission,
            onChanged: (value) {
              setState(() {
                _cameraPermission = value;
              });
            },
          ),
          SwitchListTile(
            title: Text('Journal d\'activité'),
            value: _activityLogging,
            onChanged: (value) {
              setState(() {
                _activityLogging = value;
              });
            },
          ),
          ListTile(
            title: Text('Visibilité par défaut des publications'),
            subtitle: Text('La visibilité par défaut des nouvelles publications'),
            trailing: DropdownButton<String>(
              value: _defaultPostVisibility,
              onChanged: (newValue) {
                setState(() {
                  _defaultPostVisibility = newValue!;
                });
              },
              items: <String>[
                'public',
                'amis uniquement',
                'privé',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          SwitchListTile(
            title: Text('Messagerie sécurisée'),
            value: _enableSecureMessaging,
            onChanged: (value) {
              setState(() {
                _enableSecureMessaging = value;
              });
            },
          ),
          SwitchListTile(
            title: Text('Consentement de suivi'),
            value: _enableTrackingConsent,
            onChanged: (value) {
              setState(() {
                _enableTrackingConsent = value;
              });
            },
          ),
        ],
      ),
    );
  }
}

class LanguePage extends StatefulWidget {
  @override
  _LanguePageState createState() => _LanguePageState();
}

class _LanguePageState extends State<LanguePage> {
  String _selectedLanguage = 'English'; // Langue par défaut

  List<String> _languages = [
    'English',
    'French',
    'Spanish',
    'German',
    'Italian',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Langue'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Langue'),
            trailing: DropdownButton<String>(
              value: _selectedLanguage,
              onChanged: (newValue) {
                setState(() {
                  _selectedLanguage = newValue!;
                });
              },
              items: _languages.map((language) {
                return DropdownMenuItem<String>(
                  value: language,
                  child: Text(language),
                );
              }).toList(),
            ),
          ),
          ListTile(
            title: Text('Traduction en temps réel'),
            trailing: Switch(
              value: true, // Valeur par défaut activée
              onChanged: (newValue) {
                // Code pour gérer l'activation/désactivation de la traduction en temps réel
              },
            ),
          ),
          ListTile(
            title: Text('Paramètres régionaux'),
            trailing: IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                // Code pour accéder aux paramètres régionaux et les personnaliser
              },
            ),
          ),
          ListTile(
            title: Text('Notifications linguistiques'),
            trailing: Switch(
              value: true, // Valeur par défaut activée
              onChanged: (newValue) {
                // Code pour gérer l'activation/désactivation des notifications linguistiques
              },
            ),
          ),
          ListTile(
            title: Text('Changement de langue de l\'interface utilisateur'),
            trailing: IconButton(
              icon: Icon(Icons.language),
              onPressed: () {
                // Code pour changer la langue de l'interface utilisateur
              },
            ),
          ),
          ListTile(
            title: Text('Téléchargement des packs de langue'),
            trailing: IconButton(
              icon: Icon(Icons.cloud_download),
              onPressed: () {
                // Code pour télécharger et installer des packs de langue supplémentaires
              },
            ),
          ),
          ListTile(
            title: Text('Réinitialisation de la langue par défaut'),
            trailing: IconButton(
              icon: Icon(Icons.restore),
              onPressed: () {
                // Code pour réinitialiser la langue par défaut de l'application
              },
            ),
          ),
        ],
      ),
    );
  }
}
