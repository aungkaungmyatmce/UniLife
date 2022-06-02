import 'package:blog_post_flutter/app/data/repository/authentication/authentication_repository.dart';
import 'package:blog_post_flutter/app/data/repository/authentication/authentication_repository_impl.dart';
import 'package:blog_post_flutter/app/features/authentication/controller/login_controller.dart';
import 'package:blog_post_flutter/app/features/home/controller/post_create_controller.dart';
import 'package:blog_post_flutter/app/features/home/controller/post_detail_controller.dart';
import 'package:blog_post_flutter/app/features/home/controller/post_edit_controller.dart';
import 'package:blog_post_flutter/app/features/home/controller/post_home_controller.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PostHomeController());
    Get.lazyPut(() => LoginController(), fenix: true);
    Get.lazyPut(() => CreatePostController(), fenix: true);
    Get.lazyPut(() => PostDetailController(), fenix: true);
    Get.lazyPut(() => EditPostController(), fenix: true);
    Get.lazyPut<AuthRepository>(
      () => AuthRepositoryImpl(),
      tag: (AuthRepository).toString(),
    );
  }
}
