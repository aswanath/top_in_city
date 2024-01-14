import 'dart:async';

import 'package:gsheets/gsheets.dart';
import 'package:top_in_city/key/google_sheets_keys.dart';

class GoogleSheetsFormApi {
  static const _spreadSheetId = "1txNu0Z4pqaWnNvTLUE2sBSuWWd5aQk4gG9l6pu8GD-g";
  static const _credentials = formApiKey;
  static final _gSheets = GSheets(_credentials);
  static Worksheet? _worksheet;
  static Worksheet? _imageWorksheet;
  static List<String> images = [];

  static FutureOr init(Map map) async {
    final spreadsheet = await _gSheets.spreadsheet(_spreadSheetId);
    _worksheet = getWorkSheet(spreadSheet: spreadsheet, title: 'Top In City - Queries');
    _imageWorksheet = getWorkSheet(spreadSheet: spreadsheet, title: 'Images');
    images = (await _imageWorksheet?.values.allColumns())?.first ?? [];
  }

  static Worksheet getWorkSheet({
    required Spreadsheet spreadSheet,
    required String title,
  }) =>
      spreadSheet.worksheetByTitle(title)!;

  static Future<bool> createField(Map<String, dynamic> rowMap) async {
    if (_worksheet == null) return false;
    return await _worksheet!.values.map.appendRow(rowMap);
  }
}
