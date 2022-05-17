import 'package:blog_post_flutter/app/constant/routing/app_routes.dart';
import 'package:blog_post_flutter/app/features/favourite/binding/favourite_binding.dart';
import 'package:blog_post_flutter/app/features/favourite/screen/favourite_screen.dart';
import 'package:blog_post_flutter/app/features/home/binding/post_home_binding.dart';
import 'package:blog_post_flutter/app/features/home/screen/post_detail_screen.dart';
import 'package:blog_post_flutter/app/features/home/screen/post_home_screen.dart';
import 'package:blog_post_flutter/app/features/main_home/binding/main_home_binding.dart';
import 'package:blog_post_flutter/app/features/main_home/screen/main_home_screen.dart';
import 'package:get/get.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Paths.LOGIN;

  static final routes = [
    GetPage(
        name: Paths.MAIN_HOME,
        page: () => const MainHomeScreen(),
        binding: MainHomeBinding()),
    GetPage(
        name: Paths.HOME, page: () => PostHomeScreen(), binding: HomeBinding()),
    GetPage(
        name: Paths.POST_DETAIL,
        page: () => PostDetailScreen(),
        binding: HomeBinding()),
    GetPage(
        name: Paths.FAVOURITE,
        page: () => const FavouriteScreen(),
        binding: FavouriteBinding()),
  ];
}
