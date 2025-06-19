import 'package:flutter/material.dart';
import 'package:holy_bible/database/helpers/helper.dart';
import 'package:holy_bible/database/repositories/book_repository.dart';
import 'package:holy_bible/database/repositories/chapter_and_verse_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VersionProvider with ChangeNotifier {
  late DatabaseHelper _helper;
  late BookRepository bookRepository;
  late ChapterAndVerseRepository chapterAndVerseRepository;

  static const String _versionKey = 'selected_version';
  static const String _pathKey = 'selected_version_path';

  VersionProvider() {
    _initVersion('ARA.sqlite', 'lib/database/attachments/ARA.sqlite');

    _loadSavedVersion();
  }

  Future<void> _loadSavedVersion() async {
    final prefs = await SharedPreferences.getInstance();
    final dbName = prefs.getString(_versionKey);
    final dbPath = prefs.getString(_pathKey);

    if (dbName != null && dbPath != null && dbName != _helper.dbName) {
      _initVersion(dbName, dbPath);
    }
  }

  void _initVersion(String dbName, String dbPath) {
    _helper = DatabaseHelper(dbName: dbName, dbPath: dbPath);
    bookRepository = BookRepository(helper: _helper);
    chapterAndVerseRepository = ChapterAndVerseRepository(helper: _helper);
    notifyListeners();
  }

  Future<void> setVersion(String dbName, String dbPath) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_versionKey, dbName);
    await prefs.setString(_pathKey, dbPath);

    _initVersion(dbName, dbPath);

    notifyListeners();
  }

  String get currentVersionName {
    return _helper.dbName.replaceAll('.sqlite', '');
  }
}
