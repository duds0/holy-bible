import 'package:holy_bible/database/helpers/helper.dart';
import 'package:holy_bible/models/book.dart';
import 'package:sqflite/sqflite.dart';

class BookRepository {
  static const String tableName = 'book';

  final DatabaseHelper helper;

  BookRepository({required this.helper});

  Future<List<Book>> findAll() async {
    final Database database = await helper.database;
    final List<Map<String, dynamic>> books = await database.query(tableName);

    return books.map((bookMap) => Book.fromMap(bookMap)).toList();
  }
}
