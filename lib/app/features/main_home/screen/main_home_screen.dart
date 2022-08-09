import 'dart:convert';

import 'package:blog_post_flutter/app/constant/app_colors.dart';
import 'package:blog_post_flutter/app/constant/app_dimens.dart';
import 'package:blog_post_flutter/app/core/utils/global_key_utils.dart';
import 'package:blog_post_flutter/app/data/local/cache_manager.dart';
import 'package:blog_post_flutter/app/data/model/authentication/login_response.dart';
import 'package:blog_post_flutter/app/features/authentication/screen/profile_screen.dart';
import 'package:blog_post_flutter/app/features/authentication/screen/sign_up_screen.dart';
import 'package:blog_post_flutter/app/features/favourite/screen/favourite_screen.dart';
import 'package:blog_post_flutter/app/features/home/screen/post_create_screen.dart';
import 'package:blog_post_flutter/app/features/home/screen/post_home_screen.dart';
import 'package:blog_post_flutter/app/features/main_home/controller/main_home_controller.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({Key? key}) : super(key: key);

  @override
  _MainHomeScreenState createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  final MainHomeController mainHomeScreenController =
      Get.put(MainHomeController(), permanent: false);

  List<Widget> _pageNumber = [
    PostHomeScreen(),
    FavouriteScreen(),
    CreatePostScreen(),
    SignUpScreen(),
    SignUpScreen(),
  ];

  @override
  void initState() {
    var index = Get.arguments;
    if (index != null) {
      mainHomeScreenController.selectedPage.value = index;
    }
    print(
        "Index is ${mainHomeScreenController.selectedPage.value} and Index is $index");
    var prefData =
        Get.find<CacheManager>().getString(CacheManagerKey.loginResponseData) ??
            "";
    if (prefData.isNotEmpty) {
      Map<String, dynamic> loginUserData = jsonDecode(prefData);
      var user = LoginResponse.fromJson(loginUserData);
      GlobalVariable.token = user.token;
      print("Global Main Home is ${GlobalVariable.token}");
      _pageNumber = [
        PostHomeScreen(),
        FavouriteScreen(),
        CreatePostScreen(),
        SignUpScreen(),
        ProfileScreen(),
      ];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => _pageNumber[mainHomeScreenController.selectedPage.value]),
      bottomNavigationBar: Obx(() => ConvexAppBar(
            items: const [
              TabItem(
                title: "Home",
                icon: Icons.home,
              ),
              TabItem(
                title: "Favourite",
                icon: Icons.bookmarks_outlined,
              ),
              TabItem(
                title: "Add",
                icon: Icons.add_circle_outline,
              ),
              TabItem(
                title: "Noti",
                icon: Icons.notification_important_rounded,
              ),
              TabItem(
                title: "Profile",
                icon: Icons.person,
              ),
            ],
            backgroundColor: AppColors.primaryColor,
            activeColor: const Color(0xFF000000),
            color: const Color(0xFF818181),
            initialActiveIndex: mainHomeScreenController.selectedPage.value,
            style: TabStyle.fixed,
            cornerRadius: AppDimens.MARGIN_MEDIUM_2X,
            onTap: (int index) {
              mainHomeScreenController.setSelectedIndex(index);
            },
          )),
    );
  }
}
