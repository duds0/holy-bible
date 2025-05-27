import 'package:flutter/material.dart';
import 'package:holy_bible/providers/chapter_count.dart';
import 'package:holy_bible/screens/books/books_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ChangeNotifierProvider(create: (_) => ChapterCount(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HolyBible',
      theme: ThemeData(brightness: Brightness.dark, fontFamily: 'Inter'),
      home: BooksScreen(),
    );
  }
}
