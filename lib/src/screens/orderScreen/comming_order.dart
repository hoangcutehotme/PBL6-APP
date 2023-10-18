import 'package:flutter/material.dart';

class CommingOrderTab extends StatefulWidget {
  const CommingOrderTab({super.key});

  @override
  State<CommingOrderTab> createState() => _CommingOrderTabState();
}

class _CommingOrderTabState extends State<CommingOrderTab> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text("Dang den")),
        ],
      ),
    );
  }
}
