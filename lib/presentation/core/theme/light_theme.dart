import 'package:flutter/material.dart';
import 'package:top_in_city/core/asset_constants.dart';
import 'package:top_in_city/core/constants.dart';

final lightTheme = ThemeData(
  // fontFamily: josefinSans,
  primarySwatch: Colors.grey,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    elevation: 10,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(22),
      ),
    ),
  ),
  textTheme: TextTheme(
    headlineLarge: TextStyle(
      fontFamily: chilanka,
      fontSize: 32,
      foreground: Paint()..shader = linearGradient,
    ),
    titleLarge: TextStyle(
      fontFamily: chilanka,
      fontSize: 20,
      foreground: Paint()..shader = linearGradient,
    ),
  ),
);
