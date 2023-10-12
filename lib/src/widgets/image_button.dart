// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../values/app_assets.dart';
import '../values/app_colors.dart';

class ImageButton extends StatelessWidget {
  final String image;
  final Function() press;
  final Size size;
  const ImageButton({
    Key? key,
    required this.image,
    required this.press,
    this.size = const Size(20, 20),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        width: 20,
        height: 20,
        alignment: Alignment.bottomRight,
        decoration: BoxDecoration(
            color: AppColors.mainColor1,
            borderRadius: BorderRadius.circular(3)),
        child: Image.asset(
          image,
          width: size.width,
          height: size.height,
        ),
      ),
    );
  }
}
