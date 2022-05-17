import 'package:blog_post_flutter/app/constant/app_dimens.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoundedCornerImageWidget extends StatelessWidget {
  final String imagePath;
  final BoxFit fit;
  final double cornerRadius;
  final bool isLocalImage;
  final double width;
  final double height;

  const RoundedCornerImageWidget(this.imagePath,
      {Key? key,
      this.fit = BoxFit.fill,
      this.cornerRadius = AppDimens.MARGIN_SMALL,
      this.isLocalImage = false,
      this.width = AppDimens.DEFAULT_IMAGE_VIEW_SIZE,
      this.height = AppDimens.DEFAULT_IMAGE_VIEW_SIZE})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(cornerRadius)),
      child: isLocalImage
          ? Image.asset(imagePath, fit: fit)
          : CachedNetworkImage(
              imageUrl: imagePath,
              fit: fit,
              width: width,
              height: height,
              placeholder: (context, url) => const CupertinoActivityIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
    );
  }
}
