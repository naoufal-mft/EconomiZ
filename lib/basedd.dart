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

  bdd.insertData('INSERT INTO coordonnees(nom,prenom) VALUES("Xlo","Xlo")');
  String sql = 'INSERT INTO charge(idcharge,nom_charge,prix,type,iduser) VALUES("1","creme","200","fixe","1")';
  sql = 'INSERT INTO charge(idcharge,nom_charge,prix,type,iduser) VALUES("3","lame","500","variable","3")';
  bdd.insertData(sql);

  List<Map> result = await bdd.readData('SELECT * FROM charge');
  print('Read Data:');
  result.forEach((row) {
    print(row);
  });

  List<Map> result2 = await bdd.readData('SELECT * FROM coordonnees');
  print('Read Data:');
  var a = Map();
  result2.forEach((row) {
    a= row;
    print(a);
  });



}