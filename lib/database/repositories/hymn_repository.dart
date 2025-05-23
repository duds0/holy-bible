import 'package:holy_bible/database/helpers/cc_helper.dart';
import 'package:holy_bible/models/hymn.dart';
import 'package:holy_bible/models/stanza.dart';
import 'package:sqflite/sqflite.dart';
import 'package:xml/xml.dart';

class HymnRepository {
  static const String tableName = 'songs';

  final DatabaseHelperCC helper = DatabaseHelperCC();

  Future<List<Hymn>> getAllHymns() async {
    final Database database = await helper.database;

    final result = await database.query(
      tableName,
      columns: ['id', 'song_number', 'title'],
      where: 'song_number IS NOT NULL',
      orderBy: 'song_number ASC',
    );

    return result.map((hymnMap) => Hymn.fromMap(hymnMap)).toList();
  }

  Future<List<Stanza>> getFormattedLyricsById(int id) async {
    final Database database = await helper.database;
    final result = await database.query(
      'songs',
      columns: ['lyrics'],
      where: 'id = ?',
      whereArgs: [id],
    );

    // if (result.isEmpty) return '[Letra não encontrada]';

    final rawLyrics = result.first['lyrics'] as String;
    return parseStanzasFromXml(rawLyrics);
  }

  List<Stanza> parseStanzasFromXml(String xmlString) {
    final List<Stanza> stanzas = [];

    try {
      final document = XmlDocument.parse(xmlString);
      final verses = document.findAllElements('verse');

      for (var verse in verses) {
        final label = verse.getAttribute('label') ?? '';
        final type = verse.getAttribute('type') ?? '';

        final cleanedLyric = verse.innerText
            .split('\n')
            .map((line) => line.trim())
            .where((line) => line.isNotEmpty && line != '[---]')
            .join('\n');

        stanzas.add(Stanza(label: label, type: type, lyric: cleanedLyric));
      }
    } catch (e) {
      stanzas.add(
        Stanza(
          label: 'error',
          type: 'error',
          lyric: '[Erro ao processar letra]',
        ),
      );
    }

    return stanzas;
  }
  // String _parseLyricsFromXml(String xmlString) {
  //   try {
  //     final document = XmlDocument.parse(xmlString);
  //     final verses = document.findAllElements('verse');

  //     return verses
  //         .map((v) {
  //           final rawText = v.innerText;
  //           final cleanedLines =
  //               rawText
  //                   .split('\n')
  //                   .map((line) => line.trim())
  //                   .where((line) => line.isNotEmpty && line != '[---]')
  //                   .toList();

  //           return cleanedLines.join('\n');
  //         })
  //         .join('\n\n');
  //   } catch (e) {
  //     return '[Erro ao processar a letra]';
  //   }
  // }
}
