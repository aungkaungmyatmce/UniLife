import 'package:blog_post_flutter/app/data/repository/authentication/authentication_repository.dart';
import 'package:blog_post_flutter/app/data/repository/authentication/authentication_repository_impl.dart';
import 'package:blog_post_flutter/app/features/authentication/controller/authentication_controller.dart';
import 'package:blog_post_flutter/app/features/home/controller/comment_edit_controller.dart';
import 'package:blog_post_flutter/app/features/home/controller/following_postList_controller.dart';
import 'package:blog_post_flutter/app/features/home/controller/foryou_postList_controller.dart';
import 'package:blog_post_flutter/app/features/home/controller/other_profile_controller.dart';
import 'package:blog_post_flutter/app/features/home/controller/post_create_controller.dart';
import 'package:blog_post_flutter/app/features/home/controller/post_detail_controller.dart';
import 'package:blog_post_flutter/app/features/home/controller/post_edit_controller.dart';
import 'package:blog_post_flutter/app/features/home/controller/post_home_controller.dart';
import 'package:blog_post_flutter/app/features/home/controller/post_home_tab_controller.dart';
import 'package:get/get.dart';

import '../../../data/repository/comment/comment_repository.dart';
import '../../../data/repository/comment/comment_repository_impl.dart';
import '../controller/comment_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PostHomeController());
    Get.lazyPut(() => CreatePostController(), fenix: true);
    Get.lazyPut(() => AuthenticationController(), fenix: true);
    Get.lazyPut(() => PostDetailController(), fenix: true);
    Get.lazyPut(() => EditPostController(), fenix: true);
    Get.lazyPut(() => OtherProfileController(), fenix: true);
    Get.lazyPut(() => CommentController(), fenix: true);
    Get.lazyPut(() => CommentEditController(), fenix: true);
    //Get.lazyPut(() => PostHomeTabController(), fenix: true);
    Get.lazyPut(() => ForYouPostListController(), fenix: true);
    Get.lazyPut(() => FollowingPostListController(), fenix: true);
    Get.lazyPut<AuthRepository>(
      () => AuthRepositoryImpl(),
      tag: (AuthRepository).toString(),
    );
    Get.lazyPut<CommentRepository>(
      () => CommentRepositoryImpl(),
      tag: (CommentRepository).toString(),
    );
  }
}
