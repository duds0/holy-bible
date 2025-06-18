import 'package:holy_bible/models/version.dart';

class Constants {
  static List<Version> versions = [
    Version(
      dbName: 'ARA.sqlite',
      dbPath: 'lib/database/attachments/ARA.sqlite',
      nickName: 'ARA',
    ),
    Version(
      dbName: 'NTLH.sqlite',
      dbPath: 'lib/database/attachments/NTLH.sqlite',
      nickName: 'NTLH',
    ),
    Version(
      dbName: 'ACF.sqlite',
      dbPath: 'lib/database/attachments/ACF.sqlite',
      nickName: 'ACF',
    ),
    Version(
      dbName: 'JFAA.sqlite',
      dbPath: 'lib/database/attachments/JFAA.sqlite',
      nickName: 'JFAA',
    ),
    Version(
      dbName: 'KJA.sqlite',
      dbPath: 'lib/database/attachments/KJA.sqlite',
      nickName: 'KJA',
    ),
    Version(
      dbName: 'KJF.sqlite',
      dbPath: 'lib/database/attachments/KJF.sqlite',
      nickName: 'KJF',
    ),
    // Version(
    //   dbName: 'NAA.sqlite',
    //   dbPath: 'lib/database/attachments/NAA.sqlite',
    //   nickName: 'NAA',
    // ),
  ];
}
