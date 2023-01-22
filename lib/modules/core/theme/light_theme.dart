import 'package:flutter/material.dart';
import 'package:top_in_city/core/asset_constants.dart';

final lightTheme = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  primaryColor: Colors.black,
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
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(Colors.black),
      padding: MaterialStateProperty.all(
        const EdgeInsets.all(20),
      ),
    ),
  ),
  textTheme: TextTheme(
    headlineLarge: const TextStyle(
      fontFamily: chilanka,
      fontSize: 26,
    ),
    headlineMedium: const TextStyle(
      fontFamily: josefinSans,
      fontWeight: FontWeight.w100,
      color: Colors.black,
      fontSize: 22,
    ),
    headlineSmall: const TextStyle(
      fontFamily: josefinSans,
      fontWeight: FontWeight.w400,
      color: Colors.black,
      fontSize: 18,
    ),
    titleLarge: const TextStyle(
      fontFamily: chilanka,
      fontSize: 17,
    ),
    titleMedium: const TextStyle(
      fontFamily: josefinSans,
      fontWeight: FontWeight.w400,
      fontSize: 18,
    ),
    bodyMedium: const TextStyle(
      fontFamily: josefinSans,
      fontWeight: FontWeight.w400,
      fontSize: 18,
    ),
    bodySmall: TextStyle(
      fontFamily: josefinSans,
      fontSize: 9,
      height: 1.5,
      color: Colors.black.withOpacity(.6),
    ),
    titleSmall: const TextStyle(
      fontSize: 12,
    ),
    bodyLarge: const TextStyle(
      fontFamily: josefinSans,
      fontWeight: FontWeight.w400,
      color: Colors.white,
      fontSize: 14,
    ),
  ),
);
