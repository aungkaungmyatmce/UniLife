import 'package:blog_post_flutter/app/data/repository/authentication/authentication_repository.dart';
import 'package:blog_post_flutter/app/data/repository/authentication/authentication_repository_impl.dart';
import 'package:blog_post_flutter/app/data/repository/post/post_repository.dart';
import 'package:blog_post_flutter/app/data/repository/post/post_repository_impl.dart';
import 'package:blog_post_flutter/app/features/authentication/controller/authentication_controller.dart';
import 'package:blog_post_flutter/app/features/home/controller/comment_edit_controller.dart';
import 'package:blog_post_flutter/app/features/home/controller/post_create_controller.dart';
import 'package:blog_post_flutter/app/features/home/controller/post_edit_controller.dart';
import 'package:blog_post_flutter/app/features/main_home/controller/main_home_controller.dart';
import 'package:get/get.dart';

import '../../home/controller/comment_controller.dart';

class MainHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MainHomeController());
    Get.put(() => CreatePostController());
    Get.lazyPut(() => EditPostController());
    Get.lazyPut(() => CommentController());
    Get.lazyPut(() => CommentEditController());
    Get.lazyPut<AuthRepository>(
      () => AuthRepositoryImpl(),
      tag: (AuthRepository).toString(),
    );
    Get.lazyPut(() => AuthenticationController());
    Get.lazyPut<PostRepository>(
      () => PostRepositoryImpl(),
      tag: (PostRepository).toString(),
    );
  }
}
