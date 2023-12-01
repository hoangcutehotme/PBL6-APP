import 'package:flutter/material.dart';
import 'package:pbl6_app/src/widgets/app_bar_default.dart';

class OrderDetailShipperScreen extends StatelessWidget {
  final String id;
  const OrderDetailShipperScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppWidget.appBar('Chi tiết đơn hàng'),
      body: Column(children: [
        Container(
          child: Column(children: [
            Text('Địa chỉ cửa hàng'),
            
          ]),
        )
      ]),
    );
  }
}
