import 'package:blog_post_flutter/app/constant/routing/app_routes.dart';
import 'package:blog_post_flutter/app/core/base/base_view.dart';
import 'package:blog_post_flutter/app/features/follow/controller/follow_controller.dart';
import 'package:blog_post_flutter/app/features/home/controller/other_profile_controller.dart';
import 'package:blog_post_flutter/app/widget/text_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constant/app_colors.dart';
import '../../../data/repository/comment/comment_repository.dart';
import '../../../data/repository/comment/comment_repository_impl.dart';

class FollowScreen extends BaseView<FollowController> {
  PreferredSizeWidget? appBar(BuildContext context) {
    // TODO: implement appBar

    return AppBar(
      backgroundColor: AppColors.primaryColor,
      title: TextViewWidget(
        '${controller.myProfile.value.firstName.toString()} ${controller.myProfile.value.lastName.toString()}',
        fontWeight: FontWeight.bold,
        textColor: AppColors.secondaryTextColor,
        textSize: 16,
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
      bottom: TabBar(
        controller: controller.tab.controller,
        indicatorColor: AppColors.secondaryTextColor,
        labelColor: AppColors.secondaryTextColor,
        tabs: const [
          Tab(text: "Followers"),
          Tab(text: "Following"),
        ],
      ),
    );
  }

  @override
  Widget body(BuildContext context) {
    return Obx(
      () => Container(
        padding: const EdgeInsets.only(left: 20),
        height: 300,
        width: double.maxFinite,
        child: TabBarView(
          controller: controller.tab.controller,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child: ListView.separated(
                separatorBuilder: (context, index) => SizedBox(height: 10),
                itemCount: controller.followers.length,
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    Get.back();
                    Get.back();
                    Get.delete<OtherProfileController>();
                    Get.toNamed(Paths.OTHER_PROFILE,
                        arguments: controller.followers[index].id!);
                  },
                  child: Row(
                    children: [
                      controller.followers[index].profilePicture != null
                          ? CircleAvatar(
                              radius: 20,
                              backgroundImage: NetworkImage(
                                controller.followers[index].profilePicture,
                              ),
                            )
                          : const CircleAvatar(
                              radius: 20,
                              backgroundColor: AppColors.primaryColor,
                              child: Icon(
                                Icons.person,
                                color: AppColors.whiteColor,
                              ),
                            ),
                      SizedBox(width: 30),
                      TextViewWidget(
                        '${controller.followers[index].firstName} ${controller.followers[index].lastName}',
                        fontWeight: FontWeight.w500,
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: ListView.separated(
                separatorBuilder: (context, index) => SizedBox(height: 10),
                itemCount: controller.following.length,
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    Get.back();
                    Get.back();
                    Get.delete<OtherProfileController>();
                    Get.toNamed(Paths.OTHER_PROFILE,
                        arguments: controller.following[index].id!);
                  },
                  child: Row(
                    children: [
                      controller.following[index].profilePicture != null
                          ? CircleAvatar(
                              radius: 20,
                              backgroundImage: NetworkImage(
                                controller.following[index].profilePicture,
                              ),
                            )
                          : const CircleAvatar(
                              radius: 20,
                              backgroundColor: AppColors.primaryColor,
                              child: Icon(
                                Icons.person,
                                color: AppColors.whiteColor,
                              ),
                            ),
                      const SizedBox(width: 30),
                      TextViewWidget(
                        '${controller.following[index].firstName} ${controller.following[index].lastName}',
                        fontWeight: FontWeight.w500,
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
