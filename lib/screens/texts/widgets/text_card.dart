import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextCard extends StatelessWidget {
  TextCard({
    super.key,
    required this.verseNum,
    required this.verseText,
    required this.fontSize,
  });

  final int verseNum;
  final String verseText;
  double fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: ' ${verseNum.toString()} ',
              style: TextStyle(
                fontSize: fontSize / 1.33,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
            TextSpan(text: verseText, style: TextStyle(fontSize: fontSize)),
          ],
        ),
      ),
    );
  }
}
