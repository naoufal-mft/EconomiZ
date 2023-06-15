import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';


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
    print(" onCreate =====================================");
    return mydb;
  }

  _onUpgrade(Database db, int oldversion, int newversion) {

  }

  _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS coordonnees (
      idUser  INTEGER PRIMARY KEY AUTOINCREMENT,
      Nom TEXT NOT NULL,
      Prenom TEXT NOT NULL,
      DoB DATE  NOT NULL
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
      mois TEXT NOT NULL,
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

  List<Map> result = await bdd.readData('SELECT * FROM auth');
  print('Read Data:');
  result.forEach((row) {
    print(row);
  });

  bdd.insertData("INSERT INTO coordonnees (Nom,Prenom,DoB)  VALUES('John', 'Doe','14-08-2002')");
  bdd.insertData("INSERT INTO charge (nom_charge,prix,type,mois,iduser) VALUES('loyer', '600','fixe','09','2')");
  bdd.insertData("INSERT INTO charge (nom_charge,prix,type,mois,iduser) VALUES('Abonnement', '100','fixe','09','2')");
  bdd.insertData("INSERT INTO charge (nom_charge,prix,type,mois,iduser) VALUES('Courses', '250','fixe','09','2')");
  bdd.insertData("INSERT INTO charge (nom_charge,prix,type,mois,iduser) VALUES('Sport', '30','fixe','09','2')");
  bdd.insertData("INSERT INTO charge (nom_charge,prix,type,mois,iduser) VALUES('Transport', '50','fixe','09','2')");
  bdd.insertData("INSERT INTO charge (nom_charge,prix,type,mois,iduser) VALUES('Voyage', '100','fixe','09','2')");

  List<Map> result2 = await bdd.readData('SELECT * FROM coordonnees');
  print('Read Data:');
  result2.forEach((row) {
    print(row);
  });
  List<Map> result1=await bdd.readData('SELECT prix FROM charge WHERE iduser=5 and nom_charge="loyer"' );
  print('Read Data:');
  result1.forEach((row) {
    print(row);
  });
  List<Map> result4 = await bdd.readData('SELECT * FROM charge');
  print('Read Data:');
  result4.forEach((row) {
    print(row);
  });


}