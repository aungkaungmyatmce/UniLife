import 'package:blog_post_flutter/app/constant/routing/app_routes.dart';
import 'package:blog_post_flutter/app/features/authentication/binding/authentication_binding.dart';
import 'package:blog_post_flutter/app/features/authentication/screen/login_screen.dart';
import 'package:blog_post_flutter/app/features/favourite/binding/favourite_binding.dart';
import 'package:blog_post_flutter/app/features/favourite/screen/favourite_screen.dart';
import 'package:blog_post_flutter/app/features/home/binding/post_home_binding.dart';
import 'package:blog_post_flutter/app/features/home/screen/post_create_screen.dart';
import 'package:blog_post_flutter/app/features/home/screen/post_detail_screen.dart';
import 'package:blog_post_flutter/app/features/home/screen/post_edit_screen.dart';
import 'package:blog_post_flutter/app/features/home/screen/post_home_screen.dart';
import 'package:blog_post_flutter/app/features/main_home/binding/main_home_binding.dart';
import 'package:blog_post_flutter/app/features/main_home/screen/main_home_screen.dart';
import 'package:blog_post_flutter/app/features/profile/binding/profile_binding.dart';
import 'package:blog_post_flutter/app/features/profile/screen/profile_screen.dart';
import 'package:get/get.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Paths.LOGIN;

  static final routes = [
    GetPage(
        name: Paths.LOGIN,
        page: () => const LoginScreen(),
        binding: AuthenticationBinding()),
    GetPage(
        name: Paths.MAIN_HOME,
        page: () => MainHomeScreen(),
        bindings: [MainHomeBinding(), HomeBinding(), FavouriteBinding()]),
    GetPage(
        name: Paths.HOME, page: () => PostHomeScreen(), binding: HomeBinding()),
    GetPage(
        name: Paths.POST_DETAIL,
        page: () => PostDetailScreen(),
        binding: HomeBinding()),
    GetPage(
        name: Paths.POST_CREATE,
        page: () => CreatePostScreen(),
        binding: HomeBinding()),
    GetPage(
        name: Paths.POST_EDIT,
        page: () => EditPostScreen(),
        binding: HomeBinding()),
    GetPage(
        name: Paths.FAVOURITE,
        page: () => FavouriteScreen(),
        binding: FavouriteBinding()),
    GetPage(
        name: Paths.PROFILE,
        page: () => ProfileScreen(),
        binding: ProfileBinding()),
  ];
}
