import 'dart:async';
import 'package:gsheets/gsheets.dart';
import 'package:top_in_city/key/google_sheets_key.dart';

class GoogleSheetsMenuApi {
  static const _spreadSheetId = "1aYHAv8axNov6vV1Ckb0UMvToSp7kdNjne0ePuKMZrfU";
  static const _credentials = menuApiKey;
  static final _gSheets = GSheets(_credentials);
  static List<Worksheet>? _menuList;
  static Spreadsheet? spreadsheet;

  static List<Worksheet>? get menuList => _menuList;

  static FutureOr init(Map map) async {
    spreadsheet = await _gSheets.spreadsheet(_spreadSheetId);
    _menuList = spreadsheet?.sheets;
  }

  static Worksheet? getWorkSheet({
    required String title,
  }) {
    var sheet = spreadsheet?.worksheetByTitle(title)!;
    // var rows = await sheet?.values.allRows();
    // // print(rows);
    // var english = rows?.first[1];
    // var malayalam = rows?.first[2];
    // // print(english);
    // var englishList = english?.split(',').toList();
    // var malayalamList = malayalam?.split(',').toList();
    return sheet;
  }
}
