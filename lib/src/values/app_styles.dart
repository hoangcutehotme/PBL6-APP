import 'package:flutter/material.dart';
import 'package:pbl6_app/src/values/app_colors.dart';
import 'package:pbl6_app/src/values/app_fonts.dart';

class AppStyles {
  static const TextStyle textBold = TextStyle(
      fontFamily: AppFonts.poppins,
      fontSize: 30,
      color: AppColors.black,
      fontWeight: FontWeight.w600);
  static const TextStyle textMedium = TextStyle(
      fontFamily: AppFonts.poppins,
      fontSize: 15,
      color: AppColors.colorTextBold,
      fontWeight: FontWeight.w400);
  static const TextStyle textSmall = TextStyle(
      fontFamily: AppFonts.poppins,
      fontSize: 12,
      color: AppColors.colorTextBold,
      fontWeight: FontWeight.w300);
  static const TextStyle textBoldButton = TextStyle(
      fontFamily: AppFonts.poppins,
      fontSize: 15,
      color: AppColors.mainColorBackground,
      fontWeight: FontWeight.bold);
  static const TextStyle textSemiBold = TextStyle(
      fontFamily: AppFonts.poppins,
      fontSize: 16,
      color: AppColors.colorTextBold,
      fontWeight: FontWeight.w500);
}
