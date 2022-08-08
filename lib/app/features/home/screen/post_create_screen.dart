import 'dart:io';

import 'package:blog_post_flutter/app/constant/app_colors.dart';
import 'package:blog_post_flutter/app/constant/app_dimens.dart';
import 'package:blog_post_flutter/app/core/base/base_view.dart';
import 'package:blog_post_flutter/app/core/utils/image_picker.dart';
import 'package:blog_post_flutter/app/core/utils/validator.dart';
import 'package:blog_post_flutter/app/features/home/controller/post_create_controller.dart';
import 'package:blog_post_flutter/app/widget/input_form_field_widget.dart';
import 'package:blog_post_flutter/app/widget/secondary_button_widget.dart';
import 'package:blog_post_flutter/app/widget/text_view_widget.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreatePostScreen extends BaseView<CreatePostController> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return null;
  }

  @override
  Widget body(BuildContext context) {
    return Obx(
      () => SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        'Publish',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18))),
                          backgroundColor:
                              MaterialStateProperty.all(Color(0xff818181))),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: TextFormField(
                  controller: controller.titleController,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    hintText: 'Title :',
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(
                          'https://picsum.photos/200',
                        ),
                      ),
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
              controller.postImage.value?.image != null
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
                                  borderRadius: BorderRadius.circular(15.0))),
                        ),
                        child: const Icon(
                          Icons.camera_alt_outlined,
                          size: 30,
                          color: Colors.black54,
                        ),
                      ),
                    ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: TextFormField(
                  controller: controller.descriptionController,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  style: const TextStyle(fontSize: 16),
                  decoration: const InputDecoration(
                    hintText: 'Share your stories.....',
                    border: InputBorder.none,
                    isDense: true, // Added this
                    contentPadding: EdgeInsets.all(10),
                  ),
                ),
              ),
            ],
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
