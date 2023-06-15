import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:easy_localization/easy_localization.dart';



class MonProfilPage extends StatefulWidget {
  @override
  _MonProfilPageState createState() => _MonProfilPageState();
}

class _MonProfilPageState extends State<MonProfilPage> {
  TextEditingController _nomController = TextEditingController();
  TextEditingController _dateNaissanceController = TextEditingController();
  TextEditingController _adresseController = TextEditingController();
  TextEditingController _telephoneController = TextEditingController();
  DateTime? _selectedDate;
  File? _profileImage;
  bool _hasProfileImage = false;

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: _showContactInfo,
                    child: Row(
                      children: [
                        Icon(Icons.mail),
                        SizedBox(width: 8.0),
                        Text('Contactez-nous'),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: _pickProfileImage,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: _hasProfileImage
                          ? FileImage(_profileImage!) as ImageProvider<Object>
                          : AssetImage('assets/photo_vide.png'),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _nomController,
                decoration: InputDecoration(
                  labelText: 'Nom complet',
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
                controller: _adresseController,
                decoration: InputDecoration(
                  labelText: 'Adresse mail',
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
                  String newNom = _nomController.text;
                  String newDateNaissance =
                  DateFormat('dd/MM/yyyy').format(_selectedDate!);
                  String newAdresse = _adresseController.text;
                  String newTelephone = _telephoneController.text;
                  // Code pour effectuer les opérations nécessaires avec les nouvelles informations du profil

                  // Afficher le SnackBar
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Les données ont été enregistrées.'),
                    ),
                  );
                },
                child: Text('Enregistrer'),
              ),
              if (_hasProfileImage) // Afficher le bouton de suppression uniquement s'il y a une photo de profil
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
        _dateNaissanceController.text =
            DateFormat('dd/MM/yyyy').format(_selectedDate!);
      });
    }
  }

  Future<void> _pickProfileImage() async {
    final pickedFile =
    await ImagePicker().getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
        _hasProfileImage = true;
      });
    }
  }

  void _removeProfileImage() {
    setState(() {
      _profileImage = null;
      _hasProfileImage = false;
    });
  }

  void _showContactInfo() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Contactez-nous'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Adresse e-mail: my.economiz@outlook.fr'),
              SizedBox(height: 8.0),
              Text('Numéro de téléphone:'),
              Text('+33 5 70809011'),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Fermer'),
            ),
          ],
        );
      },
    );
  }


  @override
  void dispose() {
    _nomController.dispose();
    _dateNaissanceController.dispose();
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Changer de mot de passe'),
      ),
      body: Container(
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
              decoration:
              InputDecoration(labelText: 'Confirmer le mot de passe'),
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

    // Afficher un SnackBar avec le message de succès
    _showSuccessSnackBar('Le mot de passe a été changé avec succès.');
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
      ),
    );
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
            onChanged: _handleProfileVisibilityChanged,
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

  void _handleProfileVisibilityChanged(bool value) {
    setState(() {
      _isProfileVisible = value;
    });
  }
}







class LanguePage extends StatefulWidget {
  @override
  _LanguePageState createState() => _LanguePageState();
}

class _LanguePageState extends State<LanguePage> {
  String _selectedLanguage = 'English';
  bool _realTimeTranslation = false;
  bool _languageNotifications = false;

  List<String> _languages = [
    'English',
    'French',
    'Spanish',
    'German',
    'Italian',
  ];

  void _toggleRealTimeTranslation(bool value) {
    setState(() {
      _realTimeTranslation = value;
      // Code to enable/disable real-time translation
    });
  }

  void _openRegionalSettings() {
    String selectedRegion = 'Sud'; // Default region
    String selectedTimezone = 'Europe/Paris'; // Default timezone

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text('Paramètres régionaux'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title: Text('Région'),
                    trailing: DropdownButton<String>(
                      value: selectedRegion,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedRegion = newValue!;
                        });
                      },
                      items: [
                        'Sud',
                        'Hauts-de-France',
                        'Île-de-France',
                        'Normandie',
                        'Bretagne',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                  ListTile(
                    title: Text('Fuseau horaire'),
                    trailing: DropdownButton<String>(
                      value: selectedTimezone,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedTimezone = newValue!;
                        });
                      },
                      items: [
                        'Europe/Paris',
                        'Europe/London',
                        'Europe/Berlin',
                        'Europe/Rome',
                        'Europe/Madrid',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    // Code to save regional settings and close the dialog
                    Navigator.of(context).pop();
                  },
                  child: Text('Enregistrer'),
                ),
              ],
            );
          },
        );
      },
    );
  }




  void _toggleLanguageNotifications(bool value) {
    setState(() {
      _languageNotifications = value;
      // Code to enable/disable language notifications
    });
  }

  void _changeInterfaceLanguage(String? language) {
    if (language != null) {
      setState(() {
        _selectedLanguage = language;
        // Code to change the interface language
        // This may involve loading new language resources
        // and restarting certain parts of the interface to apply the changes
      });
    }
  }

  void _downloadLanguagePacks() {
    // Code to download and install additional language packs
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Téléchargement des packs de langue'),
          content: Text('Téléchargez et installez des packs de langue supplémentaires ici.'),
          actions: [
            ElevatedButton(
              onPressed: () {
                // Code to start the download process
                Navigator.of(context).pop();
              },
              child: Text('Télécharger'),
            ),
          ],
        );
      },
    );
  }

  void _resetDefaultLanguage() {
    // Code to reset the application's default language
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Réinitialisation de la langue par défaut'),
          content: Text('Êtes-vous sûr de vouloir réinitialiser la langue par défaut ?'),
          actions: [
            ElevatedButton(
              onPressed: () {
                // Code to reset the default language
                Navigator.of(context).pop();
              },
              child: Text('Réinitialiser'),
            ),
          ],
        );
      },
    );
  }

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
              onChanged: _changeInterfaceLanguage,
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
              value: _realTimeTranslation,
              onChanged: _toggleRealTimeTranslation,
            ),
          ),
          ListTile(
            title: Text('Paramètres régionaux'),
            trailing: IconButton(
              icon: Icon(Icons.settings),
              onPressed: _openRegionalSettings,
            ),
          ),
          ListTile(
            title: Text('Notifications linguistiques'),
            trailing: Switch(
              value: _languageNotifications,
              onChanged: _toggleLanguageNotifications,
            ),
          ),
          ListTile(
            title: Text('Téléchargement des packs de langue'),
            trailing: IconButton(
              icon: Icon(Icons.cloud_download),
              onPressed: _downloadLanguagePacks,
            ),
          ),
          ListTile(
            title: Text('Réinitialisation de la langue par défaut'),
            trailing: IconButton(
              icon: Icon(Icons.restore),
              onPressed: _resetDefaultLanguage,
            ),
          ),
        ],
      ),
    );
  }
}
