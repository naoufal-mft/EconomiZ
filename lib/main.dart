import 'package:flutter/material.dart';
import 'login_page.dart';
import 'home_page.dart';
import 'depenses_page.dart';
import 'ideas_page.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
<<<<<<< HEAD
      initialRoute: '/home',
=======
      initialRoute: '/BudgetIdeas',
>>>>>>> 29a48ea9ed11824f9c08f96238e888298909e2c0
      routes: {
        '/login': (context) => CustomLoginPage(),
        '/home': (context) => HomePage(),
        '/depenses': (context) => depenses(),
        '/BudgetIdeas': (context) => BudgetIdeas(),
      },
    );
  }
}