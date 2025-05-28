import 'package:flutter/material.dart';

class ChapterCount with ChangeNotifier {
  int _chapter = 1;
  int get chapter => _chapter;

  void updateChapter(int chapter) {
    _chapter = chapter;
    notifyListeners();
  }

  void nextChapter() {
    _chapter += 1;
    notifyListeners();
  }

  void previousChapter() {
    _chapter -= 1;
    notifyListeners();
  }
}
