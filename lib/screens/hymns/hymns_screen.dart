import 'package:flutter/material.dart';
import 'package:holy_bible/database/helpers/helper.dart';
import 'package:holy_bible/database/repositories/hymn_repository.dart';
import 'package:holy_bible/models/hymn.dart';
import 'package:holy_bible/screens/hymns/widgets/hymn_card.dart';

class HymnsScreen extends StatefulWidget {
  const HymnsScreen({super.key});

  @override
  State<HymnsScreen> createState() => _HymnsScreenState();
}

class _HymnsScreenState extends State<HymnsScreen> {
  late List<Hymn> hymnsToList = [];
  bool isWithTitle = false;

  Future<void> _getHymns() async {
    final List<Hymn> hymns =
        await HymnRepository(
          helper: DatabaseHelper(
            dbName: 'cc.sqlite',
            dbPath: 'lib/database/attachments/cc.sqlite',
          ),
        ).getAllHymns();

    setState(() {
      hymnsToList = hymns;
    });
  }

  @override
  void initState() {
    _getHymns();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cantor Cristão',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        forceMaterialTransparency: true,
        actions: [
          IconButton(
            onPressed:
                () => setState(() {
                  isWithTitle = !isWithTitle;
                }),
            icon: Icon(isWithTitle ? Icons.numbers : Icons.text_format),
          ),
        ],
      ),
      body:
          isWithTitle
              ? SingleChildScrollView(
                child: Column(
                  children:
                      hymnsToList
                          .map(
                            (hymnMap) => HymnCard(
                              hymnTitle: hymnMap.title,
                              hymnId: hymnMap.id,
                              hymnNum: hymnMap.hymnNumber,
                              isWithTitle: isWithTitle,
                            ),
                          )
                          .toList(),
                ),
              )
              : GridView.count(
                mainAxisSpacing: 24,
                crossAxisSpacing: 24,
                crossAxisCount: 4,
                children:
                    hymnsToList
                        .map(
                          (hymnMap) => HymnCard(
                            hymnTitle: hymnMap.title,
                            hymnId: hymnMap.id,
                            hymnNum: hymnMap.hymnNumber,
                            isWithTitle: isWithTitle,
                          ),
                        )
                        .toList(),
              ),
    );
  }
}
