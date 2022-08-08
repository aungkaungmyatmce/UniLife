import 'package:blog_post_flutter/app/constant/app_colors.dart';
import 'package:blog_post_flutter/app/widget/loading_circle_indicator_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CachedNetworkImageWidget extends StatefulWidget {
  final String? imageUrl;
  final double? width;
  final double? height;
  final BoxFit? boxFit;

  const CachedNetworkImageWidget({
    this.imageUrl,
    this.width,
    this.height,
    this.boxFit = BoxFit.cover,
    Key? key,
  }) : super(key: key);

  @override
  State<CachedNetworkImageWidget> createState() =>
      _CachedNetworkImageWidgetState();
}

class _CachedNetworkImageWidgetState extends State<CachedNetworkImageWidget> {
  double get getWidth =>
      (widget.width == null) ? Get.width * 0.2 : widget.width!;

  double get getHeight =>
      (widget.height == null) ? Get.width * 0.2 : widget.height!;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: widget.imageUrl ?? "",
      fit: widget.boxFit,
      width: getWidth,
      height: getHeight,
      placeholder: (context, url) => Container(
        color: AppColors.primaryColor,
        child: const LoadingCircleIndicatorWidget(
          sizeFactor: 0.1,
        ),
      ),
      errorWidget: (context, url, error) {
        print("Image Error**** $url");
        return LayoutBuilder(
          builder: ((context, constraints) => Container(
                color: AppColors.primaryColor,
                child: Center(
                  child: SvgPicture.asset(
                    'assets/images/akone_ya_logo.svg',
                    fit: BoxFit.scaleDown,
                    width: getWidth,
                  ),
                ),
              )),
        );
      },
    );
  }
}
