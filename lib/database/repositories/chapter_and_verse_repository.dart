import 'package:holy_bible/database/helpers/helper.dart';
import 'package:holy_bible/models/verse.dart';
import 'package:sqflite/sqflite.dart';

class ChapterAndVerseRepository {
  static const String tableName = 'verse';

  final DatabaseHelper helper;

  ChapterAndVerseRepository({required this.helper});

  Future<List<dynamic>> getVersesOrChapters(
    String bookName, {
    int? chapter,
    int? verse,
  }) async {
    final Database database = await helper.database;

    if (chapter == null) {
      final result = await database.rawQuery(
        '''
      SELECT DISTINCT v.chapter
      FROM verse v
      JOIN book b ON v.book_id = b.id
      WHERE b.name = ?
      ORDER BY v.chapter
    ''',
        [bookName],
      );

      return result;
    }

    if (verse == null) {
      final List<Map<String, dynamic>> result = await database.rawQuery(
        '''
    SELECT v.verse
    FROM verse v
    JOIN book b ON v.book_id = b.id
    WHERE b.name = ? AND v.chapter = ?
    ORDER BY v.verse
    ''',
        [bookName, chapter],
      );

      return result.map((row) => row['verse']).toList();
    }

    final List<Map<String, dynamic>> result = await database.rawQuery(
      '''
      SELECT v.id, v.book_id, b.name AS book_name, v.chapter, v.verse, v.text
      FROM verse v
      JOIN book b ON v.book_id = b.id
      WHERE b.name = ? AND v.chapter = ?
      ORDER BY v.verse
    ''',
      [bookName, chapter],
    );

    return result.map((verseMap) {
      return Verse(
        id: verseMap['id'],
        bookId: verseMap['book_id'],
        chapter: verseMap['chapter'],
        verse: verseMap['verse'],
        text: verseMap['text'],
      );
    }).toList();
  }
}
