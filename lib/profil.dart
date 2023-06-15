import 'package:flutter/material.dart';
import 'parametre.dart';

class ProfilePage extends StatelessWidget {
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
    );
  }
}
