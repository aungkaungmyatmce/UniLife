import 'package:blog_post_flutter/app/constant/app_colors.dart';
import 'package:blog_post_flutter/app/constant/app_dimens.dart';
import 'package:blog_post_flutter/app/constant/string.dart';
import 'package:blog_post_flutter/app/core/config/size_config.dart';
import 'package:blog_post_flutter/app/widget/image_preview_widget.dart';
import 'package:blog_post_flutter/app/widget/input_form_field_widget.dart';
import 'package:blog_post_flutter/app/widget/rounded_icon_widget.dart';
import 'package:blog_post_flutter/app/widget/secondary_button_widget.dart';
import 'package:blog_post_flutter/app/widget/text_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/model/post/comment_ob.dart';

class DialogUtils {
  static final DialogUtils _instance = DialogUtils.internal();

  DialogUtils.internal();

  factory DialogUtils() => _instance;

  static void showOptionDialog({
    required Function editButtonOnClick,
    required Function deleteButtonOnclick,
  }) {
    Widget editText = SimpleDialogOption(
        child: const Text('Edit'), onPressed: () => editButtonOnClick());

    Widget deleteText = SimpleDialogOption(
        child: const Text('Delete'), onPressed: () => deleteButtonOnclick());

    SimpleDialog dialog = SimpleDialog(
      title: const Text('Choose Options'),
      children: <Widget>[
        editText,
        deleteText,
      ],
    );

    Get.dialog(
      dialog,
    );
  }

  static void requestInputDialog({
    required String title,
    required TextEditingController controller,
    String text = "Save",
    int maxLine = 1,
    String textReason = "",
    required Function saveFunction,
    bool barrierDismissible = true,
  }) {
    Get.dialog(
        Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppDimens.MARGIN_MEDIUM)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              DecoratedBox(
                decoration: const BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(AppDimens.MARGIN_MEDIUM),
                    topLeft: Radius.circular(AppDimens.MARGIN_MEDIUM),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(AppDimens.MARGIN_MEDIUM),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      TextViewWidget(
                        title,
                        textColor: AppColors.whiteColor,
                        textSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: RoundedIconWidget(
                            onClickIcon: () => Get.back(),
                            icon: const Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                            contentPadding: 2,
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: AppDimens.MARGIN_LARGE,
              ),
              textReason != ""
                  ? Padding(
                      padding: const EdgeInsets.only(
                          bottom: AppDimens.MARGIN_MEDIUM_2,
                          left: AppDimens.MARGIN_MEDIUM),
                      child: TextViewWidget(
                        textReason,
                        textColor: AppColors.primaryColor,
                        textSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    )
                  : const SizedBox(),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppDimens.MARGIN_CARD_MEDIUM),
                child: InputFormFieldWidget(
                  controller,
                  autoFocus: false,
                  maxLine: maxLine,
                  textInputType: TextInputType.number,
                ),
              ),
              const SizedBox(
                height: AppDimens.MARGIN_LARGE,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppDimens.MARGIN_CARD_MEDIUM),
                child: SecondaryButtonWidget(
                  bgColor: AppColors.primaryColor,
                  child: TextViewWidget(
                    text,
                    textColor: AppColors.whiteColor,
                  ),
                  onPress: () => saveFunction(),
                ),
              ),
              SizedBox(
                height: SizeConfig.margin10dp!,
              ),
            ],
          ),
        ),
        barrierDismissible: barrierDismissible);
  }

  static void showPromptDialog({
    String okBtnText = "Yes",
    String cancelBtnText = 'No',
    String content = "This is Content",
    Color backgroundColor = AppColors.whiteColor,
    required Function okBtnFunction,
  }) {
    Get.dialog(Dialog(
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(SizeConfig.margin10dp!)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Container(
          //   padding: EdgeInsets.symmetric(vertical: SizeConfig.margin8dp!),
          //   decoration: BoxDecoration(
          //     color: AppColors.primaryColor,
          //     borderRadius: BorderRadius.only(
          //         topLeft: Radius.circular(SizeConfig.margin10dp!),
          //         topRight: Radius.circular(SizeConfig.margin10dp!)),
          //   ),
          //   width: double.infinity,
          //   child: Center(
          //     child: TextViewWidget(
          //       title,
          //       textColor: Colors.white,
          //       textSize: 18.0,
          //       textOverflow: null,
          //     ),
          //   ),
          // ),
          Container(
            margin: EdgeInsets.symmetric(
                horizontal: AppDimens.MARGIN_MEDIUM_3,
                vertical: AppDimens.MARGIN_MEDIUM_3),
            alignment: Alignment.centerLeft,
            child: TextViewWidget(
              content,
              textColor: AppColors.blackColor,
              textSize: 16.0,
              fontWeight: FontWeight.w400,
              textOverflow: null,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  child: TextViewWidget(
                    cancelBtnText,
                    textColor: AppColors.blackColor,
                    textSize: 16.0,
                  ),
                  onPressed: () => Get.back()),
              TextButton(
                child: TextViewWidget(
                  okBtnText,
                  textColor: AppColors.blackColor,
                  textSize: 16.0,
                ),
                onPressed: () => okBtnFunction(),
              )
            ],
          ),
          SizedBox(
            height: SizeConfig.margin2dp!,
          )
        ],
      ),
    ));
  }

  static Future<dynamic> showPreviewImageDialog(
      BuildContext context, dynamic images) {
    return showDialog(
      context: context,
      builder: (contextInsideDialog) {
        return ImagePreviewWidget(
          previewImages: images,
        );
      },
    );
  }

  static Future<dynamic> showEditAndDeleteBottomSheet(
      {required CommentData cmtData,
      required Function onEdit,
      required Function onDelete}) {
    return Get.bottomSheet(
        Container(
          padding: EdgeInsets.all(20),
          height: 150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                  onPressed: () {
                    onEdit();
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.edit,
                        color: Colors.green,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Edit',
                        style: TextStyle(color: Colors.black),
                      )
                    ],
                  )),
              TextButton(
                  onPressed: () {
                    onDelete();
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Delete',
                        style: TextStyle(color: Colors.black),
                      )
                    ],
                  ))
            ],
          ),
        ),
        backgroundColor: Colors.white,
        isDismissible: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ));
  }
}
