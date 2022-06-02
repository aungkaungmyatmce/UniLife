import 'dart:io';

import 'package:blog_post_flutter/app/constant/app_colors.dart';
import 'package:blog_post_flutter/app/constant/app_dimens.dart';
import 'package:blog_post_flutter/app/core/base/base_view.dart';
import 'package:blog_post_flutter/app/core/utils/image_picker.dart';
import 'package:blog_post_flutter/app/core/utils/validator.dart';
import 'package:blog_post_flutter/app/features/home/controller/post_edit_controller.dart';
import 'package:blog_post_flutter/app/widget/input_form_field_widget.dart';
import 'package:blog_post_flutter/app/widget/secondary_button_widget.dart';
import 'package:blog_post_flutter/app/widget/text_view_widget.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditPostScreen extends BaseView<EditPostController> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: TextViewWidget(
        'Edit Post',
        textSize: AppDimens.TEXT_REGULAR_2X,
        textColor: AppColors.whiteColor,
      ),
    );
  }

  @override
  Widget body(BuildContext context) {
    return Obx(() => Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: AppDimens.MARGIN_MEDIUM_2),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: AppDimens.MARGIN_MEDIUM_2,
                ),
                controller.postImage.value?.image != null
                    ? controller.getPostImage()
                    : InkWell(
                        onTap: () {
                          ImagePickerHelper.pickMenuImage(
                              onImagePickCallBack: (File? file) {
                            controller.addPostImage(file!);
                          });
                        },
                        child: Container(
                          width: double.infinity,
                          height: AppDimens.MARGIN_XXLARGE,
                          decoration: const BoxDecoration(
                            color: AppColors.inputBorderColor,
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                AppDimens.MARGIN_CARD_MEDIUM,
                              ),
                            ),
                          ),
                          child: DottedBorder(
                            borderType: BorderType.RRect,
                            radius:
                                const Radius.circular(AppDimens.MARGIN_MEDIUM),
                            padding:
                                const EdgeInsets.all(AppDimens.MARGIN_MEDIUM),
                            color: AppColors.primaryColor,
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add_circle,
                                    size: 18,
                                    color: AppColors.primaryColor,
                                  ),
                                  SizedBox(
                                    width: AppDimens.MARGIN_MEDIUM,
                                  ),
                                  Text(
                                    "Add Image",
                                    style: const TextStyle(
                                      fontSize: AppDimens.TEXT_HEADING,
                                      color: AppColors.primaryColor,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                SizedBox(
                  height: AppDimens.MARGIN_MEDIUM_2,
                ),
                TextViewWidget(
                  "Title",
                  textColor: AppColors.blackColor.withOpacity(0.5),
                  fontWeight: FontWeight.w700,
                ),
                SizedBox(
                  height: AppDimens.MARGIN_SMALL,
                ),
                InputFormFieldWidget(
                  controller.titleController,
                  hintText: "Enter Title",
                  commonValidation: Validator.commonValidation,
                  onTextChange: (value) {
                    controller.setTitleCount(value.length);
                  },
                  formBorderColor: controller.titleCount.value > 0
                      ? AppColors.spaceGrayColor
                      : AppColors.titleIndicatorColor,
                ),
                const SizedBox(
                  height: AppDimens.MARGIN_MEDIUM_2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextViewWidget(
                      "Description",
                      textColor: AppColors.blackColor.withOpacity(0.5),
                      fontWeight: FontWeight.w700,
                    ),
                    TextViewWidget(
                      "${controller.descriptionCount.value}/80",
                      textColor: AppColors.blackColor.withOpacity(0.5),
                      fontWeight: FontWeight.w700,
                    ),
                  ],
                ),
                SizedBox(
                  height: AppDimens.MARGIN_SMALL,
                ),
                InputFormFieldWidget(
                  controller.descriptionController,
                  hintText: "Enter Description",
                  minLine: 4,
                  maxLine: 100,
                  onTextChange: (value) {
                    controller.setDescriptionCount(value.length);
                  },
                  textInputType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                  commonValidation: Validator.commonValidation,
                  formBorderColor: controller.descriptionCount.value >= 80
                      ? AppColors.spaceGrayColor
                      : AppColors.titleIndicatorColor,
                ),
                SizedBox(
                  height: AppDimens.MARGIN_MEDIUM_2,
                ),
                SecondaryButtonWidget(
                  onPress: () => controller.updatePost(),
                  bgColor: AppColors.primaryColor,
                  child: TextViewWidget(
                    "Update Post",
                    textColor: AppColors.whiteColor,
                  ),
                ),
                SizedBox(
                  height: AppDimens.MARGIN_LARGE,
                ),
              ],
            ),
          ),
        ));
  }
}
