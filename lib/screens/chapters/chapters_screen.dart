import 'package:flutter/material.dart';
import 'package:holy_bible/providers/chapter_count.dart';
import 'package:holy_bible/providers/version_provider.dart';
import 'package:holy_bible/screens/verses/verses_screen.dart';
import 'package:provider/provider.dart';

class ChaptersScreen extends StatefulWidget {
  final String bookName;
  final Color bookColor;

  const ChaptersScreen({
    super.key,
    required this.bookName,
    required this.bookColor,
  });

  @override
  State<ChaptersScreen> createState() => _ChaptersScreenState();
}

class _ChaptersScreenState extends State<ChaptersScreen> {
  late List<dynamic> chaptersToList = [];

  Future<void> getChapters() async {
    final versionDb = Provider.of<VersionProvider>(context, listen: false);

    final List<dynamic> chapters = await versionDb.chapterAndVerseRepository
        .getVersesOrChapters(widget.bookName);

    setState(() {
      chaptersToList = chapters;
    });
  }

  @override
  void initState() {
    getChapters();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Capítulos",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        forceMaterialTransparency: true,
        centerTitle: true,
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
              widget.bookName,
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
                  chaptersToList
                      .map(
                        (chapterMap) => InkWell(
                          onTap:
                              () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => VersesScreen(
                                        getChapter:
                                            () => context
                                                .read<ChapterCount>()
                                                .updateChapter(
                                                  chapterMap['chapter'],
                                                ),
                                        bookName: widget.bookName,
                                        bookColor: widget.bookColor,
                                      ),
                                ),
                              ),
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              chapterMap['chapter'].toString(),
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
