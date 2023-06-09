import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';

class basedd {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await initialDb();
      return _db;
    } else {
      return _db;
    }
  }

  initialDb() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, 'budget.db');
    Database mydb = await openDatabase(
        path,version:1, onCreate: _onCreate, onUpgrade: _onUpgrade);
    return mydb;
  }

  _onUpgrade(Database db, int oldversion, int newversion) {

  }

  _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS coordonnees (
      idUser  INTEGER PRIMARY KEY AUTOINCREMENT,
      Nom TEXT NOT NULL,
      Prenom TEXT NOT NULL
      
    )
    
    ''');
    await db.execute('''
    CREATE TABLE IF NOT EXISTS auth (
      iduser INTEGER NOT NULL,
      mail TEXT NOT NULL,
      mdp TEXT NOT NULL,
      
      FOREIGN KEY (iduser) REFERENCES coordonnees (idUser) ON DELETE CASCADE
    )
    
    ''');
    await db.execute('''
    CREATE TABLE IF NOT EXISTS charge (
      idcharge  INTEGER PRIMARY KEY AUTOINCREMENT,
      nom_charge TEXT NOT NULL,
      prix TEXT NOT NULL,
      type TEXT NOT NULL,
      iduser INTEGER NOT NULL,
     
      FOREIGN KEY (iduser) REFERENCES coordonnees (idUser) ON DELETE CASCADE
    )
    
    ''');
    await db.execute('''
    CREATE TABLE IF NOT EXISTS info (
      idinfo  INTEGER PRIMARY KEY AUTOINCREMENT,
      iduser INTEGER NOT NULL,
      sit_familial TEXT NOT NULL,
      region TEXT NOT NULL,
      nbr_enfant TEXT NOT NULL,
      revenu TEXT NOT NULL,
      
      FOREIGN KEY (iduser) REFERENCES coordonnees (idUser) ON DELETE CASCADE
    )
    
    ''');
    print(" onCreate =====================================");
  }

  readData(String sql) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery(sql);
    return response;
  }

  insertData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawInsert(sql);
    return response;
  }

  updateData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawUpdate(sql);
    return response;
  }

  deleteData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawDelete(sql);
    return response;
  }

  Future<bool> authenticate(String username, String password) async {
    String sql = "SELECT * FROM auth WHERE mail = '$username' AND mdp = '$password'";
    List<Map> result = await readData(sql);
    return result.isNotEmpty;
  }

}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  basedd bdd= basedd();
  await bdd.initialDb();

  // Test the insertData function
  int insertedId = await bdd.insertData("INSERT INTO coordonnees(Nom, Prenom) VALUES('John', 'Doe')");
  print('Inserted ID: $insertedId');
  int insertedId2 = await bdd.insertData("INSERT INTO coordonnees(Nom, Prenom) VALUES('John', 'wick')");
  print('Inserted ID: $insertedId2');
  int insertedId3 = await bdd.insertData("INSERT INTO auth(iduser, mail, mdp) VALUES(1,'john@gmail.com', '12345')");
  print('Inserted ID: $insertedId3');
  List<Map> result = await bdd.readData('SELECT * FROM auth');
  print('Read Data:');
  result.forEach((row) {
    print(row);
  });



  // Test the updateData function
  int rowsAffected = await bdd.updateData("UPDATE coordonnees SET Prenom = 'Jane' WHERE idUser = 1");
  print('Rows Affected: $rowsAffected');

  List<Map> result2 = await bdd.readData('SELECT * FROM coordonnees');
  print('Read Data:');
  result2.forEach((row) {
    print(row);
  });

  // Test the deleteData function
  int rowsDeleted = await bdd.deleteData("DELETE FROM coordonnees WHERE idUser = 1");
  print('Rows Deleted: $rowsDeleted');

  List<Map> result3 = await bdd.readData('SELECT * FROM coordonnees');
  print('Read Data:');
  result3.forEach((row) {
    print(row);
  });
}