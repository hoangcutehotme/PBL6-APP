import 'package:flutter/material.dart';

import '../values/app_colors.dart';

class Skelton extends StatelessWidget {
  const Skelton({
    super.key,
    this.width,
    this.height,
  });

  final double? width, height;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      width: width,
      height: height,
      decoration: BoxDecoration(
          color: AppColors.placeholder,
          borderRadius: BorderRadius.circular(10)),
    );
  }
}
