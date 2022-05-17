import 'package:blog_post_flutter/app/features/home/controller/post_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/get_instance.dart';

class ViewControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  }
}

T findInject<T>(T) => Get.find(tag: (T).toString());
