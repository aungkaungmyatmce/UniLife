import 'package:blog_post_flutter/app/features/home/controller/post_home_controller.dart';
import 'package:get/get.dart';

class MainHomeController extends GetxController {
  final PostHomeController homeController = Get.put(PostHomeController());
  RxInt selectedPage = 0.obs;

  void setSelectedIndex(int index){
    selectedPage.value = index;
    print("Selected Index is ${selectedPage.value}");
    if(selectedPage.value == 0){
      homeController.resetAndGetPostList();
    }
  }
}
