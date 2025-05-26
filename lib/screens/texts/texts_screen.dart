import 'package:flutter/material.dart';
import 'package:holy_bible/database/repositories/chapter_and_verse_repository.dart';
import 'package:holy_bible/screens/texts/widgets/text_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class TextsScreen extends StatefulWidget {
  final String bookName;
  int chapter;
  final Color bookColor;
  int initialVerse;

  TextsScreen({
    super.key,
    required this.bookName,
    required this.chapter,
    required this.bookColor,
    required this.initialVerse,
  });

  @override
  State<TextsScreen> createState() => _TextsScreenState();
}

class _TextsScreenState extends State<TextsScreen> {
  double fontSize = 16;
  late List<dynamic> textsToList = [];

  final ScrollController _scrollController = ScrollController();
  final Map<int, GlobalKey> _verseKeys = {};

  Future<void> getTexts() async {
    final List<dynamic> texts = await ChapterAndVerseRepository()
        .getVersesOrChapters(
          widget.bookName,
          chapter: widget.chapter,
          verse: widget.initialVerse,
        );

    setState(() {
      textsToList = texts;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToInitialVerse();
    });
  }

  void _scrollToInitialVerse() {
    final key = _verseKeys[widget.initialVerse];
    if (key != null && key.currentContext != null) {
      Scrollable.ensureVisible(key.currentContext!);
    }
  }

  Future<void> _saveFontSize() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('fontSize', fontSize);
  }

  Future<void> _loadFontSize() async {
    final prefs = await SharedPreferences.getInstance();
    final savedFontSize = prefs.getDouble('fontSize');
    if (savedFontSize != null) {
      setState(() {
        fontSize = savedFontSize;
      });
    }
  }

  Future<void> _nextChapter() async {
    final List<dynamic> verses = await ChapterAndVerseRepository()
        .getVersesOrChapters(
          widget.bookName,
          chapter: widget.chapter += 1,
          verse: widget.initialVerse,
        );

    setState(() {
      textsToList = verses;
    });
  }

  Future<void> _previousChapter() async {
    final List<dynamic> verses = await ChapterAndVerseRepository()
        .getVersesOrChapters(
          widget.bookName,
          chapter: widget.chapter -= 1,
          verse: widget.initialVerse,
        );

    setState(() {
      textsToList = verses;
    });
  }

  Future<int> _numOfChapters() async {
    final List<dynamic> chapters = await ChapterAndVerseRepository()
        .getVersesOrChapters(widget.bookName);

    return chapters.length;
  }

  String _fixBigBooksName() {
    if (widget.bookName == 'Atos dos Apóstolos') {
      return 'Atos';
    } else if (widget.bookName == '1 Tessalonicenses') {
      return '1 Tess.';
    } else if (widget.bookName == '2 Tessalonicenses') {
      return '2 Tess.';
    } else {
      return widget.bookName;
    }
  }

  @override
  void initState() {
    getTexts();
    _loadFontSize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        forceMaterialTransparency: true,
        title: Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: widget.bookColor,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            '${_fixBigBooksName()} ${widget.chapter}',
            overflow: TextOverflow.visible,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              if (fontSize > 8) {
                setState(() {
                  fontSize -= 4;
                });
                _saveFontSize();
              }
            },
            icon: Icon(Icons.text_decrease),
          ),
          IconButton(
            onPressed: () {
              if (fontSize < 64) {
                setState(() {
                  fontSize += 4;
                });
                _saveFontSize();
              }
            },
            icon: Icon(Icons.text_increase),
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            padding: EdgeInsets.only(bottom: 96),
            child: Column(
              children:
                  textsToList.map((verseMap) {
                    final key = GlobalKey();
                    _verseKeys[verseMap.verse] = key;

                    return SizedBox(
                      key: key,
                      child: TextCard(
                        verseNum: verseMap.verse,
                        verseText: verseMap.text,
                        fontSize: fontSize,
                      ),
                    );
                  }).toList(),
            ),
          ),
          Positioned(
            bottom: 40,
            left: 16,
            child: InkWell(
              onTap: () async {
                if (widget.chapter > 1) {
                  await _previousChapter();
                  widget.initialVerse = 1;
                  _scrollToInitialVerse();
                }
              },
              child: Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: widget.bookColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.keyboard_arrow_left,
                  color: Colors.black,
                  size: 32,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 40,
            right: 16,
            child: InkWell(
              onTap: () async {
                if (widget.chapter < await _numOfChapters()) {
                  await _nextChapter();
                  widget.initialVerse = 1;
                  _scrollToInitialVerse();
                }
              },
              child: Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: widget.bookColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.black,
                  size: 32,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
