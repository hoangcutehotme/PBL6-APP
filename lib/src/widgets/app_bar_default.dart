import 'package:flutter/material.dart';

import '../values/app_colors.dart';
import '../values/app_styles.dart';

class AppWidget {
  static AppBar appBar(String title) {
    return AppBar(
      foregroundColor: AppColors.mainColor1,
      backgroundColor: AppColors.mainColorBackground,
      shadowColor: Colors.transparent,
      title: Text(
        title,
        style: AppStyles.textBold
            .copyWith(fontSize: 20, fontWeight: FontWeight.w500),
      ),
    );
  }
}
