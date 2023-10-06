import 'package:flutter/material.dart';
import 'package:pbl6_app/src/values/app_colors.dart';

class DetailShop extends StatefulWidget {
  const DetailShop({super.key});

  @override
  State<DetailShop> createState() => _DetailShopState();
}

class _DetailShopState extends State<DetailShop> {
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
