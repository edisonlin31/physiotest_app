import 'package:flutter/material.dart';

class AppColors {
  AppColors._();
  static const Color primary = Colors.teal;
  static const Color lightGrey = Color.fromRGBO(249, 249, 249, 1);
  static const Map<int, Color> color = {
    50: Color.fromRGBO(136, 14, 79, .1),
    100: Color.fromRGBO(136, 14, 79, .2),
    200: Color.fromRGBO(136, 14, 79, .3),
    300: Color.fromRGBO(136, 14, 79, .4),
    400: Color.fromRGBO(136, 14, 79, .5),
    500: Color.fromRGBO(136, 14, 79, .6),
    600: Color.fromRGBO(136, 14, 79, .7),
    700: Color.fromRGBO(136, 14, 79, .8),
    800: Color.fromRGBO(136, 14, 79, .9),
    900: Color.fromRGBO(136, 14, 79, 1),
  };
  static const List<Color> softColors = [
    Color(0xFFFAE1C4), // Soft Sand
    Color(0xFFE3F2FD), // Light Blue
    Color(0xFFE8F5E9), // Mint Green
    Color(0xFFFFF3E0), // Pastel Orange
    Color(0xFFF3E5F5), // Lavender
  ];
}
