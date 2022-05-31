import 'package:blog_post_flutter/app/constant/app_dimens.dart';
import 'package:blog_post_flutter/app/core/base/base_view.dart';
import 'package:blog_post_flutter/app/features/favourite/controller/favourite_controller.dart';
import 'package:blog_post_flutter/app/widget/parent_view_smart_refresher.dart';
import 'package:blog_post_flutter/app/widget/post_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavouriteScreen extends BaseView<FavouriteController> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: const Text('Favourite'),
    );
  }

  @override
  Widget body(BuildContext context) {
    return Obx(
      () => controller.savePostList.isNotEmpty
          ? SmartRefresherParentView(
              refreshController: controller.refreshController,
              enablePullUp: true,
              onRefresh: () => controller.resetAndGetSavePostList(
                  refreshController: controller.refreshController),
              onLoading: () => controller.getSavePostList(
                  refreshController: controller.refreshController),
              child: CustomScrollView(
                physics: const ClampingScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: AppDimens.MARGIN_MEDIUM,
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return PostItemWidget(
                          post: controller.savePostList[index],
                        );
                      },
                      childCount: controller.savePostList.length,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: AppDimens.MARGIN_MEDIUM_2,
                    ),
                  ),
                ],
              ),
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
