import 'dart:io';

import 'package:blog_post_flutter/app/constant/app_colors.dart';
import 'package:blog_post_flutter/app/core/base/base_view.dart';
import 'package:blog_post_flutter/app/core/utils/image_picker.dart';
import 'package:blog_post_flutter/app/data/network/services/dio_provider.dart';
import 'package:blog_post_flutter/app/features/home/controller/post_create_controller.dart';
import 'package:blog_post_flutter/app/widget/text_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../main_home/controller/main_home_controller.dart';

class CreatePostScreen extends BaseView<CreatePostController> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return null;
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  MainHomeController homeController = Get.find<MainHomeController>();
  void validate() {
    final FormState? form = formKey.currentState;
    if (form!.validate()) {
      controller.uploadPost();
    }
  }

  @override
  Widget body(BuildContext context) {
    return Obx(
      () => WillPopScope(
        onWillPop: () async {
          //Get.offAllNamed(Paths.MAIN_HOME, arguments: 0);
          homeController.setSelectedIndex(0);

          return false;
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (controller.postId == null) SizedBox(),
                        if (controller.postId != null)
                          TextButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: const TextViewWidget(
                              'Cancel',
                              textColor: AppColors.primaryTextColor,
                            ),
                          ),
                        ElevatedButton(
                          onPressed: validate,
                          child: const TextViewWidget(
                            'Publish',
                            textColor: AppColors.secondaryTextColor,
                          ),
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18))),
                              backgroundColor: MaterialStateProperty.all(
                                  AppColors.primaryColor)),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: TextFormField(
                      controller: controller.titleController,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      style: const TextStyle(
                          fontSize: 20, color: AppColors.primaryTextColor),
                      decoration: InputDecoration(
                        hintText: 'Title :',
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: controller.loginResponse!.value.user!
                                      .profileImage !=
                                  null
                              ? CircleAvatar(
                                  backgroundColor: AppColors.primaryColor,
                                  radius: 20,
                                  backgroundImage: NetworkImage(
                                      "${DioProvider.serverUrl}${controller.loginResponse.value.user!.profileImage}"),
                                )
                              : const CircleAvatar(
                                  radius: 15,
                                  backgroundColor: AppColors.primaryColor,
                                  child: Icon(
                                    Icons.person,
                                    color: AppColors.whiteColor,
                                  ),
                                ),
                        ),
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {
                        controller.titleCount(value.length);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return '                  Title cannot be empty ';
                        }
                        if (value.length < 5) {
                          return 'Title must be at least 5 characters long';
                        }
                        return null;
                      },
                    ),
                  ),
                  (controller.postImage.value?.image != null)
                      ? controller.getPostImage()
                      : Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: OutlinedButton(
                            onPressed: () {
                              ImagePickerHelper.pickMenuImage(
                                  onImagePickCallBack: (File? file) {
                                controller.addPostImage(file!);
                              });
                            },
                            style: ButtonStyle(
                              padding:
                                  MaterialStateProperty.all(EdgeInsets.all(20)),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(15.0))),
                            ),
                            child: const Icon(
                              Icons.camera_alt_outlined,
                              size: 30,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: TextFormField(
                      controller: controller.descriptionController,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      style: const TextStyle(
                          fontSize: 16, color: AppColors.primaryTextColor),
                      decoration: const InputDecoration(
                        hintText: 'Share your stories.....',
                        border: InputBorder.none,
                        isDense: true, // Added this
                        contentPadding: EdgeInsets.all(10),
                      ),
                      onChanged: (value) {
                        controller.setDescriptionCount(value.length);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Your story cannot be empty ';
                        }
                        if (value.length < 20) {
                          return 'Your story must be at least 20 words long';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    // return Obx(() => Padding(
    //       padding:
    //           const EdgeInsets.symmetric(horizontal: AppDimens.MARGIN_MEDIUM_2),
    //       child: SingleChildScrollView(
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             SizedBox(
    //               height: AppDimens.MARGIN_MEDIUM_2,
    //             ),
    //             controller.postImage.value?.image != null
    //                 ? controller.getPostImage()
    //                 : InkWell(
    //                     onTap: () {
    //                       ImagePickerHelper.pickMenuImage(
    //                           onImagePickCallBack: (File? file) {
    //                         controller.addPostImage(file!);
    //                       });
    //                     },
    //                     child: Container(
    //                       width: double.infinity,
    //                       height: AppDimens.MARGIN_XXLARGE,
    //                       decoration: const BoxDecoration(
    //                         color: AppColors.inputBorderColor,
    //                         borderRadius: BorderRadius.all(
    //                           Radius.circular(
    //                             AppDimens.MARGIN_CARD_MEDIUM,
    //                           ),
    //                         ),
    //                       ),
    //                       child: DottedBorder(
    //                         borderType: BorderType.RRect,
    //                         radius:
    //                             const Radius.circular(AppDimens.MARGIN_MEDIUM),
    //                         padding:
    //                             const EdgeInsets.all(AppDimens.MARGIN_MEDIUM),
    //                         color: AppColors.primaryColor,
    //                         child: Center(
    //                           child: Row(
    //                             mainAxisAlignment: MainAxisAlignment.center,
    //                             children: [
    //                               Icon(
    //                                 Icons.add_circle,
    //                                 size: 18,
    //                                 color: AppColors.primaryColor,
    //                               ),
    //                               SizedBox(
    //                                 width: AppDimens.MARGIN_MEDIUM,
    //                               ),
    //                               Text(
    //                                 "Add Image",
    //                                 style: const TextStyle(
    //                                   fontSize: AppDimens.TEXT_HEADING,
    //                                   color: AppColors.primaryColor,
    //                                   fontWeight: FontWeight.w700,
    //                                 ),
    //                               )
    //                             ],
    //                           ),
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //             SizedBox(
    //               height: AppDimens.MARGIN_MEDIUM_2,
    //             ),
    //             TextViewWidget(
    //               "Title",
    //               textColor: AppColors.blackColor.withOpacity(0.5),
    //               fontWeight: FontWeight.w700,
    //             ),
    //             SizedBox(
    //               height: AppDimens.MARGIN_SMALL,
    //             ),
    //             InputFormFieldWidget(
    //               controller.titleController,
    //               hintText: "Enter Title",
    //               commonValidation: Validator.commonValidation,
    //               onTextChange: (value) {
    //                 controller.setTitleCount(value.length);
    //               },
    //               formBorderColor: controller.titleCount.value > 0
    //                   ? AppColors.spaceGrayColor
    //                   : AppColors.titleIndicatorColor,
    //             ),
    //             const SizedBox(
    //               height: AppDimens.MARGIN_MEDIUM_2,
    //             ),
    //             Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //               children: [
    //                 TextViewWidget(
    //                   "Description",
    //                   textColor: AppColors.blackColor.withOpacity(0.5),
    //                   fontWeight: FontWeight.w700,
    //                 ),
    //                 TextViewWidget(
    //                   "${controller.descriptionCount.value}/80",
    //                   textColor: AppColors.blackColor.withOpacity(0.5),
    //                   fontWeight: FontWeight.w700,
    //                 ),
    //               ],
    //             ),
    //             SizedBox(
    //               height: AppDimens.MARGIN_SMALL,
    //             ),
    //             InputFormFieldWidget(
    //               controller.descriptionController,
    //               hintText: "Enter Description",
    //               minLine: 4,
    //               maxLine: 100,
    //               onTextChange: (value) {
    //                 controller.setDescriptionCount(value.length);
    //               },
    //               textInputType: TextInputType.multiline,
    //               textInputAction: TextInputAction.newline,
    //               commonValidation: Validator.commonValidation,
    //               formBorderColor: controller.descriptionCount.value >= 80
    //                   ? AppColors.spaceGrayColor
    //                   : AppColors.titleIndicatorColor,
    //             ),
    //             SizedBox(
    //               height: AppDimens.MARGIN_MEDIUM_2,
    //             ),
    //             SecondaryButtonWidget(
    //               onPress: () => controller.uploadPost(),
    //               bgColor: AppColors.primaryColor,
    //               child: TextViewWidget(
    //                 "Create Post",
    //                 textColor: AppColors.whiteColor,
    //               ),
    //             ),
    //             SizedBox(
    //               height: AppDimens.MARGIN_LARGE,
    //             ),
    //           ],
    //         ),
    //       ),
    //     ));
  }
}
