import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _instance;
  static Database? _db;

  factory DatabaseHelper() {
    _instance ??= DatabaseHelper._internal();
    return _instance!;
  }

  DatabaseHelper._internal();

  Future<Database> get db async {
    _db ??= await initDb();
    return _db!;
  }

  Future<Database> initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'my_database.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE my_table(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, description TEXT)');
  }

  Future<int> insertData(String name, String description) async {
    Database dbClient = await db;
    Map<String, dynamic> row = {
      'name': name,
      'description': description,
    };
    return await dbClient.insert('my_table', row);
  }

  Future<List<Map<String, dynamic>>> searchData(String query) async {
    Database dbClient = await db;
    return await dbClient.query('my_table',
        where: "name LIKE ? OR description LIKE ?",
        whereArgs: ['%$query%', '%$query%']);
  }
}
