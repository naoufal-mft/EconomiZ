import 'package:flutter/material.dart';
import 'login_page.dart';
import 'registration_page.dart';
import 'splash_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mon Application',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/inscription': (context) => RegistrationPage(),
      },
    );
  }
}
