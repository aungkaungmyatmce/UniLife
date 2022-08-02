import 'package:blog_post_flutter/app/constant/app_colors.dart';
import 'package:blog_post_flutter/app/constant/app_dimens.dart';
import 'package:blog_post_flutter/app/core/base/base_view.dart';
import 'package:blog_post_flutter/app/features/home/controller/post_home_controller.dart';
import 'package:blog_post_flutter/app/widget/parent_view_smart_refresher.dart';
import 'package:blog_post_flutter/app/widget/post_item_skeleton_widget.dart';
import 'package:blog_post_flutter/app/widget/post_item_widget.dart';
import 'package:blog_post_flutter/app/widget/text_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostHomeScreen extends BaseView<PostHomeController> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: AppColors.primaryColor,
      title: const TextViewWidget(
        'UniLife',
        textSize: AppDimens.TEXT_HEADING_2X,
        textColor: Colors.black
      ),
      actions: [
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              size: 28,
              color: Colors.black,
            ))
      ],
    );
  }

  @override
  Widget body(BuildContext context) {
    return Obx(() => controller.postList.isNotEmpty
        ? SmartRefresherParentView(
            refreshController: controller.refreshController,
            enablePullUp: true,
            onRefresh: () => controller.resetAndGetPostList(
                refreshController: controller.refreshController),
            onLoading: () => controller.getPostList(
                refreshController: controller.refreshController),
            child: CustomScrollView(
              physics: const ClampingScrollPhysics(),
              slivers: [
                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: AppDimens.MARGIN_MEDIUM,
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 4),
                        child: Column(
                          children: [
                            PostItemWidget(
                              postData: controller.postList[index],
                            ),
                            Divider(color: Colors.black,)
                          ],
                        )
                      );
                    },
                    childCount: controller.postList.length,
                  ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: AppDimens.MARGIN_MEDIUM_2,
                  ),
                ),
              ],
            ),
          )
        : SmartRefresherParentView(
            refreshController: controller.refreshController,
            enablePullUp: true,
            onRefresh: () => controller.resetAndGetPostList(
                refreshController: controller.refreshController),
            onLoading: () => controller.getPostList(
                refreshController: controller.refreshController),
            child: CustomScrollView(
              physics: const ClampingScrollPhysics(),
              slivers: [
                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: AppDimens.MARGIN_MEDIUM,
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return PostItemSkeleton();
                    },
                    childCount: 15,
                  ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: AppDimens.MARGIN_MEDIUM_2,
                  ),
                ),
              ],
            ),
          ));
  }

// @override
// Widget showLoading() {
//   return CustomScrollView(
//     physics: const ClampingScrollPhysics(),
//     slivers: [
//       const SliverToBoxAdapter(
//         child: SizedBox(
//           height: AppDimens.MARGIN_MEDIUM,
//         ),
//       ),
//       SliverList(
//         delegate: SliverChildBuilderDelegate(
//           (BuildContext context, int index) {
//             return PostItemSkeleton();
//           },
//           childCount: 15,
//         ),
//       ),
//       const SliverToBoxAdapter(
//         child: SizedBox(
//           height: AppDimens.MARGIN_MEDIUM_2,
//         ),
//       ),
//     ],
//   );
// }
}
