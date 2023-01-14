import 'package:gsheets/gsheets.dart';

class GoogleSheetsFormApi {
  static const _spreadSheetId = "1txNu0Z4pqaWnNvTLUE2sBSuWWd5aQk4gG9l6pu8GD-g";
  static const _credentials = r'''
  {
  "type": "service_account",
  "project_id": "topincity-374315",
  "private_key_id": "349589972e522731806624e8a5afc3edd542f669",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEuwIBADANBgkqhkiG9w0BAQEFAASCBKUwggShAgEAAoIBAQCwt2L08gC7E7KF\nLzuoOMoUzlRBrbRT8nLPMj2nXXGcohPmdRECUi4od54qAf+MSlzhveUj1Zkzq+C2\nZnbJKz3QzgIteHYMHNOKGbpg64ATTkBXzLKmQMZGWDlGlSjsnprJwq2tln28O09R\nrx0jKoYebYvjiAXmmulyntq21j1IRgKX7k7JJzqXRtPZMahh3ZV7cu7GpkoTUTcP\nAq5d203rh4d6X7AcC5dVPPEMQlQWxm596gaHGAezI0XdkAXqIrUXeCf1ortDj+5U\nvo56z3skDuTXxUBiPdqSQjOCLf4DFcrz6UTjvd9fR34mdZ+2CdbbIZ4cn1DfHcBZ\nH9jH5p/rAgMBAAECgf9jBGg7k+8KBblk2I2XSAp6bbMHI8jHqyLeo/OMGeWHujrD\nRQCcMcIkEULshZxgMhWHFYbAmYbWaqsIhD91DqFrW9LmM6BlZ96FgKsNgaipwyx1\n3yvG/B8OmLKg77kZKbJOA/U03VDQisuqoALJSbX056Hw1K6gY+3oMRWV/I1jpfbk\np13a9As8HybDG5P+FY0hf4UH5uyGzNc/4ySOcZ109Bu0zB7zi0I028AQKRF/q5qG\nH5q5c+aMsCxyCJGeg3+4Av6ZLeJDQal67m/dg7kCVu5E4sIwkMrtzAOu6W+3Ad3t\nXt0qJuPQNBoPPjvELNk9U5vn1kDld4O1JuXBPeECgYEA2l0yFlRNgQMctH0b4Oc9\nr4jKbUhoB38K1rjEEviFm+hVmcoWztvwP+e7jiT5L7xSlf1zmGaTNcjZGKHdiSdU\nGQRcHaD8PKFzARgw0ZE50nH3tkSKwkxehAKYAxOtQiM/tjX8diLHIxOPEuUdySWF\njl5i24mr3anwv0kwyWV+CcsCgYEAzyyVZzZWeobauOF9eXtC0JpDIja5/Q3BQCQN\nP8VM1honz7h3qET263IUAlFDUU8mbwthRflShmHbLdHYtu2gc7CUcfciDmuMO5v3\n1pj05d8EalphBAmCIO4CLWLMYs026eieo0T3yHafIWUpc9Fu5c8Mrjmg4sEqc9zK\nVlCZfmECgYEAoeeXy5aWIKH+FpTspsTNp+j0rjKRb31yu+Ii/y3lYsPRNEXyw02v\nxLI9Dhe76vjnAu75VnY3kBlrXigl6huO7z2cTxud6haK/rTA/aGADdkSocIQYB/f\ntGF39FASlocsJh3BIpaGsCtAWfInM4zuibDR+5UIKUJnjmzmD22BFiECgYBrMHIM\neLy9oFBCH8i/tdqX+3iIlzAbkaZO/VgtinN6wwWeH58pXKU0pE1d9ZWS2BTWl1i4\nz4q3JKI2TsCFxOSjdtUXMfpY46Qmo0fTrEfpNz4dmK1hXVoKl5pgySFebTbgRw7t\nAp4BBf7HVIPh/JYYKMwyyHZJXBAO6kl15zXDgQKBgCqLKjigcv1kt/uE1YnLBuKN\nrcq50lInkJWKrRes7SMqCU+6v2rcKFYf2XrMl/GHL/0w48yU7mArMOhzN4nuTwVd\nGa9z0QTLKNNviyVZQXviAEvS1rX6Rq9NYqFTczJV4C1V3nIJ+OQVEcTc7+FBS3YM\nfxca+88JRQ5/eDGqR2gR\n-----END PRIVATE KEY-----\n",
  "client_email": "top-in-city@topincity-374315.iam.gserviceaccount.com",
  "client_id": "109199339792046955602",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/top-in-city%40topincity-374315.iam.gserviceaccount.com"
}
  ''';
  static final _gSheets = GSheets(_credentials);
  static Worksheet? _worksheet;

  static Future init() async {
    final spreadsheet = await _gSheets.spreadsheet(_spreadSheetId);
    _worksheet = await getWorkSheet(spreadSheet: spreadsheet, title: 'Top In City - Queries');
  }

  static Future<Worksheet> getWorkSheet({
    required Spreadsheet spreadSheet,
    required String title,
  }) async {
    try {
      return spreadSheet.worksheetByTitle(title)!;
    } catch (e) {
      return await spreadSheet.addWorksheet(title);
    }
  }

  static Future<bool> createField(Map<String, dynamic> rowMap) async {
    if (_worksheet == null) return false;
    return await _worksheet!.values.map.appendRow(rowMap);
  }
}
