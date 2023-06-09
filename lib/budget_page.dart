import 'package:flutter/material.dart';

class BudgetPage extends StatefulWidget {
  @override
  _BudgetPageState createState() => _BudgetPageState();
}

class _BudgetPageState extends State<BudgetPage> {
  Map<String, double> categoryAmounts = {
    'Revenus': 0.0,
    'Dépenses': 0.0,
    'Charges': 0.0,
    'Épargne': 0.0,
  };

  Map<String, double> subcategoryAmounts = {
    'Loyer': 0.0,
    'Abonnements': 0.0,
    // Ajoutez d'autres sous-catégories ici
  };

  void addAmountToCategory(String categoryName, double amount) {
    setState(() {
      categoryAmounts.update(categoryName, (value) => value + amount);
    });
  }

  void subtractAmountFromCategory(String categoryName, double amount) {
    setState(() {
      categoryAmounts.update(categoryName, (value) => value - amount);
    });
  }

  void addAmountToSubcategory(String subcategoryName, double amount) {
    setState(() {
      subcategoryAmounts.update(subcategoryName, (value) => value + amount);
    });
  }

  void subtractAmountFromSubcategory(String subcategoryName, double amount) {
    setState(() {
      subcategoryAmounts.update(subcategoryName, (value) => value - amount);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gestion du Budget'),
        backgroundColor: Colors.orange,
      ),
      backgroundColor: Colors.white24, // Couleur de fond sombre
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                'Total des Catégories',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Couleur du texte en blanc
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  CategoryItem(
                    categoryName: 'Revenus',
                    amount: categoryAmounts['Revenus']!,
                    icon: Icons.attach_money,
                    onAddAmount: (amount) {
                      addAmountToCategory('Revenus', amount);
                    },
                    onSubtractAmount: (amount) {
                      subtractAmountFromCategory('Revenus', amount);
                    },
                  ),
                  SizedBox(height: 10.0),
                  CategoryItem(
                    categoryName: 'Dépenses',
                    amount: categoryAmounts['Dépenses']!,
                    icon: Icons.shopping_cart,
                    onAddAmount: (amount) {
                      addAmountToCategory('Dépenses', amount);
                    },
                    onSubtractAmount: (amount) {
                      subtractAmountFromCategory('Dépenses', amount);
                    },
                  ),
                  SizedBox(height: 10.0),
                  SubcategoryItem(
                    subcategoryName: 'Charges',

                    subcategoryAmounts: subcategoryAmounts,
                    icon: Icons.home,

                    onAddAmount: (subcategoryName, amount) {
                      addAmountToSubcategory(subcategoryName, amount);
                    },
                    onSubtractAmount: (subcategoryName, amount) {
                      subtractAmountFromSubcategory(subcategoryName, amount);
                    },
                  ),
                  SizedBox(height: 10.0),
                  CategoryItem(
                    categoryName: 'Épargne',
                    amount: categoryAmounts['Épargne']!,
                    icon: Icons.pie_chart,
                    onAddAmount: (amount) {
                      addAmountToCategory('Épargne', amount);
                    },
                    onSubtractAmount: (amount) {
                      subtractAmountFromCategory('Épargne', amount);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final String categoryName;
  final double amount;
  final IconData icon;
  final Function(double) onAddAmount;
  final Function(double) onSubtractAmount;

  CategoryItem({
    required this.categoryName,
    required this.amount,
    required this.icon,
    required this.onAddAmount,
    required this.onSubtractAmount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        leading: Icon(
          icon,
          size: 40.0,
          color: Colors.orangeAccent, // Couleur de l'icône en or
        ),
        title: Text(
          categoryName,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          'Montant: \$${amount.toStringAsFixed(2)}',
          style: TextStyle(fontSize: 16.0),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AmountDialog(
                    onAmountChanged: onAddAmount,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.orange,
                shape: CircleBorder(),
                padding: EdgeInsets.all(10.0),
              ),
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 10.0),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AmountDialog(
                    onAmountChanged: onSubtractAmount,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
                shape: CircleBorder(),
                padding: EdgeInsets.all(10.0),
              ),
              child: Icon(
                Icons.remove,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SubcategoryItem extends StatelessWidget {
  final String subcategoryName;
  final Map<String, double> subcategoryAmounts;
  final IconData icon;
  final Function(String, double) onAddAmount;
  final Function(String, double) onSubtractAmount;

  SubcategoryItem({
    required this.subcategoryName,
    required this.subcategoryAmounts,
    required this.icon,
    required this.onAddAmount,
    required this.onSubtractAmount,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      leading: Icon(
        icon,
        size: 40.0,
        color: Colors.orangeAccent, // Couleur de l'icône en or
      ),
      title: Text(
        subcategoryName,
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      children: subcategoryAmounts.keys.map((String key) {
        return ListTile(
          title: Text(key),
          subtitle: Text(
            'Montant: \$${subcategoryAmounts[key]!.toStringAsFixed(2)}',
            style: TextStyle(fontSize: 16.0),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AmountDialog(
                      onAmountChanged: (amount) {
                        onAddAmount(key, amount);
                      },
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.orange,
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(10.0),
                ),
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 10.0),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AmountDialog(
                      onAmountChanged: (amount) {
                        onSubtractAmount(key, amount);
                      },
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(10.0),
                ),
                child: Icon(
                  Icons.remove,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class AmountDialog extends StatefulWidget {
  final Function(double) onAmountChanged;

  AmountDialog({required this.onAmountChanged});

  @override
  _AmountDialogState createState() => _AmountDialogState();
}

class _AmountDialogState extends State<AmountDialog> {
  TextEditingController amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Modifier le Montant'),
      content: TextField(
        controller: amountController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: 'Montant',
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            double amount = double.tryParse(amountController.text) ?? 0.0;
            widget.onAmountChanged(amount);
            Navigator.pop(context);
          },
          child: Text(
            'Confirmer',
            style: TextStyle(color: Colors.orange), // Changer la couleur du texte en bleu
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'Annuler',
            style: TextStyle(color: Colors.red), // Changer la couleur du texte en bleu
          ),
        ),
      ],
    );
  }
}
