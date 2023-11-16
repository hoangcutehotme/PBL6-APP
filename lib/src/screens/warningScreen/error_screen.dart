import 'package:flutter/material.dart';

import '../../values/app_colors.dart';

class ErrorScreen extends StatefulWidget {
  const ErrorScreen({super.key});

  @override
  State<ErrorScreen> createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  late bool isLoading;

  @override
  void initState() {
    super.initState();
    isLoading = true;

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    // Clean up resources here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBar(
            foregroundColor: AppColors.mainColor1,
            backgroundColor: AppColors.mainColorBackground,
            shadowColor: Colors.transparent,
          ),
          Expanded(
              child: Center(
            child: isLoading
                ? const CircularProgressIndicator()
                : const Text('Something wrong'),
          )),
        ],
      ),
    );
  }
}
