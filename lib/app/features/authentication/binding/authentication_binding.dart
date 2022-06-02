import 'package:blog_post_flutter/app/data/repository/authentication/authentication_repository.dart';
import 'package:blog_post_flutter/app/data/repository/authentication/authentication_repository_impl.dart';
import 'package:blog_post_flutter/app/features/authentication/controller/login_controller.dart';
import 'package:get/get.dart';

class AuthenticationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController(), fenix: true);
    Get.lazyPut<AuthRepository>(
      () => AuthRepositoryImpl(),
      tag: (AuthRepository).toString(),
    );
  }
}
