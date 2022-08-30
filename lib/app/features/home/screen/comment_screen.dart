import 'package:blog_post_flutter/app/features/home/controller/comment_controller.dart';
import 'package:blog_post_flutter/app/widget/text_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/preferred_size.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../constant/app_colors.dart';
import '../../../constant/app_dimens.dart';
import '../../../core/base/base_view.dart';
import '../../../widget/parent_view_smart_refresher.dart';
import '../controller/post_detail_controller.dart';
import 'package:blog_post_flutter/app/core/utils/date_utils.dart';
import 'package:flutter/services.dart';

class CommentScreen extends BaseView<CommentController> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      elevation: 1,
      title: TextViewWidget(
        'Comments',
        textColor: AppColors.primaryTextColor,
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
              color: AppColors.primaryTextColor,
            )),
      ],
    );
  }

  @override
  Widget body(BuildContext context) {
    return Obx(
      () => Container(
        //padding: EdgeInsets.all(10),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SmartRefresherParentView(
                  refreshController: _refreshController,
                  enablePullUp: true,
                  onRefresh: () => controller.resetAndGetCommentList(
                      refreshController: _refreshController),
                  onLoading: () => controller.getCommentList(
                      refreshController: _refreshController),
                  child: ListView.separated(
                    padding: const EdgeInsets.only(top: 10),
                    separatorBuilder: (context, index) => SizedBox(height: 25),
                    itemCount: controller.commentList.length,
                    itemBuilder: (context, index) => Column(
                      children: [
                        Row(
                          children: [
                            controller.commentList[index].owner!
                                        .profilePicture !=
                                    null
                                ? CircleAvatar(
                                    radius: 15,
                                    backgroundImage: NetworkImage(
                                      controller.commentList[index].owner!
                                          .profilePicture,
                                    ),
                                  )
                                : const CircleAvatar(
                                    radius: 15,
                                    backgroundColor: AppColors.primaryColor,
                                    child: Icon(
                                      Icons.person,
                                      color: AppColors.whiteColor,
                                    ),
                                  ),
                            const SizedBox(width: 10),
                            TextViewWidget(
                              '${controller.commentList[index].owner!.firstName} ${controller.commentList[index].owner!.lastName}',
                              textSize: 14,
                              fontWeight: FontWeight.w600,
                              textColor: AppColors.primaryTextColor,
                              textAlign: TextAlign.justify,
                            ),
                            const SizedBox(width: 10),
                            TextViewWidget(
                              controller.commentList[index].createdDate != null
                                  ? DateUtil.convertTimeAgoFromTimestamp(
                                      controller
                                          .commentList[index].createdDate!)
                                  : 'Posting...',
                              textSize: 12,
                              fontWeight: FontWeight.w600,
                              textColor: Colors.grey.shade500,
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        InkWell(
                          onLongPress: () {
                            controller
                                .showBottomSheet(controller.commentList[index]);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 40, right: 5),
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.grey.shade200),
                              child: TextViewWidget(
                                controller.commentList[index].comment!,
                                textAlign: TextAlign.justify,
                                maxLine: null,
                                textColor: AppColors.primaryTextColor,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            if (controller.isLogin.value == true)
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: TextField(
                  controller: controller.commentController,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.primaryColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: AppColors.primaryColor.withOpacity(0.9),
                          width: 2),
                    ),
                    hintText: 'Type your comment here',
                    suffixIcon: IconButton(
                      onPressed: controller.commentString.value != ''
                          ? () {
                              FocusManager.instance.primaryFocus?.unfocus();
                              controller.createComment();
                            }
                          : null,
                      icon: Icon(
                        Icons.send,
                        color: controller.commentString.value != ''
                            ? AppColors.primaryColor
                            : Colors.grey,
                      ),
                    ),
                  ),
                  onChanged: (value) {
                    controller.commentString.value = value;
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
