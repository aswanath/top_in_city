import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:top_in_city/presentation/core/theme/light_theme.dart';
import 'package:top_in_city/presentation/pages/home/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Top In City',
      theme: lightTheme,
      themeMode: ThemeMode.light,
      home: const HomePage(),
      builder: (context, child) => ResponsiveWrapper.builder(
        child,
        minWidth: 480,
        defaultScale: true,
        breakpoints: const [
           ResponsiveBreakpoint.autoScale(480, name: MOBILE),
           ResponsiveBreakpoint.resize(600, name: MOBILE),
           ResponsiveBreakpoint.resize(850, name: TABLET),
           ResponsiveBreakpoint.resize(1080, name: DESKTOP),
        ],
      ),
    );
  }
}
