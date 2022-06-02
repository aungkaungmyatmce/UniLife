import 'package:blog_post_flutter/app/constant/app_dimens.dart';
import 'package:blog_post_flutter/app/core/utils/global_key_utils.dart';
import 'package:blog_post_flutter/app/features/authentication/screen/login_screen.dart';
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

  final _pageNumber = [
    PostHomeScreen(),
    GlobalVariable.token != null ? CreatePostScreen() : const LoginScreen(),
    GlobalVariable.token != null ? FavouriteScreen() : const LoginScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => _pageNumber[mainHomeScreenController.selectedPage.value]),
      bottomNavigationBar: Obx(() => ConvexAppBar(
            items: const [
              TabItem(icon: Icons.home, title: "Home"),
              TabItem(icon: Icons.add, title: "Add"),
              TabItem(icon: Icons.favorite, title: "Favourite"),
            ],
            initialActiveIndex: mainHomeScreenController.selectedPage.value,
            style: TabStyle.fixedCircle,
            cornerRadius: AppDimens.MARGIN_MEDIUM_2X,
            onTap: (int index) {
              mainHomeScreenController.setSelectedIndex(index);
            },
          )),
    );
  }
}
