import 'package:flutter/material.dart';
import 'package:holy_bible/database/repositories/book_repository.dart';
import 'package:holy_bible/models/book.dart';
import 'package:holy_bible/screens/books/widgets/book_card.dart';
import 'package:holy_bible/screens/hymns/hymns_screen.dart';
import 'package:holy_bible/utils/utils.dart';

class BooksScreen extends StatefulWidget {
  final bool darkMode;
  final VoidCallback switchBrightness;
  const BooksScreen({
    super.key,
    required this.switchBrightness,
    required this.darkMode,
  });

  @override
  State<BooksScreen> createState() => _BooksScreensState();
}

class _BooksScreensState extends State<BooksScreen> {
  List<Book> allBooks = [];
  List<Book> booksToList = [];
  bool isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  Future<void> getBooks() async {
    final List<Book> books = await BookRepository().findAll();
    setState(() {
      allBooks = books;
      booksToList = books;
    });
  }

  void _filterBooks(String query) {
    final filtered =
        allBooks
            .where(
              (book) => book.name.toLowerCase().contains(query.toLowerCase()),
            )
            .toList();

    setState(() {
      booksToList = filtered;
    });
  }

  void _startSearch() {
    setState(() {
      isSearching = true;
    });
  }

  void _stopSearch() {
    setState(() {
      isSearching = false;
      _searchController.clear();
      booksToList = allBooks;
    });
  }

  @override
  void initState() {
    getBooks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        centerTitle: true,
        leading: IconButton(
          onPressed: widget.switchBrightness,
          icon:
              widget.darkMode ? Icon(Icons.light_mode) : Icon(Icons.dark_mode),
        ),
        title:
            isSearching
                ? TextField(
                  controller: _searchController,
                  autofocus: true,
                  decoration: const InputDecoration(
                    hintText: 'Buscar livro...',
                    border: InputBorder.none,
                  ),
                  onChanged: _filterBooks,
                )
                : const Text(
                  'Livros',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
        actions: [
          isSearching
              ? IconButton(
                icon: const Icon(Icons.close),
                onPressed: _stopSearch,
              )
              : IconButton(
                icon: const Icon(Icons.search),
                onPressed: _startSearch,
              ),
          IconButton(
            onPressed:
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HymnsScreen()),
                ),
            icon: Icon(Icons.music_note),
          ),
        ],
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(8),
        crossAxisCount: 3,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        children:
            booksToList.map((bookMap) {
              final division = Utils.getDivisionById(bookMap.id);
              final Color color =
                  Utils.bibleDivisionColors[division] ?? Colors.transparent;

              return BookCard(
                bookName: bookMap.name,
                color: color,
                bookAbbreviation: Utils.getAbbreviation(bookMap.name),
              );
            }).toList(),
      ),
    );
  }
}
