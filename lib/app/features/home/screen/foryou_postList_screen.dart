import 'package:blog_post_flutter/app/core/base/base_view.dart';
import 'package:blog_post_flutter/app/features/home/controller/foryou_postList_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/preferred_size.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../constant/app_dimens.dart';
import '../../../widget/parent_view_smart_refresher.dart';
import '../../../widget/post_item_widget.dart';

class ForYouPostListScreen extends BaseView<ForYouPostListController> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return null;
  }

  @override
  Widget body(BuildContext context) {
    return Obx(() => SmartRefresherParentView(
          refreshController: _refreshController,
          enablePullUp: true,
          onRefresh: () => controller.resetAndGetPostList(
              refreshController: _refreshController, isFollowing: false),
          onLoading: () => controller.getPostList(
              refreshController: _refreshController, isFollowing: false),
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
                              onTapSeeMore: () =>
                                  controller.navigateToDetailScreen(
                                      controller.postList[index]!),
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
        ));
  }
}
