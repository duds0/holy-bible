import 'package:flutter/material.dart';
import 'package:holy_bible/database/repositories/chapter_and_verse_repository.dart';
import 'package:holy_bible/providers/chapter_count.dart';
import 'package:holy_bible/screens/texts/texts_screen.dart';
import 'package:provider/provider.dart';

class VersesScreen extends StatefulWidget {
  final String bookName;
  final Color bookColor;
  final int chapter;

  const VersesScreen({
    super.key,
    required this.bookName,
    required this.chapter,
    required this.bookColor,
  });

  @override
  State<VersesScreen> createState() => _VersesScreenState();
}

class _VersesScreenState extends State<VersesScreen> {
  late List<dynamic> versesToList = [];
  bool chapterCountController = false;

  Future<void> _getVerses() async {
    final List<dynamic> verses = await ChapterAndVerseRepository()
        .getVersesOrChapters(widget.bookName, chapter: widget.chapter);

    setState(() {
      versesToList = verses;
    });
  }

  Future<void> _updateVerses() async {
    final int newChapter =
        Provider.of<ChapterCount>(context, listen: false).newChapter;

    final List<dynamic> versesUpdated = await ChapterAndVerseRepository()
        .getVersesOrChapters(widget.bookName, chapter: newChapter);

    setState(() {
      versesToList = versesUpdated;
    });
    chapterCountController = true;
  }

  @override
  void initState() {
    _getVerses();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final int newChapter =
        Provider.of<ChapterCount>(context, listen: false).newChapter;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Versículos',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        forceMaterialTransparency: true,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: widget.bookColor,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              '${widget.bookName} ${chapterCountController ? newChapter : widget.chapter}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),

          Expanded(
            child: GridView.count(
              mainAxisSpacing: 24,
              crossAxisSpacing: 24,
              crossAxisCount: 4,
              children:
                  versesToList
                      .map(
                        (verseMap) => InkWell(
                          onTap: () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => TextsScreen(
                                      bookName: widget.bookName,
                                      chapter: widget.chapter,
                                      bookColor: widget.bookColor,
                                      initialVerse: verseMap,
                                    ),
                              ),
                            );

                            if (result == true) {
                              await _updateVerses();
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              verseMap.toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
