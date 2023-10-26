// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../model/store_model.dart';
import '../values/app_colors.dart';
import '../values/app_styles.dart';

class StoreCard extends StatelessWidget {
  const StoreCard({
    super.key,
    required this.storie,
    required this.press,
    this.size = const Size(240, 160),
  });

  final StoreModel storie;
  final Function() press;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      decoration: const BoxDecoration(),
      child: GestureDetector(
        onTap: press,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.network(
                storie.images,
                width: size.width,
                height: size.height,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  return SizedBox(
                    width: size.width,
                    height: size.height,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
                errorBuilder: (BuildContext context, Object error,
                    StackTrace? stackTrace) {
                  return Container(
                    width: size.width,
                    height: size.height,
                    decoration: BoxDecoration(
                        color: AppColors.placeholder,
                        borderRadius: BorderRadius.circular(7)),
                    child: const Icon(Icons.error_outline),
                  ); // Widget to display when the image fails to load
                },
              ),
            ),
            Text(
              storie.name,
              maxLines: 1,
              style: AppStyles.textBold.copyWith(fontSize: 18),
            ),
            Row(
              children: [
                const Icon(Icons.star_outlined, color: Colors.amber),
                Text(
                  storie.ratingAverage.toString(),
                  style: AppStyles.textMedium,
                ),
                Text(
                  " | ",
                  style: AppStyles.textMedium
                      .copyWith(fontSize: 20, color: AppColors.borderGray),
                ),
                const Icon(
                  Icons.location_on,
                  color: AppColors.mainColor1,
                ),
                // Text("${stories[index].distance.toString()} km",
                //     style: AppStyles.textMedium),
                Text(
                  " | ",
                  style: AppStyles.textMedium
                      .copyWith(fontSize: 20, color: AppColors.borderGray),
                ),
                // Text(
                //   "${storie.openAt} - ${storie.closeAt}",
                //   style: AppStyles.textMedium,
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
