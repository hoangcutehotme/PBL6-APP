import 'package:flutter/material.dart';
import 'package:pbl6_app/src/values/app_colors.dart';
import 'package:pbl6_app/src/values/app_styles.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Function() press;
  final Color textColor, background;
  final Size size;

  const RoundedButton({
    super.key,
    required this.text,
    required this.press,
    this.textColor = Colors.white,
    this.background = AppColors.mainColorBlue,
    this.size = const Size(256, 56),
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: ElevatedButton(
        onPressed: press,
        style: ElevatedButton.styleFrom(
          backgroundColor: background,
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(60.0)),
          minimumSize: size,
        ),
        child: Text(
          text,
          style: AppStyles.textMedium.copyWith(
            color: textColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
