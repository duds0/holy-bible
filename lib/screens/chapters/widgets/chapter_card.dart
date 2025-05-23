import 'package:flutter/material.dart';
import 'package:holy_bible/screens/verses/verses_screen.dart';

class ChapterCard extends StatelessWidget {
  final int chapter;
  final String bookName;
  final Color bookColor;
  const ChapterCard({
    super.key,
    required this.chapter,
    required this.bookName,
    required this.bookColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:
          () => Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) => VersesScreen(
                    bookName: bookName,
                    chapter: chapter,
                    bookColor: bookColor,
                  ),
            ),
          ),
      child: Container(
        alignment: Alignment.center,
        child: Text(
          chapter.toString(),
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
