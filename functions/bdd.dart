import 'package:sqflite/sqflite.dart';
import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
Future<void> createDatabase() async {
  final databasePath = '';

  final database = await openDatabase(databasePath);
  final batch = database.batch();

  batch.execute('''
    CREATE TABLE IF NOT EXISTS coordonnees (
      idUser INTEGER NOT NULL,
      Nom TEXT NOT NULL,
      Prenom TEXT NOT NULL,
      PRIMARY KEY (idUser)
    )
  ''');

  batch.execute('''
    CREATE TABLE IF NOT EXISTS auth (
      iduser INTEGER NOT NULL,
      mail TEXT NOT NULL,
      mdp TEXT NOT NULL,
      PRIMARY KEY (iduser),
      FOREIGN KEY (iduser) REFERENCES coordonnees (idUser) ON DELETE CASCADE
    )
  ''');

  batch.execute('''
    CREATE TABLE IF NOT EXISTS charge (
      idcharge INTEGER NOT NULL,
      nom_charge TEXT NOT NULL,
      prix TEXT NOT NULL,
      type TEXT NOT NULL,
      iduser INTEGER NOT NULL,
      PRIMARY KEY (idcharge),
      FOREIGN KEY (iduser) REFERENCES coordonnees (idUser) ON DELETE CASCADE
    )
  ''');

  batch.execute('''
    CREATE TABLE IF NOT EXISTS info (
      idinfo INTEGER NOT NULL,
      iduser INTEGER NOT NULL,
      sit_familial TEXT NOT NULL,
      region TEXT NOT NULL,
      nbr_enfant TEXT NOT NULL,
      revenu TEXT NOT NULL,
      PRIMARY KEY (idinfo),
      FOREIGN KEY (iduser) REFERENCES coordonnees (idUser) ON DELETE CASCADE
    )
  ''');

  await batch.commit();
  await database.close();
}

void main() async {
  await createDatabase();

}
