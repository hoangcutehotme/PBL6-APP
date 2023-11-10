import 'package:flutter/material.dart';
import 'package:pbl6_app/src/values/app_colors.dart';

import '../../widgets/order_item.dart';

class CommingOrderTab extends StatefulWidget {
  const CommingOrderTab({super.key});

  @override
  State<CommingOrderTab> createState() => _CommingOrderTabState();
}

class _CommingOrderTabState extends State<CommingOrderTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // body: OrderItem(),

        body: ListView.separated(
            itemBuilder: (BuildContext context, index) {
              return const OrderItem();
            },
            separatorBuilder: (BuildContext context, index) {
              return const Divider(
                color: AppColors.placeholder,
                thickness: 5.0,
                height: 20,
              );
            },
            itemCount: 4));
  }
}
