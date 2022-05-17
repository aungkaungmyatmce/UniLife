import 'package:blog_post_flutter/app/constant/app_colors.dart';
import 'package:blog_post_flutter/app/constant/app_dimens.dart';
import 'package:blog_post_flutter/app/core/base/base_view.dart';
import 'package:blog_post_flutter/app/core/utils/date_utils.dart';
import 'package:blog_post_flutter/app/features/home/controller/post_detail_controller.dart';
import 'package:blog_post_flutter/app/widget/rounded_corner_image_widget.dart';
import 'package:blog_post_flutter/app/widget/text_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostDetailScreen extends BaseView<PostDetailController> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: const Text('Post Detail'),
    );
  }

  @override
  Widget body(BuildContext context) {
    return Obx(() => controller.postDetail.value.id != null
        ? Padding(
            padding: const EdgeInsets.all(AppDimens.MARGIN_CARD_MEDIUM),
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      RoundedCornerImageWidget(
                        "https://static.bangkokpost.com/media/content/20211028/c1_2205267_211028062917.jpg",
                        width: 50,
                        height: 50,
                        cornerRadius: 25,
                      ),
                      SizedBox(
                        width: AppDimens.MARGIN_CARD_MEDIUM,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextViewWidget(
                            controller.postDetail.value.postedBy!.username ??
                                "",
                            textSize: AppDimens.TEXT_REGULAR_2X,
                            textColor: AppColors.titleTextColor,
                            fontWeight: FontWeight.w400,
                          ),
                          SizedBox(
                            height: AppDimens.MARGIN_SMALL,
                          ),
                          TextViewWidget(
                            "Post Created :  ${controller.postDetail.value.createdDate != null ? DateUtil.convertDateFormat(controller.postDetail.value.createdDate!, DAY_MONTH_YEAR_2) : ""}",
                            textSize: AppDimens.TEXT_REGULAR,
                            textColor: AppColors.secondaryTextColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: AppDimens.MARGIN_MEDIUM_3,
                  ),
                  TextViewWidget(
                    controller.postDetail.value.title ?? "",
                    textSize: AppDimens.TEXT_REGULAR_2X,
                    textColor: AppColors.titleTextColor,
                    fontWeight: FontWeight.w700,
                  ),
                  SizedBox(
                    height: AppDimens.MARGIN_MEDIUM_2X,
                  ),
                  RoundedCornerImageWidget(
                    controller.postDetail.value.image!,
                    width: double.infinity,
                    height: 250,
                    cornerRadius: 10,
                  ),
                  SizedBox(
                    height: AppDimens.MARGIN_CARD_MEDIUM,
                  ),
                  TextViewWidget(
                    controller.postDetail.value.content ?? "",
                    textSize: AppDimens.TEXT_REGULAR_2X,
                    textColor: AppColors.secondaryTextColor,
                    fontWeight: FontWeight.w400,
                    textAlign: TextAlign.justify,
                    maxLine: 100,
                  ),
                ],
              ),
            ),
          )
        : const Center(child: CircularProgressIndicator()));
  }
}
