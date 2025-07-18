import 'package:sqflite/sqflite.dart';

import '../utils.dart';
import 'database_service.dart';

/// A helper class that manages the database table used to store book search results locally.
class BookFinderDb {
  final bookTableName = 'book_table';

  // Column names used in the book_table
  static const id = 'id';
  static const title = 'title';
  static const coverKey = 'cover_key';
  static const authorName = 'author_name';
  static const lendingEditionS = 'lending_edition_s';

  /// Creates the `book_table` in the database if it doesn't exist.
  Future<void> createTables(Database database) async {
    Utils.customLog("CREATE TABLE");
    await database.execute('''
          CREATE TABLE IF NOT EXISTS $bookTableName (
            $id INTEGER PRIMARY KEY NOT NULL,
            $title TEXT,
            $coverKey TEXT,
            $authorName TEXT,
            $lendingEditionS TEXT
          )
          ''');
  }

  Future<void> deleteAllEntries(String tableName) async {
    Database db = await DatabaseService().database;

    await db.rawDelete('DELETE FROM $tableName');
  }

  /// Retrieves paginated list of books from the local `book_table`.
  ///
  /// [page]: The page number to fetch (starting from 1).
  /// Each page contains 50 records.
  Future<List<Map<String, dynamic>>> getAllStoredBooks({required int page}) async {
    // Define the number of entries per page
    int entriesPerPage = 50;

    // Calculate the offset based on the page number
    int offset = (page - 1) * entriesPerPage;

    Database db = await DatabaseService().database;

    List<Map<String, dynamic>> result = await db.rawQuery('''
    SELECT *
    FROM $bookTableName
    ORDER BY $id ASC
    LIMIT $entriesPerPage
    OFFSET $offset
  ''');

    return result;
  }

  /// Inserts a list of book records into the local `book_table`.
  ///
  /// [books]: List of maps representing book records.
  /// Returns number of records inserted or -1 in case of error.
  Future<int> insertInBookTable(List<dynamic> books) async {
    Database db = await DatabaseService().database;

    try {
      var batch = db.batch();

      for (var book in books) {
        batch.rawInsert('''
        INSERT INTO ${BookFinderDb().bookTableName} (
          $title,
          $coverKey,
          $authorName,
          $lendingEditionS
        )
        VALUES (?, ?, ?, ?)
      ''', [book[title], book[coverKey], book[authorName], book[lendingEditionS]]);
      }

      List batchResult = await batch.commit();
      return batchResult.length;
    } catch (error) {
      Utils.customLog("Error at insertInBookTable: $error");
      return -1;
    }
  }
}
