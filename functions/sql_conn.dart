import 'package:mysql1/mysql1.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';

final settings = ConnectionSettings(
  host: 'localhost',
  port: 3306,
  user: 'root',
  password: '1234Azerty@',
  db: 'budget',
);
Future<void> main() async {
  try {
    final conn = await MySqlConnection.connect(settings);
    print('Connexion à la base de données établie avec succès.');
    int i=1;
    final results = await conn.query('SELECT * FROM auth  ');
    for (var row in results) {
      print(row.fields);
    }
    if (results.isNotEmpty) {
      final resultList = await results.toList();

      // Afficher chaque ligne de la table
      for (var row in resultList) {
        print('Mail: ${row['mail']}, Mot de passe: ${row['mdp']}');
      }
    } else {
      print('Aucun élément trouvé');
    }    // Effectuez vos opérations sur la base de données ici

    await conn.close();
  } catch (e) {
    print('Échec de la connexion à la base de données : $e');
  }
  // Utilisez la connexion pour exécuter des requêtes et interagir avec la base de données
}
