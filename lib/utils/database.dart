import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseApp {
  static final DatabaseApp _instance = DatabaseApp._internal();
  static Database? _database;

  factory DatabaseApp() => _instance;

  DatabaseApp._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'todo.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE todos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        description TEXT,
        completed INTEGER
      )
    ''');
  }
}
