import 'package:blog_post_flutter/app/constant/app_colors.dart';
import 'package:blog_post_flutter/app/constant/app_dimens.dart';
import 'package:blog_post_flutter/app/constant/routing/app_routes.dart';
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
      title: const TextViewWidget(
        'Home',
        textSize: AppDimens.TEXT_REGULAR_2X,
        textColor: AppColors.whiteColor,
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(7),
          child: InkWell(
            onTap: () => Get.toNamed(Paths.PROFILE),
            child: const CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://static.bangkokpost.com/media/content/20211028/c1_2205267_211028062917.jpg'),
            ),
          ),
        ),
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
                      return PostItemWidget(
                        post: controller.postList[index],
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
            onRefresh: () => null,
            onLoading: () => null,
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
}
