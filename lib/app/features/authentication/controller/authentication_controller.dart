import 'dart:convert';
import 'dart:io' as Io;
import 'dart:io';

import 'package:blog_post_flutter/app/constant/enum_image_type.dart';
import 'package:blog_post_flutter/app/constant/routing/app_routes.dart';
import 'package:blog_post_flutter/app/core/base/base_controller.dart';
import 'package:blog_post_flutter/app/core/utils/app_utils.dart';
import 'package:blog_post_flutter/app/data/custom_image_phaser_ob.dart';
import 'package:blog_post_flutter/app/data/local/cache_manager.dart';
import 'package:blog_post_flutter/app/data/model/authentication/login_response.dart';
import 'package:blog_post_flutter/app/data/model/authentication/register_request_ob.dart';
import 'package:blog_post_flutter/app/data/network/base_response/base_api_response.dart';
import 'package:blog_post_flutter/app/data/network/exception/base_exception.dart';
import 'package:blog_post_flutter/app/data/repository/authentication/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthenticationController extends BaseController {
  final AuthRepository _repository = Get.find(tag: (AuthRepository).toString());

  final Rx<TextEditingController> userNameController =
      TextEditingController().obs;
  final Rx<TextEditingController> firstNameController =
      TextEditingController().obs;
  final Rx<TextEditingController> lastNameController =
      TextEditingController().obs;
  final Rx<TextEditingController> universityController =
      TextEditingController().obs;
  final Rx<TextEditingController> passwordController =
      TextEditingController().obs;
  final Rx<TextEditingController> confirmPasswordController =
      TextEditingController().obs;
  final GlobalKey formKey = GlobalKey<FormState>();
  var showPassword = false.obs;
  var showConfirmPassword = false.obs;
  RxString userName = "".obs;
  RxString firstName = "".obs;
  RxString lastName = "".obs;
  RxString universityName = "".obs;
  RxString password = "".obs;
  RxString confirmPassword = "".obs;
  Rx<CustomImagePhaserOb> chooseProfileImage = CustomImagePhaserOb().obs;
  RxString base64ProfileImage = "".obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void addProfileImage(File file) {
    CustomImagePhaserOb customImagePhaserOb = CustomImagePhaserOb();
    customImagePhaserOb.image = file;
    customImagePhaserOb.type = ImageType.fileImage;
    chooseProfileImage.value =
        CustomImagePhaserOb(image: file, type: ImageType.fileImage);
    final bytes = Io.File(file.path).readAsBytesSync();
    base64ProfileImage.value = "data:image/jpeg;base64," + base64Encode(bytes);
    print("base64ProfileImage is $base64ProfileImage");
  }

  void doRegister() {
    if (base64ProfileImage.value.isEmpty || base64ProfileImage.value == "") {
      AppUtils.showToast("Please Choose Profile Image");
      return;
    }
    if (userNameController.value.text.trim().isEmpty) {
      AppUtils.showToast("Please Enter User Name");
      return;
    }
    if (firstNameController.value.text.trim().isEmpty) {
      AppUtils.showToast("Please Enter First Name");
      return;
    }
    if (lastNameController.value.text.trim().isEmpty) {
      AppUtils.showToast("Please Enter Last Name");
      return;
    }
    if (universityController.value.text.trim().isEmpty) {
      AppUtils.showToast("Please Enter University Name");
      return;
    }
    if (passwordController.value.text.trim().isEmpty) {
      AppUtils.showToast("Please Enter Password");
      return;
    }
    if (confirmPasswordController.value.text.trim().isEmpty) {
      AppUtils.showToast("Please Enter Confirm Password");
      return;
    }
    if (passwordController.value.text.trim() !=
        confirmPasswordController.value.text.trim()) {
      AppUtils.showToast("Passwords do not match");
      return;
    }
    var requestOb = RegisterRequestOb(
        username: userNameController.value.text.trim(),
        firstName: firstNameController.value.text.trim(),
        lastName: lastNameController.value.text.trim(),
        university: universityController.value.text.trim(),
        password: passwordController.value.text,
        profilePicture: base64ProfileImage.value);
    logger.i("Register Request Ob is ${requestOb.toJson()}");
    final repoService = _repository.registerUser(requestOb);
    AppUtils.showLoaderDialog();
    callAPIService(repoService, onSuccess: onSuccessLogin,
        onError: (BaseException exception) {
      Get.back();
      AppUtils.showToast(exception.message);
    });
  }

// void doLogin() async {
//   if (userNameController.value.text.isEmpty) {
//     AppUtils.showToast("Please Enter UserName");
//   }
//   if (passwordController.value.text.isEmpty) {
//     AppUtils.showToast("Please Enter Password");
//   }
//   if (userNameController.value.text.isNotEmpty &&
//       passwordController.value.text.isNotEmpty) {
//     var requestOb = LoginRequestOb(
//       username: userNameController.value.text.trim(),
//       password: passwordController.value.text,
//     );
//     final repoService = _repository.loginUser(requestOb);
//     AppUtils.showLoaderDialog();
//     callAPIService(repoService, onSuccess: onSuccessLogin,
//         onError: (BaseException exception) {
//       Get.back();
//       AppUtils.showToast(exception.message);
//     });
//   }
// }

  void onSuccessLogin(response) {
    if (response != null) {
      BaseApiResponse<LoginResponse> _loginData = response;
      if (_loginData.objectResult != null) {
        LoginResponse _loginResponse = _loginData.objectResult;
        if (_loginData.statusCode! == 200) {
          Get.back();
          savingData(_loginResponse);
          AppUtils.showToast("Successfully Registered");
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

  void showHideConfirmPassword() {
    showConfirmPassword.value = !showConfirmPassword.value;
  }

  @override
  void onClose() {
    userNameController.value.dispose();
    firstNameController.value.dispose();
    lastNameController.value.dispose();
    passwordController.value.dispose();
    confirmPasswordController.value.dispose();
    super.onClose();
  }
}
