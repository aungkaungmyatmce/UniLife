import 'package:blog_post_flutter/app/data/local/cache_manager.dart';
import 'package:get/get.dart';

class CachedManagerBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CacheManager>(
          () => CacheManager(),
      tag: (CacheManager).toString(),
    );
  }
}
