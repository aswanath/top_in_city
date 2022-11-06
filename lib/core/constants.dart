
import 'package:flutter/material.dart';

///?[MediaQuery] width and height, will be initialized in the first page.

late double width;
late double height;
final Shader linearGradient = const LinearGradient(
  colors: <Color>[Color(0xffA6A021), Color(0xffFF0303)],
).createShader(
  const Rect.fromLTWH(
    0.0,
    0.0,
    350.0,
    70.0,
  ),
);