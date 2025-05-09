import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/utils/colors_manager.dart';

abstract class TextStyleManager {
  static const TextStyle blackSemiBold20 = TextStyle(
      color: ColorsManager.black, fontWeight: FontWeight.w600, fontSize: 20);

  static const TextStyle blackBold16 = TextStyle(
      color: ColorsManager.black, fontWeight: FontWeight.bold, fontSize: 16);

  static const TextStyle blackSemiBold15 = TextStyle(
      color: ColorsManager.black, fontWeight: FontWeight.w600, fontSize: 15);

  static const TextStyle whiteRegular16 = TextStyle(
      color: ColorsManager.white, fontWeight: FontWeight.w500, fontSize: 16);
  static const TextStyle taleRegular16 = TextStyle(
      color: ColorsManager.blue700, fontWeight: FontWeight.w500, fontSize: 16);

  static const TextStyle greyRegular14 = TextStyle(
      color: ColorsManager.grey, fontWeight: FontWeight.w400, fontSize: 14);

  static TextStyle grey600Regular16 = TextStyle(
      color: ColorsManager.grey600, fontWeight: FontWeight.w400, fontSize: 16);
}
