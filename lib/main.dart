import 'package:economiz/budget_page.dart';
import 'package:flutter/material.dart';
import 'login_page.dart';
import 'registration_page.dart';
import 'splash_page.dart';
import 'Charges_page.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Votre Application',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/inscription': (context) => RegistrationPage(),
        'charge' : (context) => ChargesPage(),
        '/budget':(context)=> BudgetPage(),
      },
    );
  }
}
