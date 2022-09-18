import 'package:blog_post_flutter/app/constant/app_colors.dart';
import 'package:blog_post_flutter/app/constant/app_dimens.dart';
import 'package:blog_post_flutter/app/constant/routing/app_routes.dart';
import 'package:blog_post_flutter/app/core/base/base_view.dart';
import 'package:blog_post_flutter/app/core/utils/dialog_utils.dart';
import 'package:blog_post_flutter/app/core/utils/shimmer_utils.dart';
import 'package:blog_post_flutter/app/data/model/authentication/profile_ob.dart';
import 'package:blog_post_flutter/app/features/authentication/controller/authentication_controller.dart';
import 'package:blog_post_flutter/app/widget/post_item_widget.dart';
import 'package:blog_post_flutter/app/widget/text_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widget/profile_container.dart';
import '../../main_home/controller/main_home_controller.dart';

class ProfileScreen extends BaseView<AuthenticationController> {
  ProfileScreen({Key? key}) : super(key: key);
  MainHomeController homeController = Get.find<MainHomeController>();
  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return null;
  }

  @override
  Widget body(BuildContext context) {
    return Obx(
      () => controller.profileDetail.value.id == null
          ? ShimmerUtils.profile
          : WillPopScope(
              onWillPop: () async {
                //Get.offAllNamed(Paths.MAIN_HOME, arguments: 0);
                homeController.setSelectedIndex(0);

                return false;
              },
              child: SafeArea(
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: TextViewWidget(
                              'Profile',
                              textSize: AppDimens.TEXT_HEADING_1X,
                              textColor: AppColors.primaryColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                              onPressed: () {
                                Get.toNamed(Paths.PROFILE_EDIT,
                                        arguments: controller.profileDetail)!
                                    .then((result) {
                                  if (result == 'updated') {
                                    controller.fetchProfile(
                                        controller.profileDetail.value.id!);
                                  }
                                });
                              },
                              icon: const Icon(
                                Icons.edit,
                                color: AppColors.primaryColor,
                              )),
                          IconButton(
                              onPressed: () {
                                DialogUtils.showPromptDialog(
                                    content: "Are you sure you want to Logout?",
                                    cancelBtnText: "Cancel",
                                    okBtnText: "Ok",
                                    okBtnFunction: () {
                                      Get.back();
                                      controller.doLogout();
                                    },
                                    backgroundColor:
                                        AppColors.secondaryTextColor);
                              },
                              icon: const Icon(
                                Icons.logout,
                                color: AppColors.primaryColor,
                              )),
                        ],
                      ),
                      Expanded(
                        child: RefreshIndicator(
                          onRefresh: () async => controller
                              .fetchProfile(controller.profileDetail.value.id),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                ProfileContainer(
                                  profileOb: controller.profileDetail.value,
                                  onTapFollowers: () =>
                                      controller.onTapFollow(0),
                                  onTapFollow: () => controller.onTapFollow(1),
                                ),
                                const SizedBox(height: 3),
                                Container(
                                  //color: const Color(0xffF2F2F2),
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Center(
                                        child: TextViewWidget(
                                          'My Stories',
                                          textSize: 18,
                                          textAlign: TextAlign.center,
                                          fontWeight: FontWeight.w600,
                                          textColor: AppColors.primaryTextColor,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      const Divider(
                                          thickness: 1, color: Colors.black),
                                      controller.profileDetail.value.posts!
                                              .isNotEmpty
                                          ? ListView.builder(
                                              primary: false,
                                              shrinkWrap: true,
                                              itemCount: controller
                                                  .profileDetail
                                                  .value
                                                  .posts!
                                                  .length,
                                              itemBuilder: (context, index) =>
                                                  Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 12,
                                                          vertical: 4),
                                                      child: Column(
                                                        children: [
                                                          PostItemWidget(
                                                            postData: controller
                                                                .profileDetail
                                                                .value
                                                                .posts![index],
                                                            onTapSeeMore: () => Get.toNamed(
                                                                Paths
                                                                    .POST_DETAIL,
                                                                arguments: controller
                                                                    .profileDetail
                                                                    .value
                                                                    .posts![index]),
                                                          ),
                                                          const Divider(
                                                            color: Colors.black,
                                                          )
                                                        ],
                                                      )))
                                          : const SizedBox()
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

// @override
// Widget body(BuildContext context) {
//   return Obx(() => SingleChildScrollView(
//         physics: const ClampingScrollPhysics(),
//         child: Column(
//           children: [
//             ProfileContainer(
//               profileOb: controller.profileDetail.value,
//               onTapFollowers: () => controller.onTapFollow(0),
//               onTapFollow: () => controller.onTapFollow(1),
//             ),
//             const SizedBox(height: 3),
//             Container(
//               color: const Color(0xffF2F2F2),
//               padding: const EdgeInsets.all(10),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Center(
//                     child: TextViewWidget(
//                       'My Stories',
//                       textSize: 18,
//                       textAlign: TextAlign.center,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   const SizedBox(height: 5),
//                   const Divider(thickness: 1, color: Colors.black),
//                   controller.profileDetail.value.posts!.isNotEmpty
//                       ? ListView.builder(
//                           primary: false,
//                           shrinkWrap: true,
//                           itemCount:
//                               controller.profileDetail.value.posts!.length,
//                           itemBuilder: (context, index) => Padding(
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 12, vertical: 4),
//                               child: Column(
//                                 children: [
//                                   PostItemWidget(
//                                     postData: controller
//                                         .profileDetail.value.posts![index],
//                                     onTapSeeMore: () => Get.toNamed(
//                                         Paths.POST_DETAIL,
//                                         arguments: controller.profileDetail
//                                             .value.posts![index]),
//                                   ),
//                                   const Divider(
//                                     color: Colors.black,
//                                   )
//                                 ],
//                               )))
//                       : const SizedBox()
//                 ],
//               ),
//             )
//           ],
//         ),
//       ));
// }
}
