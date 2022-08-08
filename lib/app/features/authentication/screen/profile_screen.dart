import 'package:blog_post_flutter/app/constant/app_colors.dart';
import 'package:blog_post_flutter/app/constant/app_dimens.dart';
import 'package:blog_post_flutter/app/core/base/base_view.dart';
import 'package:blog_post_flutter/app/core/utils/dialog_utils.dart';
import 'package:blog_post_flutter/app/data/model/authentication/profile_ob.dart';
import 'package:blog_post_flutter/app/features/authentication/controller/authentication_controller.dart';
import 'package:blog_post_flutter/app/widget/post_item_widget.dart';
import 'package:blog_post_flutter/app/widget/text_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends BaseView<AuthenticationController> {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: AppColors.primaryColor,
      title: const TextViewWidget(
        'Profile',
        textSize: AppDimens.TEXT_REGULAR_2X,
        textColor: AppColors.whiteColor,
      ),
      actions: [
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
                  backgroundColor: AppColors.primaryColor);
            },
            icon: const Icon(Icons.logout))
      ],
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
                ),
                const SizedBox(height: 2),
                Container(
                  color: const Color(0xffF2F2F2),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'My Stories',
                        style: TextStyle(
                            fontSize: 20,
                            height: 1.3,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w700),
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
        : const Center(
            child: CircularProgressIndicator(
              color: AppColors.primaryColor,
            ),
          ));
  }
}

class ProfileContainer extends StatelessWidget {
  const ProfileContainer({Key? key, required this.profileOb}) : super(key: key);

  final ProfileOb profileOb;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffF2F2F2),
      child: ListTile(
        contentPadding: const EdgeInsets.all(10),
        leading: profileOb.profilePicture != null
            ? CircleAvatar(
                radius: 30,
                backgroundColor: Colors.white,
                backgroundImage: NetworkImage(
                  profileOb.profilePicture,
                ),
              )
            : null,
        title: Text(
          "${profileOb.firstName} ${profileOb.lastName}",
          style: const TextStyle(
              fontSize: 16,
              height: 1.3,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400),
        ),
        subtitle: Text(
          profileOb.university ?? "",
          style: const TextStyle(
              color: Color(0xff41872C),
              fontSize: 16,
              height: 1.3,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
