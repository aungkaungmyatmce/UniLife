import 'package:blog_post_flutter/app/features/favourite/controller/favourite_controller.dart';
import 'package:get/get.dart';

class FavouriteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FavouriteController());
  }
}
