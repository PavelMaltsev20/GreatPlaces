import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqflite.dart';

import 'constants.dart';

class DBHelper {
  static Future<Database> getDatabase() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, db_name),
      onCreate: (db, version) {
        return db.execute(
            "CREATE TABLE places(id TEXT PRIMARY KEY, title TEXT, image TEXT, loc_lat REAL, loc_lng REAL, address TEXT)");
      },
      version: 1,
    );
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final database = await DBHelper.getDatabase();
    database.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final database = await DBHelper.getDatabase();
    return database.query(table);
  }

  static Future<int> delete(String table, String id) async {
    final database = await DBHelper.getDatabase();
    database.delete(table, where: 'id = ?', whereArgs: [id]);
  }
}
