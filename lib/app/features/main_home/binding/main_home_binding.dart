import 'package:blog_post_flutter/app/data/repository/authentication/authentication_repository.dart';
import 'package:blog_post_flutter/app/data/repository/authentication/authentication_repository_impl.dart';
import 'package:blog_post_flutter/app/data/repository/comment/comment_repository.dart';
import 'package:blog_post_flutter/app/data/repository/comment/comment_repository_impl.dart';
import 'package:blog_post_flutter/app/data/repository/post/post_repository.dart';
import 'package:blog_post_flutter/app/data/repository/post/post_repository_impl.dart';
import 'package:blog_post_flutter/app/features/authentication/controller/authentication_controller.dart';
import 'package:blog_post_flutter/app/features/home/controller/comment_edit_controller.dart';
import 'package:blog_post_flutter/app/features/favourite/controller/favourite_controller.dart';
import 'package:blog_post_flutter/app/features/home/controller/post_create_controller.dart';
import 'package:blog_post_flutter/app/features/home/controller/post_edit_controller.dart';
import 'package:blog_post_flutter/app/features/home/controller/post_home_controller.dart';
import 'package:blog_post_flutter/app/features/main_home/controller/main_home_controller.dart';
import 'package:get/get.dart';

import '../../home/controller/comment_controller.dart';
import '../../home/controller/following_postList_controller.dart';
import '../../home/controller/foryou_postList_controller.dart';
import '../../home/controller/post_home_tab_controller.dart';

class MainHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MainHomeController());
    Get.lazyPut(() => CreatePostController());
    Get.lazyPut(() => EditPostController());
    Get.lazyPut(() => CommentController());
    Get.lazyPut(() => CommentEditController());
    Get.lazyPut(() => ForYouPostListController(), fenix: true);
    Get.lazyPut(() => FollowingPostListController(), fenix: true);
    Get.lazyPut<AuthRepository>(
      () => AuthRepositoryImpl(),
      tag: (AuthRepository).toString(),
    );
    Get.lazyPut(() => AuthenticationController());
    //Get.lazyPut(() => PostHomeController());
    Get.lazyPut(() => FavouriteController());
    Get.lazyPut<PostRepository>(
      () => PostRepositoryImpl(),
      tag: (PostRepository).toString(),
    );
    Get.lazyPut<CommentRepository>(
      () => CommentRepositoryImpl(),
      tag: (CommentRepository).toString(),
    );
  }
}
