class Stanza {
  final String label;
  final String type;
  final String lyric;

  Stanza({required this.label, required this.type, required this.lyric});

  @override
  String toString() {
    return 'Stanza(label: $label, type: $type, lyric: $lyric)';
  }
}
