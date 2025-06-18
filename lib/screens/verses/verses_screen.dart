import 'package:flutter/material.dart';
import 'package:holy_bible/providers/chapter_count.dart';
import 'package:holy_bible/providers/version_provider.dart';
import 'package:holy_bible/screens/texts/texts_screen.dart';
import 'package:provider/provider.dart';

class VersesScreen extends StatefulWidget {
  final String bookName;
  final Color bookColor;
  final Function getChapter;

  const VersesScreen({
    super.key,
    required this.bookName,
    required this.bookColor,
    required this.getChapter,
  });

  @override
  State<VersesScreen> createState() => _VersesScreenState();
}

class _VersesScreenState extends State<VersesScreen> {
  late List<dynamic> versesToList = [];

  Future<void> _getVerses() async {
    widget.getChapter();

    final versionDb = Provider.of<VersionProvider>(context, listen: false);

    final List<dynamic> verses = await versionDb.chapterAndVerseRepository
        .getVersesOrChapters(
          widget.bookName,
          chapter: context.read<ChapterCount>().chapter,
        );

    setState(() {
      versesToList = verses;
    });
  }

  Future<void> _updateVerses() async {
    final versionDb = Provider.of<VersionProvider>(context, listen: false);

    final List<dynamic> verses = await versionDb.chapterAndVerseRepository
        .getVersesOrChapters(
          widget.bookName,
          chapter: context.read<ChapterCount>().chapter,
        );

    setState(() {
      versesToList = verses;
    });
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getVerses();
    });
  }

  @override
  Widget build(BuildContext context) {
    final int chapter =
        Provider.of<ChapterCount>(context, listen: false).chapter;
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
              '${widget.bookName} $chapter',
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
