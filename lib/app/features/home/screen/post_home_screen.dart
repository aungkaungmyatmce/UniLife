import 'package:blog_post_flutter/app/constant/app_colors.dart';
import 'package:blog_post_flutter/app/constant/app_dimens.dart';
import 'package:blog_post_flutter/app/constant/routing/app_routes.dart';
import 'package:blog_post_flutter/app/core/base/base_view.dart';
import 'package:blog_post_flutter/app/features/home/controller/post_home_controller.dart';
import 'package:blog_post_flutter/app/features/home/screen/foryou_postList_screen.dart';
import 'package:blog_post_flutter/app/widget/text_view_widget.dart';
import 'package:flutter/material.dart';
import 'following_postList_screen.dart';
import 'package:get/get.dart';

class PostHomeScreen extends StatefulWidget {
  const PostHomeScreen({Key? key}) : super(key: key);

  @override
  State<PostHomeScreen> createState() => _PostHomeScreenState();
}

class _PostHomeScreenState extends State<PostHomeScreen>
    with SingleTickerProviderStateMixin {
  TabController? _controller;
  @override
  void initState() {
    _controller = TabController(vsync: this, length: 2);
    _controller!.index = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   centerTitle: true,
        //   backgroundColor: AppColors.primaryColor,
        //   title: const TextViewWidget('UniLife',
        //       textSize: AppDimens.TEXT_HEADING_1X,
        //       textColor: AppColors.primaryTextColor),
        //   actions: [
        //     IconButton(
        //         onPressed: () => Get.toNamed(Paths.SEARCH),
        //         icon: Icon(
        //           Icons.search,
        //           size: 28,
        //           color: AppColors.primaryTextColor,
        //         ))
        //   ],
        // ),
        body: Column(
          children: [
            ///Search Form
            // if (controller.isSearch.value)
            //   Padding(
            //       padding: const EdgeInsets.only(
            //         top: AppDimens.MARGIN_MEDIUM_2,
            //         bottom: AppDimens.MARGIN_MEDIUM,
            //         left: AppDimens.MARGIN_MEDIUM_2,
            //         right: AppDimens.MARGIN_MEDIUM_2,
            //       ),
            //       child: controller.isSearch.value
            //           ? InputFormFieldWidget(
            //               controller.searchTextEditingController.value,
            //               hintText: "Search",
            //               onTextChange: () => controller.searchPostList(
            //                   refreshController: _refreshController,
            //                   isFollowing: false),
            //               formBorderColor: AppColors.primaryColor,
            //               formBorderWidth: 2,
            //             )
            //           : const SizedBox()),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const TextViewWidget('UniLife',
                      textSize: AppDimens.TEXT_HEADING_1X,
                      fontWeight: FontWeight.w700,
                      textColor: AppColors.primaryColor),
                  IconButton(
                      onPressed: () => Get.toNamed(Paths.SEARCH),
                      icon: const Icon(
                        Icons.search,
                        size: 28,
                        color: AppColors.primaryColor,
                      ))
                ],
              ),
            ),

            SizedBox(
              width: 220,
              height: 40,
              child: TabBar(
                controller: _controller,
                indicatorColor: AppColors.primaryTextColor,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorPadding: const EdgeInsets.symmetric(horizontal: 10),
                unselectedLabelColor:
                    AppColors.primaryTextColor.withOpacity(0.8),
                labelColor: AppColors.primaryTextColor,
                tabs: const [
                  Tab(
                      child: TextViewWidget(
                    'For you',
                    fontWeight: FontWeight.w500,
                  )),
                  Tab(
                      child: TextViewWidget(
                    'Following',
                    fontWeight: FontWeight.w500,
                  )),
                ],
              ),
            ),

            /// PostItems
            Expanded(
              child: TabBarView(
                controller: _controller,
                children: [
                  ForYouPostListScreen(),
                  FollowingPostListScreen(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
