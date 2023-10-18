import 'package:flutter/material.dart';

class HistoryOrderTab extends StatefulWidget {
  const HistoryOrderTab({super.key});

  @override
  State<HistoryOrderTab> createState() => _HistoryOrderTabState();
}

class _HistoryOrderTabState extends State<HistoryOrderTab> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text("Lich su")),
        ],
      ),
    );
  }
}
