import 'package:blog_post_flutter/app/features/home/controller/post_create_controller.dart';
import 'package:blog_post_flutter/app/features/home/controller/post_detail_controller.dart';
import 'package:blog_post_flutter/app/features/home/controller/post_edit_controller.dart';
import 'package:blog_post_flutter/app/features/home/controller/post_home_controller.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PostHomeController());
    Get.lazyPut(() => CreatePostController(), fenix: true);
    Get.lazyPut(() => PostDetailController(), fenix: true);
    Get.lazyPut(() => EditPostController(), fenix: true);
  }
}
