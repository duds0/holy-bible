import 'package:flutter/material.dart';
import 'package:holy_bible/screens/chapters/chapters_screen.dart';

class BookCard extends StatelessWidget {
  final String bookName;
  final String bookAbbreviation;
  final Color color;
  const BookCard({
    super.key,
    required this.bookName,
    required this.color,
    required this.bookAbbreviation,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:
          () => Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) =>
                      ChaptersScreen(bookName: bookName, bookColor: color),
            ),
          ),
      child: Container(
        padding: EdgeInsets.only(left: 8, right: 8, top: 16, bottom: 8),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(),
            Text(
              bookAbbreviation,
              style: TextStyle(
                color: Colors.black,
                fontSize: 32,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              bookName,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 16,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
