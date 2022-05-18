import 'dart:convert';

import 'package:blog_post_flutter/app/constant/routing/app_routes.dart';
import 'package:blog_post_flutter/app/core/base/base_controller.dart';
import 'package:blog_post_flutter/app/core/utils/app_utils.dart';
import 'package:blog_post_flutter/app/data/local/cache_manager.dart';
import 'package:blog_post_flutter/app/data/model/authentication/login_request_ob.dart';
import 'package:blog_post_flutter/app/data/model/authentication/login_response.dart';
import 'package:blog_post_flutter/app/data/network/base_response/base_api_response.dart';
import 'package:blog_post_flutter/app/data/network/exception/base_exception.dart';
import 'package:blog_post_flutter/app/data/repository/authentication/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends BaseController {
  final AuthRepository _repository = Get.find(tag: (AuthRepository).toString());

  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  var showPassword = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void doLogin() async {
    var requestOb = LoginRequestOb(
        username: userNameController.text.trim(),
        password: passwordController.text,);
    final repoService = _repository.loginUser(requestOb);
    AppUtils.showLoaderDialog();
    callAPIService(repoService, onSuccess: onSuccessLogin,
        onError: (BaseException exception) {
          Get.back();
          AppUtils.showToast(exception.message);
        });
  }

  void onSuccessLogin(response) {
    if (response != null) {
      BaseApiResponse<LoginResponse> _loginData = response;
      if (_loginData.objectResult != null) {
        LoginResponse _loginResponse = _loginData.objectResult;
        if (_loginData.statusCode! == 200) {
          Get.back();
          savingData(_loginResponse);
          Get.offAllNamed(
            Paths.MAIN_HOME,
          );
        } else {
          AppUtils.showToast("Invalid Credentials");
        }
      } else {
        Get.back();
        AppUtils.showToast(_loginData.message!);
      }
    } else {
      AppUtils.showToast("Something went wrong. Try again!");
    }
  }

  void savingData(LoginResponse loginResponse) {
    setData(CacheManagerKey.loginResponseData, jsonEncode(loginResponse));
  }

  void showHidePassword() {
    showPassword.value = !showPassword.value;
  }
}
