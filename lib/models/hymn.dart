class Hymn {
  final String hymnNumber;
  final String title;
  final int id;

  Hymn({required this.hymnNumber, required this.title, required this.id});

  factory Hymn.fromMap(Map<String, dynamic> map) {
    return Hymn(
      hymnNumber: map['song_number']?.toString() ?? '',
      title: map['title'] ?? '',
      id: map['id'],
    );
  }
}
