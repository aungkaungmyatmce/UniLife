import 'package:blog_post_flutter/app/constant/app_colors.dart';
import 'package:blog_post_flutter/app/constant/app_dimens.dart';
import 'package:blog_post_flutter/app/core/base/base_view.dart';
import 'package:blog_post_flutter/app/features/home/controller/post_home_controller.dart';
import 'package:blog_post_flutter/app/widget/input_form_field_widget.dart';
import 'package:blog_post_flutter/app/widget/parent_view_smart_refresher.dart';
import 'package:blog_post_flutter/app/widget/post_item_widget.dart';
import 'package:blog_post_flutter/app/widget/text_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PostHomeScreen extends BaseView<PostHomeController> {
  PostHomeScreen({Key? key}) : super(key: key);

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: AppColors.primaryColor,
      title: const TextViewWidget('UniLife',
          textSize: AppDimens.TEXT_HEADING_2X, textColor: Colors.black),
      actions: [
        IconButton(
            onPressed: () => controller.toggleSearch(),
            icon: Obx(() => Icon(
                  !controller.isSearch.value ? Icons.search : Icons.close,
                  size: 28,
                  color: Colors.black,
                )))
      ],
    );
  }

  @override
  Widget body(BuildContext context) {
    return Obx(() => controller.postList.isNotEmpty
        ? Column(
            children: [
              Padding(
                  padding: const EdgeInsets.only(
                    top: AppDimens.MARGIN_MEDIUM_2,
                    bottom: AppDimens.MARGIN_MEDIUM,
                    left: AppDimens.MARGIN_MEDIUM_2,
                    right: AppDimens.MARGIN_MEDIUM_2,
                  ),
                  child: controller.isSearch.value
                      ? InputFormFieldWidget(
                          controller.searchTextEditingController.value,
                          hintText: "Search",
                          onTextChange: () => controller.searchPostList(
                              refreshController: _refreshController),
                          formBorderColor: AppColors.primaryColor,
                          formBorderWidth: 2,
                        )
                      : const SizedBox()),
              Expanded(
                  child: SmartRefresherParentView(
                refreshController: _refreshController,
                enablePullUp: true,
                onRefresh: () => controller.resetAndGetPostList(
                    refreshController: _refreshController),
                onLoading: () => controller.getPostList(
                    refreshController: _refreshController),
                child: CustomScrollView(
                  physics: const ClampingScrollPhysics(),
                  slivers: [
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 4),
                              child: Column(
                                children: [
                                  PostItemWidget(
                                    postData: controller.postList[index],
                                  ),
                                  const Divider(
                                    color: Colors.black,
                                  )
                                ],
                              ));
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
              ))
            ],
          )
        : const Center(
            child: CircularProgressIndicator(
              color: AppColors.primaryColor,
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
