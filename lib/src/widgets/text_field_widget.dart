import 'package:flutter/material.dart';
import 'package:pbl6_app/src/values/app_styles.dart';

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  final String label;

  const TextFieldContainer({
    super.key,
    required this.child,
    this.label = '',
  });
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15, top: 10),
          child: Text(
            label,
            style: AppStyles.textMedium.copyWith(fontSize: 17),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 5),
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
