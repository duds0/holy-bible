import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final Map<String, Database> _databases = {};

  final String dbName;
  final String dbPath;

  DatabaseHelper({required this.dbName, required this.dbPath});

  String get databaseName => dbName;

  Future<Database> get database async {
    if (_databases.containsKey(dbName)) return _databases[dbName]!;

    final db = await _initDatabase();
    _databases[dbName] = db;
    return db;
  }

  Future<Database> _initDatabase() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, dbName);

    if (!await File(path).exists()) {
      final data = await rootBundle.load(dbPath);
      final bytes = data.buffer.asUint8List(
        data.offsetInBytes,
        data.lengthInBytes,
      );
      await File(path).writeAsBytes(bytes);
    }

    return await openDatabase(path, readOnly: true);
  }
}
