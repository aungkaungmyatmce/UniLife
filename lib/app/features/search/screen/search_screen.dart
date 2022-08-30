import 'package:blog_post_flutter/app/core/base/base_view.dart';
import 'package:blog_post_flutter/app/features/search/controller/search_controller.dart';
import 'package:blog_post_flutter/app/widget/text_view_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/preferred_size.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';
import '../../../constant/app_colors.dart';
import '../../../constant/app_dimens.dart';
import '../../../widget/input_form_field_widget.dart';
import '../../../widget/parent_view_smart_refresher.dart';
import '../../../widget/post_item_widget.dart';

class SearchScreen extends BaseView<SearchController> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return null;
  }

  @override
  Widget body(BuildContext context) {
    return SafeArea(
      child: Obx(
        () => SizedBox(
          height: double.infinity,
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: AppColors.primaryTextColor,
                    ),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                  Expanded(
                    child: Padding(
                        padding: const EdgeInsets.only(
                          top: AppDimens.MARGIN_CARD_MEDIUM,
                          bottom: AppDimens.MARGIN_CARD_MEDIUM,
                          //left: AppDimens.MARGIN_CARD_MEDIUM,
                          right: AppDimens.MARGIN_CARD_MEDIUM,
                        ),
                        child: InputFormFieldWidget(
                          controller.searchTextEditingController.value,
                          hintText: "Search",
                          autoFocus: true,
                          onTextChange: () => controller.searchPostList(
                            refreshController: _refreshController,
                          ),
                          formBorderColor: AppColors.primaryColor,
                          formColor: AppColors.primaryColor,
                          cursorColor: Colors.white,
                        )),
                  ),
                ],
              ),
              Divider(thickness: 1, color: AppColors.primaryColor),
              controller.isSearching.value == false
                  ? controller.postList.isNotEmpty
                      ? Expanded(
                          child: SmartRefresherParentView(
                            refreshController: _refreshController,
                            enablePullUp: true,
                            onRefresh: () => controller.resetAndGetPostList(
                              refreshController: _refreshController,
                            ),
                            onLoading: () => controller.getPostList(
                              refreshController: _refreshController,
                            ),
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
                                                postData:
                                                    controller.postList[index],
                                                onTapSeeMore: () => controller
                                                    .navigateToDetailScreen(
                                                        controller
                                                            .postList[index]!),
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
                          ),
                        )
                      : const Expanded(
                          child: Center(
                            child: TextViewWidget(
                              'Search anything here...',
                              textSize: AppDimens.TEXT_REGULAR_2X,
                              textColor: Colors.grey,
                            ),
                          ),
                        )
                  : Expanded(
                      child: ListView.separated(
                        separatorBuilder: (context, index) => Divider(),
                        itemBuilder: (context, index) => Container(
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade100,
                            //enabled: _enabled,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10),
                                        height: 47.0,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  height: 150.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.white,
                                  ),
                                ),

                                ///Profile
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      CircleAvatar(
                                        radius: 25,
                                        child: Container(
                                          //width: double.infinity,
                                          height: 8.0,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 20),
                                          width: 200,
                                          height: 30.0,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        itemCount: 5,
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
