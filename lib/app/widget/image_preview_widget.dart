import 'package:blog_post_flutter/app/constant/app_colors.dart';
import 'package:blog_post_flutter/app/constant/app_dimens.dart';
import 'package:blog_post_flutter/app/data/network/services/dio_provider.dart';
import 'package:blog_post_flutter/app/widget/cached_network_image_widget.dart';
import 'package:blog_post_flutter/app/widget/loading_circle_indicator_widget.dart';
import 'package:blog_post_flutter/app/widget/rounded_icon_widget.dart';
import 'package:blog_post_flutter/app/widget/text_view_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ImagePreviewWidget extends StatefulWidget {
  final dynamic previewImages;
  final int currentIndex;

  const ImagePreviewWidget({
    required this.previewImages,
    this.currentIndex = 0,
    Key? key,
  }) : super(key: key);

  @override
  _ImagePreviewWidgetState createState() => _ImagePreviewWidgetState();
}

class _ImagePreviewWidgetState extends State<ImagePreviewWidget> {
  List<String> imageList = [];
  int currentIndex = 0;

  @override
  void initState() {
    currentIndex = widget.currentIndex;
    if (widget.previewImages is String) {
      imageList.add(widget.previewImages);
    } else {
      imageList = [...widget.previewImages];
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PhotoViewGallery.builder(
            scrollPhysics: const BouncingScrollPhysics(),
            builder: (BuildContext context, int index) {
              return PhotoViewGalleryPageOptions.customChild(
                child: CachedNetworkImageWidget(
                  imageUrl: imageList[index].toString(),
                  boxFit: BoxFit.contain,
                ),
                initialScale: PhotoViewComputedScale.contained,
              );
            },
            itemCount: imageList.length,
            loadingBuilder: (context, event) =>
                const LoadingCircleIndicatorWidget(
              iconColor: AppColors.secondaryColor,
            ),
            pageController: PageController(
              initialPage: currentIndex,
            ),
            onPageChanged: onImagePageChange,
            backgroundDecoration: const BoxDecoration(
              color: AppColors.lightBlueColor,
            ),
          ),
          Visibility(
            visible: imageList.length != 1,
            child: Positioned(
              top: AppDimens.MARGIN_XLARGE,
              left: AppDimens.MARGIN_SMALL,
              child: Padding(
                padding: const EdgeInsets.all(AppDimens.MARGIN_MEDIUM),
                child: TextViewWidget(
                  "${currentIndex + 1} / ${imageList.length}",
                  textColor: AppColors.titleTextColor,
                ),
              ),
            ),
          ),
          Positioned(
            top: AppDimens.MARGIN_MEDIUM,
            right: AppDimens.MARGIN_MEDIUM,
            child: RoundedIconWidget(
              onClickIcon: () => Get.back(),
              backgroundColor: AppColors.primaryColor,
              contentPadding: 8,
              icon: const Icon(
                Icons.close,
                color: AppColors.whiteColor,
                size: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void onImagePageChange(int index) {
    setState(
      () {
        currentIndex = index;
      },
    );
  }
}
