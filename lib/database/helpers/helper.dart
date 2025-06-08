import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class DatabaseHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  static Future<Database> initDatabase() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'ARA.sqlite');

    if (!await File(path).exists()) {
      final data = await rootBundle.load('lib/database/attachments/ARA.sqlite');
      final bytes = data.buffer.asUint8List();
      await File(path).writeAsBytes(bytes);
    }

    _database = await openDatabase(path, readOnly: true);
    return _database!;
  }
}
