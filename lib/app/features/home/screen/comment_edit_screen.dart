import 'package:blog_post_flutter/app/constant/app_colors.dart';
import 'package:blog_post_flutter/app/core/base/base_view.dart';
import 'package:blog_post_flutter/app/features/home/controller/comment_edit_controller.dart';
import 'package:blog_post_flutter/app/widget/text_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/preferred_size.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class CommentEditScreen extends BaseView<CommentEditController> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: AppColors.primaryColor,
      elevation: 1,
      title: TextViewWidget(
        'Edit',
        textColor: AppColors.secondaryTextColor,
        fontWeight: FontWeight.w500,
        textSize: 16,
      ),
      actions: [
        IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.close,
              color: AppColors.secondaryTextColor,
            )),
      ],
    );
  }

  @override
  Widget body(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                children: [
                  //const SizedBox(width: 5),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextField(
                        controller: controller.commentEditController,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.primaryColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColors.primaryColor.withOpacity(0.9),
                                width: 2),
                          ),
                        ),
                        onChanged: (value) {
                          //controller.commentString.value = value;
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Spacer(),
                  ElevatedButton(
                    onPressed: controller.onTapCancel,
                    child: const Text('Cancel'),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.grey,
                        textStyle: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(width: 40),
                  ElevatedButton(
                    onPressed: controller.onTapUpdate,
                    child: const Text('Update'),
                    style: ElevatedButton.styleFrom(
                        primary: AppColors.primaryColor,
                        textStyle: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(width: 20),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
