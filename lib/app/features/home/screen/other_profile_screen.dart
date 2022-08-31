import 'package:blog_post_flutter/app/constant/app_colors.dart';
import 'package:blog_post_flutter/app/constant/app_dimens.dart';
import 'package:blog_post_flutter/app/constant/routing/app_routes.dart';
import 'package:blog_post_flutter/app/core/base/base_view.dart';
import 'package:blog_post_flutter/app/core/utils/shimmer_utils.dart';
import 'package:blog_post_flutter/app/data/model/authentication/profile_ob.dart';
import 'package:blog_post_flutter/app/features/home/controller/other_profile_controller.dart';
import 'package:blog_post_flutter/app/widget/post_item_widget.dart';
import 'package:blog_post_flutter/app/widget/text_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widget/profile_container.dart';

class OtherProfileScreen extends BaseView<OtherProfileController> {
  OtherProfileScreen({Key? key}) : super(key: key);

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: AppColors.primaryColor,
      title: const TextViewWidget(
        'Profile',
        textSize: AppDimens.TEXT_HEADING_1X,
        textColor: AppColors.secondaryTextColor,
      ),
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios,
          color: AppColors.secondaryTextColor,
        ),
        onPressed: () {
          Get.back();
        },
      ),
    );
  }

  @override
  Widget body(BuildContext context) {
    return Obx(() => controller.profileDetail.value.id != null
        ? SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              children: [
                ProfileContainer(
                  profileOb: controller.profileDetail.value,
                  onTapFollowers: () => controller.onTapFollow(0),
                  onTapFollow: () => controller.onTapFollow(1),
                  followButton: controller.notLogin.value
                      ? Container()
                      : ElevatedButton(
                          onPressed: controller.toggleFollow,
                          child: TextViewWidget(
                            controller.isFollow.value ? 'Unfollow' : 'Follow',
                            fontWeight: FontWeight.w500,
                            textColor: AppColors.secondaryTextColor,
                            textSize: 14,
                          ),
                          style: ElevatedButton.styleFrom(
                              primary: AppColors.primaryColor,
                              fixedSize: const Size(100, 30),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                ),
                const SizedBox(height: 3),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: TextViewWidget(
                          'Stories',
                          textSize: 18,
                          textAlign: TextAlign.center,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Divider(thickness: 1, color: Colors.black),
                      controller.profileDetail.value.posts!.isNotEmpty
                          ? ListView.builder(
                              primary: false,
                              shrinkWrap: true,
                              itemCount:
                                  controller.profileDetail.value.posts!.length,
                              itemBuilder: (context, index) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 4),
                                  child: Column(
                                    children: [
                                      PostItemWidget(
                                        postData: controller
                                            .profileDetail.value.posts![index],
                                        onTapSeeMore: () => Get.toNamed(
                                            Paths.POST_DETAIL,
                                            arguments: controller.profileDetail
                                                .value.posts![index]),
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
          )
        : ShimmerUtils.profile);
  }
}
