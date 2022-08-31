import 'package:blog_post_flutter/app/constant/app_colors.dart';
import 'package:blog_post_flutter/app/constant/app_dimens.dart';
import 'package:blog_post_flutter/app/constant/routing/app_routes.dart';
import 'package:blog_post_flutter/app/core/base/base_view.dart';
import 'package:blog_post_flutter/app/core/utils/dialog_utils.dart';
import 'package:blog_post_flutter/app/core/utils/global_key_utils.dart';
import 'package:blog_post_flutter/app/core/utils/shimmer_utils.dart';
import 'package:blog_post_flutter/app/features/home/controller/post_detail_controller.dart';
import 'package:blog_post_flutter/app/features/main_home/controller/main_home_controller.dart';
import 'package:blog_post_flutter/app/widget/post_detail_widget.dart';
import 'package:blog_post_flutter/app/widget/text_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../data/local/cache_manager.dart';
import '../../../data/repository/post/post_repository.dart';

class PostDetailScreen extends BaseView<PostDetailController> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    // return AppBar(
    //   centerTitle: true,
    //   backgroundColor: AppColors.primaryColor,
    //   leading: IconButton(
    //     icon: const Icon(
    //       Icons.arrow_back_ios,
    //       color: AppColors.primaryTextColor,
    //     ),
    //     onPressed: () {
    //       Get.back();
    //     },
    //   ),
    //   actions: [
    //     Obx(() => Row(
    //           children: [
    //             GestureDetector(
    //               onTap: () {
    //                 controller.toggleSavePost();
    //                 // if (GlobalVariable.token == null ||
    //                 //     GlobalVariable.token == "") {
    //                 //   Get.offAllNamed(Paths.MAIN_HOME, arguments: 4);
    //                 // } else {
    //                 //   if (controller.isSaved.value) {
    //                 //     print("Removed Save");
    //                 //     controller.isSaved.value = false;
    //                 //   } else {
    //                 //     print("Added Save");
    //                 //     controller.isSaved.value = true;
    //                 //   }
    //                 // }
    //               },
    //               // GlobalVariable.token == null || GlobalVariable.token == ""
    //               //     ? Get.offAllNamed(Paths.MAIN_HOME, arguments: 4)
    //               //     : controller.toggleSavePost(),
    //               child: Padding(
    //                 padding: const EdgeInsets.symmetric(horizontal: 16),
    //                 child: Icon(
    //                   Icons.bookmark,
    //                   color: controller.isSaved.value == true
    //                       ? AppColors.secondaryColor
    //                       : Colors.grey,
    //                   size: 28,
    //                 ),
    //               ),
    //             ),
    //             if (controller.postDetail.value.isOwner == true)
    //               GestureDetector(
    //                 onTap: () {
    //                   DialogUtils.showOptionDialog(editButtonOnClick: () {
    //                     controller.editPost();
    //                   }, deleteButtonOnclick: () {
    //                     controller.confirmDelete();
    //                   });
    //                 },
    //                 child: const Padding(
    //                   padding: EdgeInsets.symmetric(horizontal: 8),
    //                   child: Icon(
    //                     Icons.more_vert,
    //                     color: Colors.grey,
    //                     size: 28,
    //                   ),
    //                 ),
    //               ),
    //           ],
    //         ))
    //   ],
    // );
    return null;
  }

  @override
  Widget body(BuildContext context) {
    return SafeArea(
      child: Obx(() => controller.postDetail.value.id != null
          ? Container(
              width: double.infinity,
              height: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: AppColors.primaryColor,
                        ),
                        onPressed: () {
                          // Get.deleteAll();
                          // Get.put(CacheManager());
                          // Get.put(GetMaterialController());

                          Get.offAllNamed(
                            Paths.MAIN_HOME,
                            arguments: 0,
                          );
                          //Get.back();
                        },
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              controller.toggleSavePost();
                              // if (GlobalVariable.token == null ||
                              //     GlobalVariable.token == "") {
                              //   Get.offAllNamed(Paths.MAIN_HOME, arguments: 4);
                              // } else {
                              //   if (controller.isSaved.value) {
                              //     print("Removed Save");
                              //     controller.isSaved.value = false;
                              //   } else {
                              //     print("Added Save");
                              //     controller.isSaved.value = true;
                              //   }
                              // }
                            },
                            // GlobalVariable.token == null || GlobalVariable.token == ""
                            //     ? Get.offAllNamed(Paths.MAIN_HOME, arguments: 4)
                            //     : controller.toggleSavePost(),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Icon(
                                Icons.bookmark,
                                color: controller.isSaved.value == true
                                    ? AppColors.primaryColor
                                    : AppColors.primaryColor.withOpacity(
                                        0.5), //Colors.grey.shade500,
                                size: 28,
                              ),
                            ),
                          ),
                          if (controller.postDetail.value.isOwner == true)
                            GestureDetector(
                              onTap: () {
                                DialogUtils.showOptionDialog(
                                    editButtonOnClick: () {
                                  controller.editPost();
                                }, deleteButtonOnclick: () {
                                  controller.confirmDelete();
                                });
                              },
                              child: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                child: Icon(
                                  Icons.more_vert,
                                  color: AppColors.primaryColor,
                                  size: 28,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                  Expanded(
                    child: PostDetailWidget(
                      postData: controller.postDetail.value,
                      onTapLike: () {},
                      onTapCmt: () => controller.onCmtTap(),
                      controller: controller,
                    ),
                  ),
                ],
              ),
            )
          : Container()),
    );

    // Obx(() => controller.postDetail.value.id != null
    //   ? SafeArea(
    //       minimum: const EdgeInsets.symmetric(horizontal: 16),
    //       child: Padding(
    //         padding: const EdgeInsets.only(top: 16),
    //         child: ListView(
    //           physics: const ClampingScrollPhysics(),
    //           children: [
    //             Row(
    //               children: [
    //                 Text(
    //                   controller.postDetail.value.title!,
    //                   style: const TextStyle(
    //                     color: Colors.black,
    //                     fontSize: AppDimens.TEXT_REGULAR_2,
    //                   ),
    //                 ),
    //                 const Spacer(),
    //                 controller.postDetail.value.isOwner == true
    //                     ? InkWell(
    //                         onTap: () => Get.toNamed(Paths.POST_EDIT,
    //                             arguments: controller.postDetail.value),
    //                         child: const Icon(
    //                           Icons.edit,
    //                           color: AppColors.primaryColor,
    //                         ),
    //                       )
    //                     : SizedBox(),
    //                 const SizedBox(
    //                   width: 8,
    //                 ),
    //                 controller.postDetail.value.isOwner == true
    //                     ? Icon(
    //                         Icons.delete,
    //                         color: Colors.red,
    //                       )
    //                     : SizedBox(),
    //               ],
    //             ),
    //             const SizedBox(
    //               height: 16,
    //             ),
    //             Wrap(
    //               alignment: WrapAlignment.start,
    //               crossAxisAlignment: WrapCrossAlignment.center,
    //               children: [
    //                 RoundedCornerImageWidget(
    //                   "https://static.bangkokpost.com/media/content/20211028/c1_2205267_211028062917.jpg",
    //                   width: 50,
    //                   height: 50,
    //                   cornerRadius: 25,
    //                 ),
    //                 const SizedBox(
    //                   width: 8,
    //                 ),
    //                 Text(
    //                     '${controller.postDetail.value.postedBy!.username!}, '),
    //                 controller.postDetail.value.createdDate != null
    //                     ? Text(
    //                         DateUtil.convertDateFormat(
    //                             controller.postDetail.value.createdDate!,
    //                             DAY_MONTH_YEAR_2),
    //                         style: TextStyle(color: Colors.grey),
    //                       )
    //                     : SizedBox(),
    //               ],
    //             ),
    //             const SizedBox(
    //               height: 16,
    //             ),
    //             Wrap(
    //               alignment: WrapAlignment.start,
    //               crossAxisAlignment: WrapCrossAlignment.center,
    //               spacing: 16,
    //               children: [
    //                 Wrap(
    //                   crossAxisAlignment: WrapCrossAlignment.center,
    //                   spacing: 4,
    //                   children: [
    //                     Obx(
    //                       () => GestureDetector(
    //                         onTap: () => controller.toggleLikePost(),
    //                         child: Icon(
    //                           controller.postDetail.value.isLiked!
    //                               ? Icons.favorite
    //                               : Icons.favorite_border,
    //                           color: controller.postDetail.value.isLiked!
    //                               ? Colors.red
    //                               : Colors.grey,
    //                           size: 18,
    //                         ),
    //                       ),
    //                     ),
    //                     Text(
    //                       '${controller.postDetail.value.likeCounts} ${controller.postDetail.value.likeCounts! > 1 ? "Likes" : "Like"}',
    //                       style: TextStyle(
    //                         color: Colors.grey,
    //                         fontSize: 14,
    //                         fontWeight: FontWeight.w100,
    //                       ),
    //                     )
    //                   ],
    //                 ),
    //               ],
    //             ),
    //             controller.postDetail.value.image != null
    //                 ? const SizedBox(
    //                     height: 16,
    //                   )
    //                 : SizedBox(),
    //             controller.postDetail.value.image != null
    //                 ? RoundedCornerImageWidget(
    //                     controller.postDetail.value.image!,
    //                     width: double.infinity,
    //                     height: 250,
    //                     cornerRadius: 10,
    //                   )
    //                 : SizedBox(),
    //             const SizedBox(
    //               height: 16,
    //             ),
    //             RichText(
    //               text: TextSpan(
    //                 children: [
    //                   TextSpan(
    //                       text: controller.postDetail.value.content![0],
    //                       style: GoogleFonts.notoSerif(
    //                           color: Colors.black, fontSize: 32)),
    //                   TextSpan(
    //                     text:
    //                         ' ${controller.postDetail.value.content!.substring(1)}',
    //                     style: GoogleFonts.notoSerif(
    //                       color: Colors.black,
    //                       fontSize: 18,
    //                       height: 1.7,
    //                       wordSpacing: 2,
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //     )
    //   : Padding(
    //       padding: const EdgeInsets.all(16),
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           const SkeletonWidget(
    //             width: 80,
    //             height: 25,
    //           ),
    //           const SizedBox(
    //             height: 16,
    //           ),
    //           Wrap(
    //             alignment: WrapAlignment.start,
    //             crossAxisAlignment: WrapCrossAlignment.center,
    //             children: [
    //               const SkeletonWidget(
    //                 width: 50,
    //                 height: 50,
    //                 borderRadius: 25,
    //               ),
    //               const SizedBox(
    //                 width: 8,
    //               ),
    //               SkeletonWidget(
    //                 width: 80,
    //               ),
    //               const SizedBox(
    //                 width: 2,
    //               ),
    //               SkeletonWidget(
    //                 width: 80,
    //               ),
    //             ],
    //           ),
    //           const SizedBox(
    //             height: 16,
    //           ),
    //           Wrap(
    //             alignment: WrapAlignment.start,
    //             crossAxisAlignment: WrapCrossAlignment.center,
    //             spacing: 16,
    //             children: [
    //               Wrap(
    //                 crossAxisAlignment: WrapCrossAlignment.center,
    //                 spacing: 4,
    //                 children: const [
    //                   SkeletonWidget(
    //                     width: 30,
    //                   ),
    //                   SkeletonWidget(
    //                     width: 30,
    //                   ),
    //                 ],
    //               ),
    //             ],
    //           ),
    //           const SizedBox(
    //             height: 16,
    //           ),
    //           const SkeletonWidget(
    //             width: double.infinity,
    //             height: 250,
    //           ),
    //           const SizedBox(
    //             height: 16,
    //           ),
    //           Expanded(
    //             child: const SkeletonWidget(
    //               width: double.infinity,
    //             ),
    //           ),
    //         ],
    //       ),
    //     ));
  }
}
