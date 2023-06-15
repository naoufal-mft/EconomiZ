import 'package:economiz/parametre.dart';
import 'package:flutter/material.dart';
import 'login_page.dart';
import 'registration_page.dart';
import 'splash_page.dart';
import 'Charges_page.dart';import 'splash_page.dart';

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
      ),initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/inscription': (context) => RegistrationPage(),
        'charge' : (context) => ChargesPage(),
      }
    );
  }
}

class HomePage extends StatelessWidget {
  final String data;
  HomePage({required this.data});
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Mon application'),
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.person)),
              Tab(icon: Icon(Icons.lock)),
              Tab(icon: Icon(Icons.notifications)),
              Tab(icon: Icon(Icons.security)),
              Tab(icon: Icon(Icons.language)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            MonProfilPage(data:data),
            MotDePassePage(),
            PreferenceNotificationPage(),
            ConfidentialitePage(),
            LanguePage(),
          ],
        ),
      ),
    );
  }
}