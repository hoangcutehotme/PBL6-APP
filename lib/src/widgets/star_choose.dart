import 'package:flutter/material.dart';

class StarChoose extends StatelessWidget {
  const StarChoose({
    super.key,
    required this.rate,
  });

  final int rate;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var i = 0; i < 5; i++)
          i < rate
              ? const Icon(
                  Icons.star,
                  color: Colors.amber,
                )
              : const Icon(
                  Icons.star_border_purple500_outlined,
                  color: Colors.amber,
                )
      ],
    );
  }
}
