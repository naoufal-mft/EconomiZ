import 'package:flutter/material.dart';
import 'basedd.dart';


class Charge {
  String nom;
  double montant;
  IconData icone; // Nouvelle propriété pour l'icône de la charge

  Charge({required this.nom, required this.montant, required this.icone});
}

class ChargesPage extends StatefulWidget {
  @override
  _ChargesPageState createState() => _ChargesPageState();
}

class _ChargesPageState extends State<ChargesPage> {
  List<Charge> charges = [
    Charge(nom: 'Loyer', montant: 0, icone: Icons.home),
    Charge(nom: 'Factures', montant: 0, icone: Icons.receipt),
    Charge(nom: 'Électricité', montant: 0, icone: Icons.flash_on),
    Charge(nom: 'Eau', montant: 0, icone: Icons.opacity),
    Charge(nom: 'Gaz', montant: 0, icone: Icons.fireplace),
    Charge(nom: 'Abonnement mobile', montant: 0, icone: Icons.phone),
  ];

  TextEditingController nomController = TextEditingController();
  TextEditingController montantController = TextEditingController();

  Future<void> ajouterCharge(String nom, double montant) async {
    basedd database = basedd();

    // Convertir le montant en chaîne de caractères
    String montantStr = montant.toString();

    // Insérer les données dans la table "charge"
    String insertQuery = "INSERT INTO charge(nom_charge, prix, type ,iduser) VALUES('$nom', '$montantStr', 'Fixe','1')";
    await database.insertData(insertQuery);
    nomController.clear();
    montantController.clear();
  }


  void modifierCharge(int index, double montantModifie) {
    setState(() {
      charges[index].montant += montantModifie;
    });
  }

  void supprimerCharge(int index) {
    setState(() {
      charges.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Charges'),
        backgroundColor: Colors.cyan,
      ),
      backgroundColor: Colors.cyan.shade900,
      body: Column(
        children: [
          SizedBox(height: 20.0),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                TextField(
                  controller: nomController,
                  decoration: InputDecoration(
                    labelText: 'Nom de la charge',
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                SizedBox(height: 10.0),
                TextField(
                  controller: montantController,
                  decoration: InputDecoration(
                    labelText: 'Montant',
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 10.0),
                ElevatedButton(
                  onPressed: () {
                    String nom = nomController.text.trim();
                    double montant = double.tryParse(montantController.text) ?? 0.0;
                    if (nom.isNotEmpty && montant > 0) {
                      ajouterCharge(nom, montant);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.teal.shade500,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Text(
                    'Ajouter',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.0),
          Expanded(
            child: ListView.builder(
              itemCount: charges.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(
                    charges[index].icone,
                    color: Colors.white,
                  ),
                  title: Text(
                    charges[index].nom,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  subtitle: Text(
                    'Montant : ${charges[index].montant} €',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                    ),
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => ModifierChargeDialog(
                        charge: charges[index],
                        onMontantModifie: (montantModifie) {
                          modifierCharge(index, montantModifie);
                        },
                      ),
                    );
                  },
                  trailing: IconButton(
                    onPressed: () {
                      supprimerCharge(index);
                    },
                    icon: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                );
              },

            ),
          ),
          ElevatedButton(
            onPressed: () async {
              // Logique du bouton OK
              for (Charge charge in charges) {
                String nom = charge.nom;
                double montant = charge.montant;

                print(nom);
                print(montant);

                if (nom.isNotEmpty && montant > 0) {
                  await ajouterCharge(nom, montant);
                }


              }
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.teal.shade500,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal:50),

            ),
            child: Text(
              'OK',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class ModifierChargeDialog extends StatefulWidget {
  final Charge charge;
  final Function(double) onMontantModifie;

  ModifierChargeDialog({
    required this.charge,
    required this.onMontantModifie,
  });

  @override
  _ModifierChargeDialogState createState() => _ModifierChargeDialogState();
}

class _ModifierChargeDialogState extends State<ModifierChargeDialog> {
  TextEditingController montantController = TextEditingController();

  @override
  void initState() {
    super.initState();
    montantController.text = widget.charge.montant.toString();

  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Modifier la Charge'),
      content: TextField(
        controller: montantController,
        decoration: InputDecoration(
          labelText: 'Montant',
        ),
        keyboardType: TextInputType.number,
      ),
      actions: [
        TextButton(
          onPressed: () {
            double montantModifie = double.tryParse(montantController.text) ?? 0.0;
            if (montantModifie != 0.0) {
              widget.onMontantModifie(montantModifie);
            }
            Navigator.pop(context);
          },
          child: Text(
            'Enregistrer',
            style: TextStyle(color: Colors.teal.shade500),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'Annuler',
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    );
  }
}