import 'package:flutter/material.dart';
import 'package:pbl6_app/src/values/app_colors.dart';

import '../../values/app_styles.dart';

class ChangAddressUser extends StatefulWidget {
  const ChangAddressUser({super.key});

  @override
  State<ChangAddressUser> createState() => _ChangAddressUserState();
}

class _ChangAddressUserState extends State<ChangAddressUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: AppColors.mainColor1,
        backgroundColor: AppColors.mainColorBackground,
        title: Text(
          "Địa chỉ giao hàng",
          style: AppStyles.textBold
              .copyWith(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
