class Verse {
  final int id;
  final int bookId;
  final int chapter;
  final int verse;
  final String text;

  Verse({
    required this.id,
    required this.bookId,
    required this.chapter,
    required this.verse,
    required this.text,
  });

  @override
  String toString() {
    return 'Verse(id: $id, bookId: $bookId, chapter: $chapter, verse: $verse, text: $text)';
  }
}
