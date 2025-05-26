import 'package:flutter/material.dart';
import 'package:holy_bible/screens/texts/texts_screen.dart';

class VerseCard extends StatelessWidget {
  final int verseNum;
  final String bookName;
  final int chapter;
  final Color bookColor;

  const VerseCard({
    super.key,
    required this.verseNum,
    required this.bookName,
    required this.chapter,
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
                  (context) => TextsScreen(
                    bookName: bookName,
                    chapter: chapter,
                    bookColor: bookColor,
                    initialVerse: verseNum,
                  ),
            ),
          ),
      child: Container(
        alignment: Alignment.center,
        child: Text(
          verseNum.toString(),
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
