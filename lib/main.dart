import 'package:flutter/material.dart';
import 'package:top_in_city/core/network/google_sheets_api.dart';
import 'package:top_in_city/presentation/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GoogleSheetsApi.init();
  runApp(const MyApp());
}
