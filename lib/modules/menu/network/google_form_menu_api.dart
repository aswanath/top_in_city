import 'package:gsheets/gsheets.dart';

class GoogleSheetsMenuApi {
  static const _spreadSheetId = "1aYHAv8axNov6vV1Ckb0UMvToSp7kdNjne0ePuKMZrfU";
  static const _credentials = r'''
{
  "type": "service_account",
  "project_id": "topincity-374315",
  "private_key_id": "e688d3ec79c15a847fd1f2f6eaf2da3396fc37ec",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCPseEreSSSbWrB\n+WtJjDMdPpDnAdUxva1dgeuipakhvvtsmvKuVbZx6JHSJcACp4+tOQewvmTAJ+5h\nNPoEfxjEzEUNgl4smBM5ghvPhhWNIujshG0T+FrwJNtS1dWqYHce1W4E7lYAk3sU\n0J/somxqCMMPfpmFUpI+ed4fGaVtGtSMrrrv66z64NW5DTgsNaZyU1gwsNOXCiNk\nRNlyHvWAq14W29DjA7HgMOF49VfEPp+tfnvWKSwqoueg5Qx9hMdiIDpCwmivkkAU\npssq+z2wZz/DJ6SHaECEFeNZW8iG2WMIs/jrbfVrcXHwKCv8nUe0hGQgnJTVi176\noquPm2X/AgMBAAECggEAKmETYC9v1lG34TKO7lePgaoAsWjMeEmRNllJZiRGkAHU\nBDFkrn7v+oNVcm2Yxg+mI7gEqR9V9ogwWXH25NmZM/1sxjGzVaKaVOUnD5rjg0cO\n/CaIRxIBu/6awsD3LbManrjipEioi63zaG2pJPC4WcNwyAKWA4iZQhzOIkz9iYIl\nl4P4+GQ+J55ETn8GdmWRKAzUIROCYS+K76kgFJWvaQY+QK7SU4BSVLy3RMonV8Je\nKiA8cdHvz3HhmdzHl2M9T5FgxQ7qu/MTYPzUJJZ01xIku4ehBL3706gDC6HgOuN5\nFZqaUS9aHnSPmz9aHKz9BARcrVNRnD9H4FmhzpB7UQKBgQDBkmVsdZ/eZS/8ub9p\n42RBM8CRlc8p3xJE3ytfYh1xEVlJi761V0I3Cmj1hieE57fUS3h9NxaPSBwrubaY\npbgRhub7X2kpxbues3wrBd9Ifzmrg0uVDPDzj7AjidDPKyKBHq8Uj22z3HPB4++s\nslbcRS6K0v/TJP1vyeAG6NuuLwKBgQC+CY5/O7SckWg9wmg1qrqbd3Wg5FrF4zMv\nF1+BQhtpJ5XZg0dKtLufC5fvoxQf7vXaKf/rxgAbt7QkjzLUm0D4OmCp/Ekwdxon\ncraFWG5anOrNTicICVzqkIxBaitGwAboQeASpVCTEaW/rdOKm3vLEXBQ1zRxOH4l\nILN2cdUhMQKBgGB3KHxIkgcuvh9gIfgPDiNAOzNSSQ9Az8XqwZ6jMrDqSGjSb5PH\njIQJeA0DciZVo9L0WXNtRJza/s77mfewfm6dn/adsbbTh5CrObHnF0L1xDOpFr2M\n2XdHoCvVvm2/vU5DkFTatXzw2+9APGz/4zGaeHtOc5cx0+sl27MV0ISZAoGANtAc\n2NgIzUwnjADB/BDFiEgZlpGnGQLiZYfRVUATFe6EC1wRORwOLd6zMTyRdnB/WzDY\nD1Jp/5SqEg13tNkfEToNXZpWJfOEiLJOsQGDuwEdvJ/5JBlHQqT0v313BA4pL96o\nWdhy+CiT7UifBpC4USczhS29g5au09itytEkj1ECgYEAix6+CwBtbk/gdZFztQEB\nOeWZvGxH+xqX0RTgadbUB4QQw7qEOrbEmkhghSHupiMfcReqgP3mpmLulmUGWhn9\nKJUrXVuoK7bFhByK4h0jFPS37Eg2JcvNCOm0y+InRg+8ZGKQFuyYtg+tn/f5dGUt\nHWQTwxU+nwMriWpExC3DF5A=\n-----END PRIVATE KEY-----\n",
  "client_email": "menu-lists@topincity-374315.iam.gserviceaccount.com",
  "client_id": "101085540771971410627",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/menu-lists%40topincity-374315.iam.gserviceaccount.com"
}
  ''';
  static final _gSheets = GSheets(_credentials);
  static List<Worksheet>? _menuList;
  static Spreadsheet? spreadsheet;

  static List<Worksheet>? get menuList => _menuList;

  static Future init() async {
    spreadsheet = await _gSheets.spreadsheet(_spreadSheetId);
    _menuList = spreadsheet?.sheets;
  }

  static Future<Worksheet?> getWorkSheet({
    required String title,
  }) async {
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
