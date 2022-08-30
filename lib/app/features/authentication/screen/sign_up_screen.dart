import 'dart:io';

import 'package:blog_post_flutter/app/constant/app_colors.dart';
import 'package:blog_post_flutter/app/constant/app_dimens.dart';
import 'package:blog_post_flutter/app/constant/enum_image_type.dart';
import 'package:blog_post_flutter/app/constant/routing/app_routes.dart';
import 'package:blog_post_flutter/app/core/base/base_view.dart';
import 'package:blog_post_flutter/app/core/utils/image_picker.dart';
import 'package:blog_post_flutter/app/features/authentication/controller/authentication_controller.dart';
import 'package:blog_post_flutter/app/widget/show_image_widget.dart';
import 'package:blog_post_flutter/app/widget/text_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends BaseView<AuthenticationController> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    // return AppBar(
    //   centerTitle: true,
    //   backgroundColor: AppColors.primaryColor,
    //   title: const TextViewWidget(
    //     'Sign Up',
    //     textSize: AppDimens.TEXT_HEADING_1X,
    //     textColor: Colors.black,
    //   ),
    // );
    return null;
  }

  @override
  Widget body(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Obx(() =>
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const SizedBox(
                  height: 10,
                ),
                const Center(
                  child: TextViewWidget(
                    'Sign Up',
                    textSize: AppDimens.TEXT_HEADING_1X,
                    textColor: AppColors.primaryColor,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Visibility(
                  visible: controller.base64ProfileImage.value == "",
                  child: Center(
                    child: GestureDetector(
                      onTap: () => ImagePickerHelper.pickMenuImage(
                          onImagePickCallBack: (File file) async {
                        controller.addProfileImage(file);
                      }),
                      child: Material(
                        elevation: 10,
                        borderRadius:
                            BorderRadius.all(const Radius.circular(60)),
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
                Visibility(
                  visible: controller.base64ProfileImage.value != "",
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
                                controller.chooseProfileImage.value.type!,
                            imageFile:
                                controller.chooseProfileImage.value.type ==
                                        ImageType.fileImage
                                    ? controller.chooseProfileImage.value.image!
                                    : null,
                            imagePath:
                                controller.chooseProfileImage.value.type ==
                                        ImageType.networkImage
                                    ? ""
                                    : "",
                            fileImageBorderRadius: 60,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 30),
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
                                labelText: 'Username',
                                suffixIcon: controller.userName.value.isNotEmpty
                                    ? const Icon(
                                        Icons.done,
                                        color: AppColors.primaryColor,
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
                                    color: AppColors.primaryColor,
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
                                    color: AppColors.primaryColor,
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
                            suffixIcon:
                                controller.universityName.value.isNotEmpty
                                    ? const Icon(
                                        Icons.done,
                                        color: AppColors.primaryColor,
                                      )
                                    : const SizedBox(),
                          ),
                          onChanged: (String value) {
                            controller.universityName.value = value;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: TextFormField(
                          controller: controller.passwordController.value,
                          obscureText: !controller.showPassword.value,
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
                            labelText: 'Password',
                            // enabledBorder: const UnderlineInputBorder(
                            //   borderSide: BorderSide(color: Color(0xffF6B90A)),
                            // ),
                            suffixIcon: IconButton(
                              onPressed: () => controller.showHidePassword(),
                              icon: Icon(
                                controller.showPassword.value
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: TextFormField(
                          controller:
                              controller.confirmPasswordController.value,
                          obscureText: !controller.showConfirmPassword.value,
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
                            labelText: 'Confirm Password',
                            // enabledBorder: const UnderlineInputBorder(
                            //   borderSide: BorderSide(color: Color(0xffF6B90A)),
                            // ),
                            suffixIcon: IconButton(
                              onPressed: () =>
                                  controller.showHideConfirmPassword(),
                              icon: Icon(
                                controller.showConfirmPassword.value
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ])),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: SizedBox(
                      width: 177,
                      height: 63,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color(0xffF2F2F2)),
                          alignment: Alignment.center,
                        ),
                        onPressed: () => controller.doRegister(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            TextViewWidget(
                              'Complete',
                              textColor: AppColors.primaryTextColor,
                              textSize: 18,
                            ),
                            Icon(
                              Icons.done,
                              size: 35,
                              color: AppColors.primaryTextColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: TextButton(
                      onPressed: () => Get.toNamed(Paths.LOGIN),
                      child: const TextViewWidget(
                        "Sign In",
                        textSize: 14,
                        textDecoration: TextDecoration.underline,
                        textColor: AppColors.primaryColor,
                      )),
                ),
                SizedBox(height: 30),
              ]))),
    );
  }
}
