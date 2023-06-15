import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'parametre.dart';
import 'package:flutter_translate/flutter_translate.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Paramètres',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}




class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Paramètres'),
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
            MonProfilPage(),
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
