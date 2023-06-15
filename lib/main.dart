import 'package:flutter/material.dart';
import 'parametre.dart';

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
            MonProfilPage(),
            MotDePassePage(),
            PreferenceNotificationPage(),
            ConfidentialitePage(),
            LanguePage(),
          ],
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/inscription': (context) => RegistrationPage(),
      },
    );
  }
}
