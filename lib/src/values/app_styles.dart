import 'package:flutter/material.dart';
import 'package:pbl6_app/src/values/app_colors.dart';
import 'package:pbl6_app/src/values/app_fonts.dart';

class AppStyles {
  static const TextStyle textBold = TextStyle(
      fontFamily: AppFonts.inter,
      fontSize: 30,
      color: AppColors.colorTextBold,
      fontWeight: FontWeight.w600);
  static const TextStyle textMedium = TextStyle(
      fontFamily: AppFonts.inter,
      fontSize: 16,
      color: AppColors.colorTextBold,
      fontWeight: FontWeight.w400);
  static const TextStyle textSmall = TextStyle(
      fontFamily: AppFonts.inter,
      fontSize: 12,
      color: AppColors.colorTextBold,
      fontWeight: FontWeight.w300);
  static const TextStyle textBoldButton = TextStyle(
      fontFamily: AppFonts.inter,
      fontSize: 15,
      color: AppColors.mainColorBackground,
      fontWeight: FontWeight.bold);
}
