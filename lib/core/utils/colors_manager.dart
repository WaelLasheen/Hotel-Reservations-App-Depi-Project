import 'package:flutter/material.dart';

abstract class ColorsManager {
  static const Color black = Colors.black;
  static const Color white = Colors.white;
  static const Color grey = Colors.grey;
  static Color grey300 = Colors.grey.shade300;
  static Color grey100 = Colors.grey.shade100;
  static Color grey600 = Colors.grey.shade600;
  static const Color blue = Color(0xff009fd4);
  static const Color blue700 = Color(0xFF1976D2);
  static const Color blue4 = Color(0x091976D2);
  static const Color blue20 = Color(0x331976D2);

  // Auth colors
  static const Color primary = Color(0xFF2B2D42);
  static const Color secondary = Color(0xFF8D99AE);
  static const Color accent = Color(0xFFEF233C);
  static const Color background = Color(0xFFEDF2F4);
  static const Color surface = Colors.white;
  static const Color error = Color(0xFFD32F2F);
  static const Color success = Color(0xFF388E3C);
}
