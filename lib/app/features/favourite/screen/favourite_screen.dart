import 'package:blog_post_flutter/app/constant/app_colors.dart';
import 'package:blog_post_flutter/app/constant/app_dimens.dart';
import 'package:blog_post_flutter/app/constant/routing/app_routes.dart';
import 'package:blog_post_flutter/app/core/base/base_view.dart';
import 'package:blog_post_flutter/app/core/utils/shimmer_utils.dart';
import 'package:blog_post_flutter/app/features/favourite/controller/favourite_controller.dart';
import 'package:blog_post_flutter/app/widget/parent_view_smart_refresher.dart';
import 'package:blog_post_flutter/app/widget/post_item_widget.dart';
import 'package:blog_post_flutter/app/widget/text_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class FavouriteScreen extends BaseView<FavouriteController> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  FavouriteScreen({Key? key}) : super(key: key);

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    // return AppBar(
    //   centerTitle: true,
    //   backgroundColor: AppColors.primaryColor,
    //   title: const TextViewWidget(
    //     'Bookmark',
    //     textSize: AppDimens.TEXT_HEADING_1X,
    //     textColor: AppColors.secondaryTextColor,
    //   ),
    // );
    return null;
  }

  @override
  Widget body(BuildContext context) {
    return Obx(() => SafeArea(
          child: Container(
            height: double.infinity,
            width: double.infinity,
            child: Column(
              children: [
                SizedBox(height: 5),
                TextViewWidget(
                  'Bookmark',
                  textSize: AppDimens.TEXT_HEADING_1X,
                  textColor: AppColors.primaryColor,
                ),
                Expanded(
                  child: SmartRefresherParentView(
                    refreshController: _refreshController,
                    enablePullUp: true,
                    onRefresh: () => controller.resetAndGetSavePostList(
                        refreshController: _refreshController),
                    onLoading: () => controller.getSavePostList(
                        refreshController: _refreshController),
                    child: CustomScrollView(
                      physics: const ClampingScrollPhysics(),
                      slivers: [
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 10),
                                  child: Column(
                                    children: [
                                      PostItemWidget(
                                          postData:
                                              controller.savePostList[index],
                                          onTapSeeMore: () => Get.toNamed(
                                                Paths.POST_DETAIL,
                                                arguments: controller
                                                    .savePostList[index],
                                              )),
                                      const Divider(
                                        color: Colors.black,
                                      )
                                    ],
                                  ));
                            },
                            childCount: controller.savePostList.length,
                          ),
                        ),
                        const SliverToBoxAdapter(
                          child: SizedBox(
                            height: AppDimens.MARGIN_MEDIUM_2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
