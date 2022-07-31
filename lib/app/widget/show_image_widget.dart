import 'dart:io';

import 'package:blog_post_flutter/app/constant/app_colors.dart';
import 'package:blog_post_flutter/app/constant/app_dimens.dart';
import 'package:blog_post_flutter/app/constant/enum_image_type.dart';
import 'package:blog_post_flutter/app/core/config/size_config.dart';
import 'package:blog_post_flutter/app/data/network/services/dio_provider.dart';
import 'package:blog_post_flutter/app/widget/cached_network_image_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ShowImageWidget extends StatelessWidget {
  final String imagePath;
  final fit;
  final double? width;
  final double? height;
  final ImageType imageType;
  final File? imageFile;
  final double? fileImageBorderRadius;

  const ShowImageWidget(
      {Key? key,
      required this.imagePath,
      this.imageFile,
      this.width = 100,
      this.height = 100,
      this.fit = BoxFit.cover,
      this.imageType = ImageType.networkImage, this.fileImageBorderRadius = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (imageType) {
      case ImageType.networkImage:
        return SizedBox(
          width: width,
          height: height,
          child: CachedNetworkImage(
            imageUrl: imagePath,
            width: width,
            height: height,
            fit: fit,
            placeholder: (context, url) => const CupertinoActivityIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        );
        break;
      case ImageType.localImage:
        return Image.asset(
          imagePath,
          fit: fit,
          width: width,
          height: height,
        );
        break;
      case ImageType.fileImage:
        return ClipRRect(
              borderRadius: BorderRadius.circular(fileImageBorderRadius!),
          child: Image.file(
            imageFile!,
            width: width,
            height: height,
            fit: fit,
          ),
        );
      default:
        return Image.asset(
          "images/akoneya_logo.jpg",
          fit: fit,
          width: width,
          height: height,
        );
    }
  }
}

class ShowRoundedImageWidget extends StatelessWidget {
  final String imagePath;
  final fit = BoxFit.cover;
  final bool? isLocalImage;
  final double? width;
  final double? height;
  final double cornerRadius;

  const ShowRoundedImageWidget(
      {Key? key,
      required this.imagePath,
      this.isLocalImage = false,
      this.width = 100,
      this.height = 100,
      this.cornerRadius = 20})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(cornerRadius),
      child: isLocalImage!
          ? Image.asset(imagePath, fit: fit)
          : CachedNetworkImageWidget(
              imageUrl: DioProvider.baseUrl + imagePath,
              height: height,
              width: width,
            ),
    );
  }
}

class ShowRoundedSvgImageWidget extends StatelessWidget {
  final String icon;

  const ShowRoundedSvgImageWidget({Key? key, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: SizeConfig.screenWidth! * 0.125,
        height: SizeConfig.screenWidth! * 0.12,
        padding: EdgeInsets.all(AppDimens.MARGIN_MEDIUM),
        decoration: BoxDecoration(
            color: AppColors.spaceBlueColor,
            borderRadius: BorderRadius.circular(SizeConfig.margin10dp!)),
        child: SvgPicture.asset(
          icon,
          width: SizeConfig.margin12dp!,
          height: SizeConfig.margin16dp!,
        ));
  }
}

void goImageDetail(BuildContext context, url) {
  List<String> imageList = [];
  imageList.add(url);
  // pushNewScreen(
  //   context,
  //   screen: ImagePreviewWidget(
  //     imageList: imageList,
  //     currentIndex: 0,
  //     isNetworkImage: true,
  //   ),
  //   withNavBar: false, // OPTIONAL VALUE. True by default.
  // );
}
