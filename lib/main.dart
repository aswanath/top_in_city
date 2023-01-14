import 'package:flutter/material.dart';
import 'package:top_in_city/modules/app.dart';
import 'package:top_in_city/modules/menu/network/google_form_menu_api.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await GoogleSheetsMenuApi.init();
  // await GoogleSheetsMenuApi.getWorkSheet(title: 'Sadhya Packages ( Veg )');
  runApp(const MyApp());
}
