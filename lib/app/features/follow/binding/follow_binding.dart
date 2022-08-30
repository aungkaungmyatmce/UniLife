import 'package:blog_post_flutter/app/features/follow/controller/follow_controller.dart';
import 'package:blog_post_flutter/app/features/follow/controller/tab_controller.dart';
import 'package:get/get.dart';

import '../../../data/repository/comment/comment_repository.dart';
import '../../../data/repository/comment/comment_repository_impl.dart';

class FollowBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FollowController());
    Get.lazyPut(() => MyTabController());
    Get.lazyPut<CommentRepository>(
      () => CommentRepositoryImpl(),
      tag: (CommentRepository).toString(),
    );
  }
}
