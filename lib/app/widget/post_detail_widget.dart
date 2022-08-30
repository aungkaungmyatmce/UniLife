import 'package:blog_post_flutter/app/constant/app_colors.dart';
import 'package:blog_post_flutter/app/constant/routing/app_routes.dart';
import 'package:blog_post_flutter/app/core/utils/global_key_utils.dart';
import 'package:blog_post_flutter/app/data/model/post/post_ob.dart';
import 'package:blog_post_flutter/app/features/home/controller/post_detail_controller.dart';
import 'package:blog_post_flutter/app/widget/text_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../core/utils/dialog_utils.dart';
import 'cached_network_image_widget.dart';

class PostDetailWidget extends StatelessWidget {
  const PostDetailWidget({
    Key? key,
    required this.postData,
    required this.onTapLike,
    required this.onTapCmt,
    required this.controller,
  }) : super(key: key);

  final PostData postData;
  final Function onTapLike;
  final Function onTapCmt;
  final PostDetailController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: double.infinity,
      // width: double.infinity,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          SingleChildScrollView(
            controller: controller.buttonController,
            physics: const ClampingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: TextViewWidget(
                    postData.title!,
                    textSize: 18,
                    fontWeight: FontWeight.w700,
                    textAlign: TextAlign.justify,
                    textColor: AppColors.primaryTextColor,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      postData.owner?.profilePicture != null
                          ? InkWell(
                              onTap: () => Get.toNamed(Paths.OTHER_PROFILE,
                                  arguments: postData.owner?.id),
                              child: CircleAvatar(
                                backgroundColor: AppColors.primaryColor,
                                radius: 25,
                                backgroundImage: NetworkImage(
                                  postData.owner?.profilePicture,
                                ),
                              ),
                            )
                          : const CircleAvatar(
                              radius: 25,
                              backgroundColor: AppColors.primaryColor,
                              child: Icon(
                                Icons.person,
                                color: AppColors.whiteColor,
                              ),
                            ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextViewWidget(
                                  '${postData.owner?.firstName!} ${postData.owner?.lastName!}',
                                  textSize: 15,
                                  fontWeight: FontWeight.w600,
                                  textColor: AppColors.primaryTextColor,
                                  textAlign: TextAlign.justify,
                                ),
                                TextViewWidget(
                                  DateFormat.yMMMd().format(
                                      DateTime.parse(postData.createdDate!)),
                                  textColor: AppColors.primaryTextColor
                                      .withOpacity(0.6),
                                  textSize: 15,
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            TextViewWidget(
                              postData.owner!.university!,
                              textSize: 15,
                              fontWeight: FontWeight.w400,
                              textColor: AppColors.primaryTextColor,
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                if (postData.image != null)
                  InkWell(
                    onTap: () => DialogUtils.showPreviewImageDialog(
                      context,
                      postData.image,
                    ),
                    child: CachedNetworkImageWidget(
                      imageUrl: postData.image,
                      width: double.infinity,
                      height: 200,
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextViewWidget(
                    postData.content!,
                    textSize: 16,
                    textColor: AppColors.primaryTextColor,
                    textAlign: TextAlign.justify,
                    textOverflow: TextOverflow.visible,
                    maxLine: null,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 10,
            child: GetX<PostDetailController>(
              builder: (c) => AnimatedSlide(
                duration: const Duration(milliseconds: 500),
                offset:
                    c.isVisible.value ? const Offset(0, 0) : const Offset(0, 5),
                curve: Curves.easeInOut,
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 40,
                    margin: const EdgeInsets.all(20),
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                        color: AppColors.primaryColor
                            .withOpacity(0.9), //const Color(0xff505050),
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Obx(
                          () => Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  // if (GlobalVariable.token == null ||
                                  //     GlobalVariable.token == "") {
                                  //   Get.offAllNamed(Paths.MAIN_HOME, arguments: 4);
                                  // } else {
                                  //   if (controller.isLikeAdded.value) {
                                  //     print("Remove");
                                  //     controller.removeLikeCount();
                                  //   } else {
                                  //     print("Added");
                                  //     controller.addLikeCount(
                                  //         controller.likeCount.value,
                                  //         controller.isLikeAdded.value);
                                  //   }
                                  // }
                                  controller.toggleLikePost();
                                },
                                child: Icon(
                                  controller.isLikeAdded.value
                                      ? Icons.thumb_up
                                      : Icons.thumb_up_alt_outlined,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 3),
                              Text(
                                "${controller.likeCount.value}",
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(width: 15),
                        InkWell(
                          onTap: () {
                            onTapCmt();
                          },
                          child: Row(
                            children: [
                              const Icon(
                                Icons.mode_comment_outlined,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 3),
                              Text(
                                NumberFormat.compact()
                                    .format(postData.commentCounts),
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
