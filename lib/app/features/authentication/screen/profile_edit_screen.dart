import 'dart:io';

import 'package:blog_post_flutter/app/core/base/base_view.dart';
import 'package:blog_post_flutter/app/features/authentication/controller/profile_edit_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/preferred_size.dart';
import 'package:get/get.dart';
import '../../../constant/app_colors.dart';
import '../../../constant/app_dimens.dart';
import '../../../constant/enum_image_type.dart';
import '../../../constant/routing/app_routes.dart';
import '../../../core/utils/image_picker.dart';
import '../../../widget/show_image_widget.dart';
import '../../../widget/text_view_widget.dart';

class ProfileEditScreen extends BaseView<ProfileEditController> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: AppColors.primaryColor,
      title: const TextViewWidget(
        'Update Your Profile',
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
    return SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Obx(() =>
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(
                height: 20,
              ),
              Visibility(
                visible: controller.chooseProfileImage.value == null,
                child: Center(
                  child: GestureDetector(
                    onTap: () => ImagePickerHelper.pickMenuImage(
                        onImagePickCallBack: (File file) async {
                      controller.addProfileImage(file);
                    }),
                    child: Material(
                      elevation: 10,
                      borderRadius: BorderRadius.all(const Radius.circular(60)),
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(60)),
                        child: const Icon(
                          Icons.camera_alt_outlined,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              if (controller.chooseProfileImage.value != null)
                Visibility(
                  visible: controller.chooseProfileImage.value != null,
                  child: Center(
                    child: GestureDetector(
                      onTap: () => ImagePickerHelper.pickMenuImage(
                          onImagePickCallBack: (File file) async {
                        controller.addProfileImage(file);
                      }),
                      child: Material(
                        elevation: 10,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(60)),
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(60)),
                          child: ShowImageWidget(
                            width: double.infinity,
                            height: 120,
                            imageType:
                                controller.chooseProfileImage.value!.type!,
                            imageFile: controller
                                        .chooseProfileImage.value!.type ==
                                    ImageType.fileImage
                                ? controller.chooseProfileImage.value!.image!
                                : null,
                            imagePath:
                                controller.chooseProfileImage.value!.type ==
                                        ImageType.networkImage
                                    ? controller.chooseProfileImage.value!.image
                                    : "",
                            fileImageBorderRadius: 60,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                  child: Column(children: [
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: TextFormField(
                          controller: controller.userNameController.value,
                          decoration: InputDecoration(
                              enabledBorder: const UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColors.primaryColor),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColors.primaryColor),
                              ),
                              labelStyle: const TextStyle(
                                  color: AppColors.primaryTextColor),
                              enabled: false,
                              labelText: 'Username',
                              suffixIcon: controller.userName.value.isNotEmpty
                                  ? const Icon(
                                      Icons.done,
                                      color: Color(0xff4135F3),
                                    )
                                  : const SizedBox()),
                          onChanged: (String value) {
                            controller.userName.value = value;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please Enter UserName";
                            }
                            return null;
                          },
                        )),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: TextFormField(
                        controller: controller.firstNameController.value,
                        decoration: InputDecoration(
                          enabledBorder: const UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.primaryColor),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.primaryColor),
                          ),
                          labelStyle: const TextStyle(
                              color: AppColors.primaryTextColor),
                          labelText: 'First Name',
                          suffixIcon: controller.firstName.value.isNotEmpty
                              ? const Icon(
                                  Icons.done,
                                  color: Color(0xff4135F3),
                                )
                              : const SizedBox(),
                        ),
                        onChanged: (String value) {
                          controller.firstName.value = value;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: TextFormField(
                        controller: controller.lastNameController.value,
                        decoration: InputDecoration(
                          enabledBorder: const UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.primaryColor),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.primaryColor),
                          ),
                          labelStyle: const TextStyle(
                              color: AppColors.primaryTextColor),
                          labelText: 'Last Name',
                          suffixIcon: controller.lastName.value.isNotEmpty
                              ? const Icon(
                                  Icons.done,
                                  color: Color(0xff4135F3),
                                )
                              : const SizedBox(),
                        ),
                        onChanged: (String value) {
                          controller.lastName.value = value;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: TextFormField(
                        controller: controller.universityController.value,
                        decoration: InputDecoration(
                          enabledBorder: const UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.primaryColor),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.primaryColor),
                          ),
                          labelStyle: const TextStyle(
                              color: AppColors.primaryTextColor),
                          labelText: 'University Name',
                          suffixIcon: controller.universityName.value.isNotEmpty
                              ? const Icon(
                                  Icons.done,
                                  color: Color(0xff4135F3),
                                )
                              : const SizedBox(),
                        ),
                        onChanged: (String value) {
                          controller.universityName.value = value;
                        },
                      ),
                    ),
                  ])),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: SizedBox(
                    width: 150,
                    height: 63,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xffF2F2F2)),
                        alignment: Alignment.center,
                      ),
                      onPressed: () => controller.doUpdateProfile(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            'Update',
                            style: TextStyle(
                                color: AppColors.primaryColor, fontSize: 18),
                          ),
                          Icon(
                            Icons.done,
                            size: 35,
                            color: AppColors.primaryColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ])));
  }
}
