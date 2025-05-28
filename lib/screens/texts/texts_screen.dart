// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:holy_bible/database/repositories/chapter_and_verse_repository.dart';
import 'package:holy_bible/providers/chapter_count.dart';
import 'package:holy_bible/screens/texts/widgets/text_card.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class TextsScreen extends StatefulWidget {
  final String bookName;
  final Color bookColor;
  int initialVerse;

  TextsScreen({
    super.key,
    required this.bookName,
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

  bool changedChapter = false;

  Future<void> getTexts() async {
    final List<dynamic> texts = await ChapterAndVerseRepository()
        .getVersesOrChapters(
          widget.bookName,
          chapter: context.read<ChapterCount>().chapter,
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

  Future<void> _nextChapter(BuildContext context) async {
    context.read<ChapterCount>().nextChapter();

    final List<dynamic> verses = await ChapterAndVerseRepository()
        .getVersesOrChapters(
          widget.bookName,
          chapter: context.read<ChapterCount>().chapter,
          verse: widget.initialVerse,
        );

    setState(() {
      textsToList = verses;
    });

    changedChapter = true;
  }

  Future<void> _previousChapter(BuildContext context) async {
    context.read<ChapterCount>().previousChapter();

    final List<dynamic> verses = await ChapterAndVerseRepository()
        .getVersesOrChapters(
          widget.bookName,
          chapter: context.read<ChapterCount>().chapter,
          verse: widget.initialVerse,
        );

    setState(() {
      textsToList = verses;
    });

    changedChapter = true;
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
    final int chapter =
        Provider.of<ChapterCount>(context, listen: false).chapter;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context, changedChapter),
          icon: Icon(Icons.arrow_back),
        ),
        centerTitle: true,
        forceMaterialTransparency: true,
        title: Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: widget.bookColor,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            '${_fixBigBooksName()} $chapter',
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
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) {
            return;
          }

          Navigator.pop(context, changedChapter);
        },
        child: Stack(
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
                  if (chapter > 1) {
                    await _previousChapter(context);
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
                  if (chapter < await _numOfChapters()) {
                    await _nextChapter(context);
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
      ),
    );
  }
}
