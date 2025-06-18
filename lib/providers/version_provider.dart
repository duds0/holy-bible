import 'package:flutter/material.dart';
import 'package:holy_bible/database/helpers/helper.dart';
import 'package:holy_bible/database/repositories/book_repository.dart';
import 'package:holy_bible/database/repositories/chapter_and_verse_repository.dart';

class VersionProvider with ChangeNotifier {
  late DatabaseHelper _helper;

  late BookRepository bookRepository;
  late ChapterAndVerseRepository chapterAndVerseRepository;

  VersionProvider() {
    _initVersion('ARA.sqlite', 'lib/database/attachments/ARA.sqlite');
  }

  void _initVersion(String dbName, String dbPath) {
    _helper = DatabaseHelper(dbName: dbName, dbPath: dbPath);

    bookRepository = BookRepository(helper: _helper);
    chapterAndVerseRepository = ChapterAndVerseRepository(helper: _helper);
  }

  void setVersion(String dbName, String dbPath) {
    _initVersion(dbName, dbPath);
    notifyListeners();
  }

  String get currentVersionName {
    return _helper.dbName.replaceAll('.sqlite', '');
  }
}
