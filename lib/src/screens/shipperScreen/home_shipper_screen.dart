import 'package:flutter/material.dart';

class ScreenDetailOrderAndShipper extends StatefulWidget {
  const ScreenDetailOrderAndShipper({super.key});

  @override
  State<ScreenDetailOrderAndShipper> createState() =>
      _ScreenDetailOrderAndShipperState();
}

class _ScreenDetailOrderAndShipperState
    extends State<ScreenDetailOrderAndShipper> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(children: [
          BottomSheet(
              onClosing: () {},
              builder: (BuildContext context) {
                return const Column(
                  children: [
                    Text('Yell'),
                  ],
                );
              })
        ]),
      ),
    );
  }
}
