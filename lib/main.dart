import 'package:flutter/material.dart';
import 'package:holy_bible/providers/chapter_count.dart';
import 'package:holy_bible/screens/books/books_screen.dart';
import 'package:holy_bible/utils/utils.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ChangeNotifierProvider(create: (_) => ChapterCount(), child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool? isDarkMode;

  Future<void> _loadThemeMode() async {
    final themeMode = await Utils.getThemeMode();
    setState(() {
      isDarkMode = themeMode;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadThemeMode();
  }

  @override
  Widget build(BuildContext context) {
    if (isDarkMode == null) {
      return const SizedBox();
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HolyBible',
      theme: ThemeData(
        brightness: isDarkMode! ? Brightness.dark : Brightness.light,
        fontFamily: 'Inter',
      ),
      home: BooksScreen(
        darkMode: isDarkMode!,
        switchBrightness:
            () => setState(() {
              isDarkMode = !isDarkMode!;
              Utils.saveThemeMode(isDarkMode!);
            }),
      ),
    );
  }
}
