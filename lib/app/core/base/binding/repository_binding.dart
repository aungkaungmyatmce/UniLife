import 'package:blog_post_flutter/app/data/repository/post/post_repository.dart';
import 'package:blog_post_flutter/app/data/repository/post/post_repository_impl.dart';
import 'package:get/get.dart';

class RepositoryBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PostRepository>(
          () => PostRepositoryImpl(),
      tag: (PostRepository).toString(),
    );
  }
}
