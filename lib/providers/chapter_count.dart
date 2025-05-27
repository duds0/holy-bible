import 'package:flutter/material.dart';

class ChapterCount with ChangeNotifier {
  int _newChapter = 1;
  int get newChapter => _newChapter;

  void increaseChapter(int actualChapter) {
    _newChapter = actualChapter;
    notifyListeners();
  }

  void decreaseChapter(int actualChapter) {
    _newChapter = actualChapter;
    notifyListeners();
  }
}
