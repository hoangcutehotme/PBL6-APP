
import 'package:flutter/material.dart';

import '../values/app_assets.dart';
import '../values/app_colors.dart';
import '../values/app_styles.dart';

class OrderItem extends StatelessWidget {
  const OrderItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // to
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  'Đơn hàng xxx',
                  style: AppStyles.textBold.copyWith(fontSize: 16),
                ),
                Expanded(child: Container()),
                const Text(
                  '19:30',
                  style: AppStyles.textMedium,
                ),
              ],
            ),
          ),
          const Divider(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  AppAssets.bundauImage,
                  width: 145,
                  height: 100,
                  fit: BoxFit.fill,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: SizedBox(
                    height: 100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Bún đậu quán',
                          style: AppStyles.textBold.copyWith(fontSize: 14),
                        ),
                        // Expanded(child: Container()),
                        const Spacer(),
                        Text('1230000đ',
                            style: AppStyles.textBold.copyWith(
                                fontSize: 14, color: AppColors.mainColor1)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            color: AppColors.borderGray,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Row(
              children: [
                Expanded(child: Container()),
                const Text('Đã đặt đơn'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
