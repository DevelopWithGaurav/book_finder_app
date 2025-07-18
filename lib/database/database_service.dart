import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'book_finder_db.dart';

class DatabaseService {
  static const _databaseName = "book_finder.db";

  // only have a single app-wide reference to the database
  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  Future<String> getFullPath() async {
    final path = await getDatabasesPath();
    return join(path, _databaseName);
  }

  // this opens the database (and creates it if it doesn't exist)
  Future<Database> _initDatabase() async {
    String path = await getFullPath();

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
      singleInstance: true,
    );
  }

  // SQL code to create the database table
  Future<void> _onCreate(Database database, int version) async {
    await BookFinderDb().createTables(database);
  }
}
