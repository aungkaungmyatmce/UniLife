import 'dart:convert';

import 'package:blog_post_flutter/app/constant/app_colors.dart';
import 'package:blog_post_flutter/app/constant/app_dimens.dart';
import 'package:blog_post_flutter/app/core/utils/global_key_utils.dart';
import 'package:blog_post_flutter/app/data/local/cache_manager.dart';
import 'package:blog_post_flutter/app/data/model/authentication/login_response.dart';
import 'package:blog_post_flutter/app/features/authentication/screen/direct_to_signin_screen.dart';
import 'package:blog_post_flutter/app/features/authentication/screen/profile_screen.dart';
import 'package:blog_post_flutter/app/features/authentication/screen/sign_up_screen.dart';
import 'package:blog_post_flutter/app/features/favourite/screen/favourite_screen.dart';
import 'package:blog_post_flutter/app/features/home/screen/post_create_screen.dart';
import 'package:blog_post_flutter/app/features/home/screen/post_home_screen.dart';
import 'package:blog_post_flutter/app/features/main_home/controller/main_home_controller.dart';
import 'package:blog_post_flutter/app/features/notification/screen/notification_screen.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../../data/network/services/dio_provider.dart';

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({Key? key}) : super(key: key);

  @override
  _MainHomeScreenState createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  final MainHomeController mainHomeScreenController =
      Get.put(MainHomeController(), permanent: false);

  PersistentTabController? _bottomTabController;

  List<Widget> _pageNumber = [
    const PostHomeScreen(),
    FavouriteScreen(),
    const DirectToSignInScreen(),
    NotificationScreen(),
    SignUpScreen(),
  ];

  @override
  void initState() {
    _bottomTabController = PersistentTabController(initialIndex: 0);
    mainHomeScreenController.selectedPage.listen((value) {
      setState(() {
        _bottomTabController!.index = value;
      });
    });
    // _bottomTabController.addListener(() {
    //   print('Listener');
    //   print(mainHomeScreenController.selectedPage.value);
    //   _bottomTabController.index = mainHomeScreenController.selectedPage.value;
    // });

    var index = Get.arguments;
    if (index != null) {
      mainHomeScreenController.selectedPage.value = index;
      // _bottomTabController!.index = index;
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
      _pageNumber = [
        PostHomeScreen(),
        FavouriteScreen(),
        CreatePostScreen(),
        NotificationScreen(),
        ProfileScreen(),
      ];
    }
    print("Global Main Home is ${GlobalVariable.token}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => PersistentTabView(
          context,
          controller: _bottomTabController,
          screens: _pageNumber,
          items: _navBarsItems(),
          backgroundColor: AppColors.primaryColor, // Default is Colors.white.
          decoration: NavBarDecoration(
            borderRadius: BorderRadius.circular(5.0),
            colorBehindNavBar: AppColors.primaryColor,
          ),
          popAllScreensOnTapOfSelectedTab: true,
          popActionScreens: PopActionScreensType.all,
          itemAnimationProperties: ItemAnimationProperties(
            duration: Duration(milliseconds: 200),
            curve: Curves.ease,
          ),
          screenTransitionAnimation: ScreenTransitionAnimation(
            animateTabTransition: true,
            curve: Curves.ease,
            duration: Duration(milliseconds: 200),
          ),
          navBarStyle: NavBarStyle
              .style15, // Choose the nav bar style with this property.
        ),
      ),
    );
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        title: ("Home"),
        activeColorPrimary: AppColors.secondaryTextColor,
        inactiveColorPrimary: AppColors.secondaryTextColor.withOpacity(0.6),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.bookmarks_outlined),
        title: ("Bookmark"),
        activeColorPrimary: AppColors.secondaryTextColor,
        inactiveColorPrimary: AppColors.secondaryTextColor.withOpacity(0.6),
      ),
      PersistentBottomNavBarItem(
        icon: CircleAvatar(
          radius: 50,
          backgroundColor: AppColors.primaryColor,
          child: Icon(
            Icons.add_circle_outline,
            color: AppColors.secondaryTextColor,
          ),
        ),
        inactiveIcon: CircleAvatar(
          radius: 50,
          backgroundColor: AppColors.primaryColor,
          child: Icon(
            Icons.add_circle_outline,
            color: AppColors.secondaryTextColor.withOpacity(0.6),
          ),
        ),
        title: ("Add"),
        activeColorPrimary: AppColors.secondaryTextColor,
        inactiveColorPrimary: AppColors.secondaryTextColor.withOpacity(0.6),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.notification_important_rounded),
        title: ("Noti"),
        activeColorPrimary: AppColors.secondaryTextColor,
        inactiveColorPrimary: AppColors.secondaryTextColor.withOpacity(0.6),
      ),
      mainHomeScreenController.loginResponse.value.user != null
          ? mainHomeScreenController.loginResponse.value.user!.profileImage !=
                  null
              ? PersistentBottomNavBarItem(
                  iconSize: 15,
                  contentPadding: 0,
                  inactiveIcon: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: 12,
                        backgroundColor:
                            AppColors.secondaryTextColor.withOpacity(0.6),
                        backgroundImage: NetworkImage(
                            "${DioProvider.serverUrl}${mainHomeScreenController.loginResponse.value.user!.profileImage}"),
                      ),
                      Text(
                        'You',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.secondaryTextColor.withOpacity(0.6),
                        ),
                      )
                    ],
                  ),
                  icon: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: 12,
                        backgroundColor:
                            AppColors.secondaryTextColor.withOpacity(0.6),
                        backgroundImage: NetworkImage(
                            "${DioProvider.serverUrl}${mainHomeScreenController.loginResponse.value.user!.profileImage}"),
                      ),
                      Text(
                        'You',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                  //title: ("You"),
                  //textStyle: TextStyle(fontSize: 12, height: 0.1),
                  activeColorPrimary: AppColors.secondaryTextColor,
                  inactiveColorPrimary:
                      AppColors.secondaryTextColor.withOpacity(0.6),
                )
              : PersistentBottomNavBarItem(
                  icon: Icon(Icons.account_circle),
                  title: ("You"),
                  activeColorPrimary: AppColors.secondaryTextColor,
                  inactiveColorPrimary:
                      AppColors.secondaryTextColor.withOpacity(0.6),
                )
          : PersistentBottomNavBarItem(
              icon: Icon(Icons.account_circle),
              title: ("Profile"),
              activeColorPrimary: AppColors.secondaryTextColor,
              inactiveColorPrimary:
                  AppColors.secondaryTextColor.withOpacity(0.6),
            ),
    ];
  }
}

//body: Obx(() => _pageNumber[mainHomeScreenController.selectedPage.value]),
// bottomNavigationBar: Obx(() => ConvexAppBar(
//       items: [
//         TabItem(
//           title: "Home",
//           icon: Icons.home,
//         ),
//         TabItem(
//           title: "Bookmark",
//           icon: Icons.bookmarks_outlined,
//         ),
//         TabItem(
//           title: "Add",
//           icon: Icons.add_circle_outline,
//         ),
//         TabItem(
//           title: "Noti",
//           icon: Icons.notification_important_rounded,
//         ),
//         mainHomeScreenController.loginResponse.value.user != null
//             ? mainHomeScreenController
//                         .loginResponse.value.user!.profileImage !=
//                     null
//                 ? TabItem(
//                     title: "You",
//                     icon: CircleAvatar(
//                       radius: 35,
//                       backgroundColor:
//                           AppColors.secondaryTextColor.withOpacity(0.6),
//                       backgroundImage: NetworkImage(
//                           "${DioProvider.serverUrl}${mainHomeScreenController.loginResponse.value.user!.profileImage}"),
//                     ))
//                 : TabItem(title: "You", icon: Icons.account_circle)
//             : TabItem(title: "Profile", icon: Icons.account_circle),
//       ],
//       backgroundColor: AppColors.primaryColor,
//       activeColor: AppColors.secondaryTextColor,
//       color: AppColors.secondaryTextColor.withOpacity(0.6),
//       initialActiveIndex: mainHomeScreenController.buttonController
//           .index, //mainHomeScreenController.selectedPage.value,
//       style: TabStyle.fixed,
//       //cornerRadius: AppDimens.MARGIN_MEDIUM_2X,
//       onTap: (int index) {
//         mainHomeScreenController.setSelectedIndex(index);
//       },
//       controller: mainHomeScreenController.buttonController,
//     )),
