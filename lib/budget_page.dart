import 'package:flutter/material.dart';

class BudgetPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gestion du Budget'),
      ),
      body: Center(
        child: Text(
          'Page de Gestion du Budget',
          style: TextStyle(fontSize: 20.0),
        ),
      ),
    );
  }
}
