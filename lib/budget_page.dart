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

  void addAmountToCategory(String categoryName, double amount) {
    setState(() {
      categoryAmounts.update(categoryName, (value) => value + amount);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gestion du Budget'),
        backgroundColor: Color(0xFFFFD700),
      ),
      backgroundColor: Color(0xFF2C2C2C), // Couleur de fond sombre
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
                  ),
                  SizedBox(height: 10.0),
                  CategoryItem(
                    categoryName: 'Dépenses',
                    amount: categoryAmounts['Dépenses']!,
                    icon: Icons.shopping_cart,
                    onAddAmount: (amount) {
                      addAmountToCategory('Dépenses', amount);
                    },
                  ),
                  SizedBox(height: 10.0),
                  CategoryItem(
                    categoryName: 'Charges',
                    amount: categoryAmounts['Charges']!,
                    icon: Icons.home,
                    onAddAmount: (amount) {
                      addAmountToCategory('Charges', amount);
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

  CategoryItem({
    required this.categoryName,
    required this.amount,
    required this.icon,
    required this.onAddAmount,
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
          color: Color(0xFFFFD700), // Couleur de l'icône en or
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
        trailing: ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AmountDialog(
                onAddAmount: onAddAmount,
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            primary: Color(0xFFFFD700),
            shape: CircleBorder(),
            padding: EdgeInsets.all(10.0),
          ),
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class AmountDialog extends StatefulWidget {
  final Function(double) onAddAmount;

  AmountDialog({required this.onAddAmount});

  @override
  _AmountDialogState createState() => _AmountDialogState();
}

class _AmountDialogState extends State<AmountDialog> {
  TextEditingController amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Ajouter un Montant'),
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
            widget.onAddAmount(amount);
            Navigator.pop(context);
          },
          child: Text('Ajouter'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Annuler'),
        ),
      ],
    );
  }
}
