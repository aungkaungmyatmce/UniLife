import 'dart:io';

import 'package:blog_post_flutter/app/constant/app_colors.dart';
import 'package:blog_post_flutter/app/constant/app_dimens.dart';
import 'package:blog_post_flutter/app/constant/enum_image_type.dart';
import 'package:blog_post_flutter/app/widget/rounded_icon_widget.dart';
import 'package:blog_post_flutter/app/widget/show_image_widget.dart';
import 'package:flutter/material.dart';

class PostFileImageWidget extends StatelessWidget {
  final String? imagePath;
  final ImageType imageType;
  final File? file;
  final Function onDeleteCallBack;
  final bool showRemoveIcon;
  final double width;
  final double height;

  const PostFileImageWidget(
      {Key? key,
      this.file,
      required this.onDeleteCallBack,
      this.imagePath,
      this.showRemoveIcon = true,
      this.width = 80,
      this.height = 80,
      required this.imageType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(AppDimens.MARGIN_SMALL),
          decoration: BoxDecoration(
            borderRadius:
                const BorderRadius.all(Radius.circular(AppDimens.MARGIN_SMALL)),
            border: Border.all(
              color: AppColors.grayWishColor,
              width: 1,
            ),
          ),
          child: ShowImageWidget(
            width: width,
            height: height,
            imageType: imageType,
            imageFile: file,
            imagePath: imagePath ?? "",
          ),
        ),
        showRemoveIcon
            ? Positioned(
                top: 0,
                right: 0,
                child: RoundedIconWidget(
                  backgroundColor: AppColors.textColor,
                  icon: const Icon(
                    Icons.close,
                    size: 16,
                    color: AppColors.whiteColor,
                  ),
                  onClickIcon: onDeleteCallBack,
                  contentPadding: 4,
                ))
            : const SizedBox()
      ],
    );
  }
}
