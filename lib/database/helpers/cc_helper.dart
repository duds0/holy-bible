// import 'dart:io';
// import 'package:flutter/services.dart';
// import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:sqflite/sqflite.dart';

// class DatabaseHelperCC {
//   static Database? _database;

//   Future<Database> get database async {
//     if (_database != null) return _database!;
//     _database = await _initDatabase();
//     return _database!;
//   }

//   Future<Database> _initDatabase() async {
//     final documentsDirectory = await getApplicationDocumentsDirectory();
//     final path = join(documentsDirectory.path, 'cc.sqlite');

//     if (!await File(path).exists()) {
//       final data = await rootBundle.load('lib/database/attachments/cc.sqlite');
//       final bytes = data.buffer.asUint8List(
//         data.offsetInBytes,
//         data.lengthInBytes,
//       );
//       await File(path).writeAsBytes(bytes);
//     }

//     return await openDatabase(path, readOnly: true);
//   }
// }
