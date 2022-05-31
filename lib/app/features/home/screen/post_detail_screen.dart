import 'package:blog_post_flutter/app/constant/app_dimens.dart';
import 'package:blog_post_flutter/app/core/base/base_view.dart';
import 'package:blog_post_flutter/app/core/utils/date_utils.dart';
import 'package:blog_post_flutter/app/features/home/controller/post_detail_controller.dart';
import 'package:blog_post_flutter/app/widget/rounded_corner_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PostDetailScreen extends BaseView<PostDetailController> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: const Text('Post Detail'),
      actions: [
        Obx(() => GestureDetector(
          onTap: () => controller.toggleSavePost(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Icon(
              Icons.bookmark,
              color: controller.postDetail.value.isSaved == true
                  ? Colors.grey
                  : Colors.white,
              size: 28,
            ),
          ),
        ))
      ],
    );
  }

  @override
  Widget body(BuildContext context) {
    return Obx(() => controller.postDetail.value.id != null
        ? SafeArea(
            minimum: const EdgeInsets.symmetric(horizontal: 16),
            child: Padding(
              padding: const EdgeInsets.only(top: 16),
              child: ListView(
                physics: const ClampingScrollPhysics(),
                children: [
                  Text(
                    controller.postDetail.value.title!,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: AppDimens.TEXT_REGULAR_2,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Wrap(
                    alignment: WrapAlignment.start,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      RoundedCornerImageWidget(
                        "https://static.bangkokpost.com/media/content/20211028/c1_2205267_211028062917.jpg",
                        width: 50,
                        height: 50,
                        cornerRadius: 25,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                          '${controller.postDetail.value.postedBy!.username!}, '),
                      controller.postDetail.value.createdDate != null
                          ? Text(
                              DateUtil.convertDateFormat(
                                  controller.postDetail.value.createdDate!,
                                  DAY_MONTH_YEAR_2),
                              style: TextStyle(color: Colors.grey),
                            )
                          : SizedBox(),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Wrap(
                    alignment: WrapAlignment.start,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 16,
                    children: [
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 4,
                        children: [
                          Obx(
                            () => GestureDetector(
                              onTap: () => controller.toggleLikePost(),
                              child: Icon(
                                controller.postDetail.value.isLiked!
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: controller.postDetail.value.isLiked!
                                    ? Colors.red
                                    : Colors.grey,
                                size: 18,
                              ),
                            ),
                          ),
                          Text(
                            '${controller.postDetail.value.likeCounts} ${controller.postDetail.value.likeCounts! > 1 ? "Likes" : "Like"}',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                              fontWeight: FontWeight.w100,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  controller.postDetail.value.image != null
                      ? const SizedBox(
                          height: 16,
                        )
                      : SizedBox(),
                  controller.postDetail.value.image != null
                      ? RoundedCornerImageWidget(
                          controller.postDetail.value.image!,
                          width: double.infinity,
                          height: 250,
                          cornerRadius: 10,
                        )
                      : SizedBox(),
                  const SizedBox(
                    height: 16,
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: controller.postDetail.value.content![0],
                            style: GoogleFonts.notoSerif(
                                color: Colors.black, fontSize: 32)),
                        TextSpan(
                          text:
                              ' ${controller.postDetail.value.content!.substring(1)}',
                          style: GoogleFonts.notoSerif(
                            color: Colors.black,
                            fontSize: 18,
                            height: 1.7,
                            wordSpacing: 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        : const Center(child: CircularProgressIndicator()));
  }
}
