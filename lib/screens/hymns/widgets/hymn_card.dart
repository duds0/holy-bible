import 'package:flutter/material.dart';
import 'package:holy_bible/screens/lyric/lyric_screen.dart';

class HymnCard extends StatelessWidget {
  final String hymnTitle;
  final String hymnNum;
  final int hymnId;
  final bool isWithTitle;

  const HymnCard({
    super.key,
    required this.hymnTitle,
    required this.hymnNum,
    required this.hymnId,
    required this.isWithTitle,
  });

  String _titleFormatted(String title) {
    final regex = RegExp(r'^CC \d+\s+');
    return title.replaceFirst(regex, '');
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:
          () => Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) => LyricScreen(
                    hymnTitle: hymnTitle,
                    hymnNum: hymnNum,
                    hymnId: hymnId,
                  ),
            ),
          ),
      child:
          isWithTitle
              ? Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: Row(
                  children: [
                    Text(
                      int.parse(hymnNum).toString(),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _titleFormatted(hymnTitle),
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              )
              : Container(
                margin: EdgeInsets.symmetric(vertical: 8),
                alignment: Alignment.center,
                child: Text(
                  int.parse(hymnNum).toString(),
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                ),
              ),
    );
  }
}
