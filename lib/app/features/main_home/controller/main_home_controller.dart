import 'package:blog_post_flutter/app/core/utils/global_key_utils.dart';
import 'package:blog_post_flutter/app/data/repository/authentication/authentication_repository.dart';
import 'package:blog_post_flutter/app/data/repository/authentication/authentication_repository_impl.dart';
import 'package:blog_post_flutter/app/features/authentication/controller/authentication_controller.dart';
import 'package:blog_post_flutter/app/features/favourite/controller/favourite_controller.dart';
import 'package:blog_post_flutter/app/features/home/controller/post_home_controller.dart';
import 'package:get/get.dart';

class MainHomeController extends GetxController {
  RxInt selectedPage = 0.obs;

  void setSelectedIndex(int index) {
    selectedPage.value = index;
    print("Selected Index is ${selectedPage.value}");
    if (selectedPage.value == 0) {
      final PostHomeController homeController = Get.put(PostHomeController());
      homeController.resetAndGetPostList();
    } else if (selectedPage.value == 1) {
      final FavouriteController favouriteController =
          Get.put(FavouriteController());
      favouriteController.resetAndGetSavePostList();
    } else if (selectedPage.value == 2) {
      if (GlobalVariable.token == null) {
        Get.lazyPut(() => AuthenticationController());
        Get.lazyPut<AuthRepository>(
          () => AuthRepositoryImpl(),
          tag: (AuthRepository).toString(),
        );
      }
    } else {
      if (GlobalVariable.token == null) {
        Get.lazyPut(() => AuthenticationController());
        Get.lazyPut<AuthRepository>(
          () => AuthRepositoryImpl(),
          tag: (AuthRepository).toString(),
        );
      }
    }
  }
}
