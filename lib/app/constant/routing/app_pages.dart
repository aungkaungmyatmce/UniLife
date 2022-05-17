import 'package:blog_post_flutter/app/constant/routing/app_routes.dart';
import 'package:blog_post_flutter/app/features/home/binding/post_home_binding.dart';
import 'package:blog_post_flutter/app/features/home/screen/post_home_screen.dart';
import 'package:get/get.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Paths.LOGIN;

  static final routes = [
    GetPage(
        name: Paths.HOME, page: () => PostHomeScreen(), binding: HomeBinding()),
  ];
}
