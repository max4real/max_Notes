import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  DatabaseHelper._internal();

  factory DatabaseHelper() {
    return _instance;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'note_db.db');
    Database database = await openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE notes(id INTEGER PRIMARY KEY AUTOINCREMENT, body TEXT, createdAt TEXT)",
        );
      },
      version: 1,
    );
    return database;
  }

  Future<void> insertItem({required String body, required createdAt}) async {
    Map<String, dynamic> item = {
      "body": body,
      "createdAt": createdAt,
    };
    final db = await database;
    await db.insert('notes', item,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> getItems() async {
    final db = await database;
    return await db.query('notes');
  }

  Future<void> updateItem(
      {required int id, required String body, required createdAt}) async {
    Map<String, dynamic> item = {
      "id": id,
      "body": body,
      "createdAt": createdAt,
    };
    final db = await database;
    await db.update('notes', item, where: "id = ?", whereArgs: [item['id']]);
  }

  Future<void> deleteItem(int id) async {
    final db = await database;
    await db.delete('notes', where: "id = ?", whereArgs: [id]);
  }
}
