class Book {
  final int id;
  final int bookReferenceId;
  final int testamentReferenceId;
  final String name;

  Book({
    required this.id,
    required this.bookReferenceId,
    required this.name,
    required this.testamentReferenceId,
  });

  static Book fromMap(Map<String, dynamic> map) {
    return Book(
      id: map['id'],
      bookReferenceId: map['book_reference_id'],
      name: map['name'],
      testamentReferenceId: map['testament_reference_id'],
    );
  }

  @override
  String toString() {
    return 'Book(id: $id, bookReferenceId: $bookReferenceId, testamentReferenceId: $testamentReferenceId, name: $name)';
  }
}
