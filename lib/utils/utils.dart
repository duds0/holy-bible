import 'package:flutter/material.dart';

class Utils {
  static const Map<String, Color> bibleDivisionColors = {
    'lei': Color(0xFFF6D776),
    'historicos': Color(0xFFFFAB76),
    'poeticos': Color(0xFF76C1FF),
    'prof_maiores': Color(0xFFF28B82),
    'prof_menores': Color(0xFF81C784),
    'evangelhos': Color(0xFFB39DDB),
    'atos': Color(0xFF4DD0E1),
    'paulinas': Color(0xFFF48FB1),
    'gerais': Color(0xFF90A4AE),
    'apocalipse': Color(0xFF9575CD),
  };

  static const Map<String, RangeValues> bibleDivisionRanges = {
    'lei': RangeValues(1, 5),
    'historicos': RangeValues(6, 17),
    'poeticos': RangeValues(18, 22),
    'prof_maiores': RangeValues(23, 27),
    'prof_menores': RangeValues(28, 39),
    'evangelhos': RangeValues(40, 43),
    'atos': RangeValues(44, 44),
    'paulinas': RangeValues(45, 57),
    'gerais': RangeValues(58, 65),
    'apocalipse': RangeValues(66, 66),
  };

  static String getDivisionById(int id) {
    for (final entry in bibleDivisionRanges.entries) {
      if (id >= entry.value.start && id <= entry.value.end) {
        return entry.key;
      }
    }
    return 'unknown';
  }

  static const Map<String, String> bibleBookAbbreviations = {
    // Pentateuco
    'Gênesis': 'Gn',
    'Êxodo': 'Êx',
    'Levítico': 'Lv',
    'Números': 'Nm',
    'Deuteronômio': 'Dt',

    // Históricos
    'Josué': 'Js',
    'Juízes': 'Jz',
    'Rute': 'Rt',
    '1 Samuel': '1Sm',
    '2 Samuel': '2Sm',
    '1 Reis': '1Rs',
    '2 Reis': '2Rs',
    '1 Crônicas': '1Cr',
    '2 Crônicas': '2Cr',
    'Esdras': 'Ed',
    'Neemias': 'Ne',
    'Ester': 'Et',

    // Poéticos e Sabedoria
    'Jó': 'Jó',
    'Salmos': 'Sl',
    'Provérbios': 'Pv',
    'Eclesiastes': 'Ec',
    'Cânticos': 'Ct',

    // Profetas Maiores
    'Isaías': 'Is',
    'Jeremias': 'Jr',
    'Lamentações': 'Lm',
    'Ezequiel': 'Ez',
    'Daniel': 'Dn',

    // Profetas Menores
    'Oséias': 'Os',
    'Joel': 'Jl',
    'Amós': 'Am',
    'Obadias': 'Ob',
    'Jonas': 'Jn',
    'Miquéias': 'Mq',
    'Naum': 'Na',
    'Habacuque': 'Hc',
    'Sofonias': 'Sf',
    'Ageu': 'Ag',
    'Zacarias': 'Zc',
    'Malaquias': 'Ml',

    // Evangelhos
    'Mateus': 'Mt',
    'Marcos': 'Mc',
    'Lucas': 'Lc',
    'João': 'Jo',

    // Atos
    'Atos dos Apóstolos': 'At',

    // Cartas Paulinas
    'Romanos': 'Rm',
    '1 Coríntios': '1Co',
    '2 Coríntios': '2Co',
    'Gálatas': 'Gl',
    'Efésios': 'Ef',
    'Filipenses': 'Fp',
    'Colossenses': 'Cl',
    '1 Tessalonicenses': '1Ts',
    '2 Tessalonicenses': '2Ts',
    '1 Timóteo': '1Tm',
    '2 Timóteo': '2Tm',
    'Tito': 'Tt',
    'Filemom': 'Fm',

    // Cartas Gerais
    'Hebreus': 'Hb',
    'Tiago': 'Tg',
    '1 Pedro': '1Pe',
    '2 Pedro': '2Pe',
    '1 João': '1Jo',
    '2 João': '2Jo',
    '3 João': '3Jo',
    'Judas': 'Jd',

    // Profecia
    'Apocalipse': 'Ap',
  };

  static String getAbbreviation(String bookName) {
    return bibleBookAbbreviations[bookName] ?? bookName;
  }
}
