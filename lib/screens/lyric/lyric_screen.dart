import 'package:flutter/material.dart';
import 'package:holy_bible/database/helpers/helper.dart';
import 'package:holy_bible/database/repositories/hymn_repository.dart';
import 'package:holy_bible/models/stanza.dart';

class LyricScreen extends StatefulWidget {
  final String hymnTitle;
  final String hymnNum;
  final int hymnId;
  const LyricScreen({
    super.key,
    required this.hymnTitle,
    required this.hymnNum,
    required this.hymnId,
  });

  @override
  State<LyricScreen> createState() => _SongScreenState();
}

class _SongScreenState extends State<LyricScreen> {
  late List<Stanza> stanzasToList = [];

  Future<void> _getStanzas() async {
    final List<Stanza> stanzas = await HymnRepository(
      helper: DatabaseHelper(
        dbName: 'cc.sqlite',
        dbPath: 'lib/database/attachments/cc.sqlite',
      ),
    ).getFormattedLyricsById(widget.hymnId);
    setState(() {
      stanzasToList = stanzas;
    });
  }

  @override
  void initState() {
    _getStanzas();
    super.initState();
  }

  String _titleFormatted(String title) {
    final regex = RegExp(r'^CC \d+\s+');
    return title.replaceFirst(regex, '');
  }

  String _isChoir(Stanza stanza) {
    if (stanza.type == 'c') {
      return "Coro";
    } else {
      return stanza.label;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        centerTitle: true,
        title: Text(
          _titleFormatted(widget.hymnTitle),
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 16, top: 8, left: 8, right: 8),
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Color(0xffc9c9c9),
              ),
              child: Text(
                '${widget.hymnNum} - ${_titleFormatted(widget.hymnTitle)}',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
                  stanzasToList
                      .map(
                        (stanzaMap) => Padding(
                          padding: const EdgeInsets.only(
                            left: 16,
                            bottom: 32,
                            right: 4,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _isChoir(stanzaMap),
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              Text(
                                stanzaMap.lyric,
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
