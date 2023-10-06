import 'package:flutter/material.dart';
import 'package:pbl6_app/src/values/app_colors.dart';

class DetailCategory extends StatefulWidget {
  const DetailCategory({super.key});

  @override
  State<DetailCategory> createState() => _DetailCategoryState();
}

class _DetailCategoryState extends State<DetailCategory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBar(
            foregroundColor: AppColors.colorTextBold,
            backgroundColor: AppColors.mainColorBackground,
            shadowColor: Colors.transparent,
          ),
        ],
      ),
    );
  }
}
