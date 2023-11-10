import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageLoadingNetwork extends StatelessWidget {
  const ImageLoadingNetwork({
    super.key,
    required this.image,
    required this.size,
  });

  final String image;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      width: size.width,
      height: size.height,
      imageUrl: image,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
      placeholder: (context, url) => Container(
          // color: AppColors.grayBold,
          child: Container(
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 216, 216, 216),
                  borderRadius: BorderRadius.circular(8)),
              child: const Center(child: CircularProgressIndicator()))),
      errorWidget: (context, url, error) => Container(
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 216, 216, 216),
            borderRadius: BorderRadius.circular(8)),
        child: const Center(child: Icon(Icons.error)),
      ),
    );
  }
}
