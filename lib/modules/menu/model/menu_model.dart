// import 'dart:convert';
//
// List<MenuModelApi?>? addressResponseModelFromJson(String str) => json.decode(str) == null ? [] : List<MenuModelApi?>.from(json.decode(str)!.map((x) => MenuModelApi.fromJson(x)));
//
// class MenuModelApi {
//   final int id;
//   final int index;
//   final String spreadsheetId;
//   final String title;
//
//   MenuModelApi({
//     required this.id,
//     required this.index,
//     required this.title,
//     required this.spreadsheetId,
//   });
//
//   factory MenuModelApi.fromJson(Map<String, dynamic> json) {
//     return MenuModelApi(
//       id: json["id"],
//       index: json["index"],
//       title: json["title"],
//       spreadsheetId: json["spreadsheetId"],
//     );
//   }
// }
