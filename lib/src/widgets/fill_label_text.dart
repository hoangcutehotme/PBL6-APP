import 'package:flutter/material.dart';
import 'package:pbl6_app/src/values/app_styles.dart';

class FillLabelText extends StatelessWidget {
  const FillLabelText({
    super.key,
    required this.label,
    required this.child,
  });
  final Widget child;
  final String label;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            label,
            style: AppStyles.textBold.copyWith(fontSize: 16),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 10),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
          alignment: Alignment.center,
          width: size.width * 0.8,
          height: 56,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: Colors.black38,
                width: 1.0,
              )),
          child: child,
        ),
      ],
    );
  }
}
