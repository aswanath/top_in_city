import 'package:flutter/material.dart';
import 'package:top_in_city/presentation/core/core_screen.dart';
import 'package:top_in_city/presentation/core/theme/light_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Top In City',
      theme: lightTheme,
      themeMode: ThemeMode.light,
      home: const CoreScreen(),
    );
  }
}
