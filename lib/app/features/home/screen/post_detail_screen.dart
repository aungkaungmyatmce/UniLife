import 'package:blog_post_flutter/app/constant/app_colors.dart';
import 'package:blog_post_flutter/app/constant/app_dimens.dart';
import 'package:blog_post_flutter/app/constant/routing/app_routes.dart';
import 'package:blog_post_flutter/app/core/base/base_view.dart';
import 'package:blog_post_flutter/app/core/utils/global_key_utils.dart';
import 'package:blog_post_flutter/app/features/home/controller/post_detail_controller.dart';
import 'package:blog_post_flutter/app/widget/text_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/dialog_utils.dart';
import '../../../widget/post_detail_widget.dart';

class PostDetailScreen extends BaseView<PostDetailController> {
  void showCmtSheet() {
    Get.bottomSheet(
      Container(
        //padding: EdgeInsets.all(10),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              elevation: 1,
              title: Text(
                'Comments',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(
                      Icons.close,
                      color: Colors.black,
                    )),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ListView.separated(
                  padding: EdgeInsets.only(top: 10),
                  separatorBuilder: (context, index) => SizedBox(height: 25),
                  itemCount: 5,
                  itemBuilder: (context, index) => Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 15,
                            backgroundImage: NetworkImage(
                              'https://picsum.photos/200/300',
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Aung Kaung Myat',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            '14 min ago',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade500,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.only(left: 40, right: 5),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.grey.shade200),
                          child: Text(
                            'I am wondering, if anyone knows of a way to remove the back button that shows up on the appBar in a flutter app when you use',
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: TextField(
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Type your comment here',
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.send,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      isScrollControlled: true,
      ignoreSafeArea: false,
    );
  }

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: AppColors.primaryColor,
      title: const TextViewWidget(
        'Post Detail',
        textSize: AppDimens.TEXT_REGULAR_2X,
        textColor: AppColors.whiteColor,
      ),
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios,
        ),
        onPressed: () {
          if (controller.postDetail.value.likeCounts !=
              controller.likeCount.value) {
            controller.toggleLikePost();
          }
          if (controller.postDetail.value.isSaved != controller.isSaved.value) {
            controller.toggleSavePost();
          }
          Get.back();
        },
      ),
      actions: [
        Obx(() => Row(
              children: [
                GestureDetector(
                  onTap: () {
                    if (GlobalVariable.token == null ||
                        GlobalVariable.token == "") {
                      Get.offAllNamed(Paths.MAIN_HOME, arguments: 4);
                    } else {
                      if (controller.isSaved.value) {
                        print("Removed Save");
                        controller.isSaved.value = false;
                      } else {
                        print("Added Save");
                        controller.isSaved.value = true;
                      }
                    }
                  },
                  // GlobalVariable.token == null || GlobalVariable.token == ""
                  //     ? Get.offAllNamed(Paths.MAIN_HOME, arguments: 4)
                  //     : controller.toggleSavePost(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Icon(
                      Icons.bookmark,
                      color: controller.isSaved.value == true
                          ? Colors.grey
                          : Colors.white,
                      size: 28,
                    ),
                  ),
                ),
                if (controller.postDetail.value.isOwner == true)
                  GestureDetector(
                    onTap: () {
                      DialogUtils.showOptionDialog(editButtonOnClick: () {
                        controller.editPost();
                      }, deleteButtonOnclick: () {
                        controller.confirmDelete();
                      });
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Icon(
                        Icons.more_vert,
                        color: Colors.grey,
                        size: 28,
                      ),
                    ),
                  ),
              ],
            ))
      ],
    );
  }

  @override
  Widget body(BuildContext context) {
    return Obx(() => controller.postDetail.value.id != null
        ? PostDetailWidget(
            profileId: controller.postDetail.value.owner!.id!,
            statusTitle: controller.postDetail.value.title!,
            profilePhotoUrl: controller.postDetail.value.owner?.profilePicture,
            accName: controller.postDetail.value.owner!.firstName! +
                " " +
                controller.postDetail.value.owner!.lastName!,
            date: DateTime.now(),
            statusBody: controller.postDetail.value.content!,
            likeCount: controller.postDetail.value.likeCounts!,
            cmtCount: controller.postDetail.value.commentCounts!,
            isLiked: controller.postDetail.value.isLiked!,
            isSaved: controller.postDetail.value.isSaved!,
            onTapLike: () {},
            onTapCmt: () {
              controller.onCmtTap();
            },
            university: controller.postDetail.value.owner!.university!,
            statusTitlePhotoUrl: controller.postDetail.value.image,
            statusBodyPhotoUrl: null,
            controller: controller,
          )
        : const Center(
            child: CircularProgressIndicator(
              color: AppColors.primaryColor,
            ),
          ));

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
