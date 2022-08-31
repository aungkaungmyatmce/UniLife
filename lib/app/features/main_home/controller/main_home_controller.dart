import 'dart:convert';

import 'package:blog_post_flutter/app/data/local/cache_manager.dart';
import 'package:blog_post_flutter/app/data/model/authentication/login_response.dart';
import 'package:get/get.dart';

class MainHomeController extends GetxController with CacheManager {
  RxInt selectedPage = 0.obs;
  Rx<LoginResponse> loginResponse = LoginResponse().obs;

  void setSelectedIndex(int index) {
    selectedPage.value = index;
    print("Selected Index is ${selectedPage.value}");
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if (getString(CacheManagerKey.loginResponseData) != null) {
      Map<String, dynamic> authenticationResponse =
          jsonDecode(getString(CacheManagerKey.loginResponseData)!);
      loginResponse.value = LoginResponse.fromJson(authenticationResponse);
      print("Login Response is ${loginResponse.value.user!.profileImage}");
    }
  }
}
