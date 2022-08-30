import 'dart:convert';
import 'dart:io' as Io;
import 'dart:io';

import 'package:blog_post_flutter/app/constant/enum_image_type.dart';
import 'package:blog_post_flutter/app/constant/routing/app_routes.dart';
import 'package:blog_post_flutter/app/core/base/base_controller.dart';
import 'package:blog_post_flutter/app/core/utils/app_utils.dart';
import 'package:blog_post_flutter/app/core/utils/global_key_utils.dart';
import 'package:blog_post_flutter/app/core/utils/shimmer_utils.dart';
import 'package:blog_post_flutter/app/data/custom_image_phaser_ob.dart';
import 'package:blog_post_flutter/app/data/local/cache_manager.dart';
import 'package:blog_post_flutter/app/data/model/authentication/login_request_ob.dart';
import 'package:blog_post_flutter/app/data/model/authentication/login_response.dart';
import 'package:blog_post_flutter/app/data/model/authentication/profile_ob.dart';
import 'package:blog_post_flutter/app/data/model/authentication/register_request_ob.dart';
import 'package:blog_post_flutter/app/data/network/base_response/base_api_response.dart';
import 'package:blog_post_flutter/app/data/network/exception/base_exception.dart';
import 'package:blog_post_flutter/app/data/repository/authentication/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AuthenticationController extends BaseController {
  final AuthRepository _repository = Get.find(tag: (AuthRepository).toString());

  //SignUp
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

  //Login
  final Rx<TextEditingController> loginUserNameController =
      TextEditingController().obs;
  final Rx<TextEditingController> loginPasswordController =
      TextEditingController().obs;
  final GlobalKey loginFormKey = GlobalKey<FormState>();
  RxString loginUserName = "".obs;
  RxString loginPassword = "".obs;
  var showLoginPassword = false.obs;

  //Profile
  var profileDetail = ProfileOb().obs;
  Rx<LoginResponse> loginResponse = LoginResponse().obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if (getString(CacheManagerKey.loginResponseData) != null) {
      Map<String, dynamic> authenticationResponse =
          jsonDecode(getString(CacheManagerKey.loginResponseData)!);
      loginResponse.value = LoginResponse.fromJson(authenticationResponse);
      if (loginResponse.value.user!.id != null) {
        fetchProfile(loginResponse.value.user!.id!);
      }
    }
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

  void savingData(LoginResponse loginResponse) {
    //fetchProfile(loginResponse.user!.id!);
    setData(CacheManagerKey.loginResponseData, jsonEncode(loginResponse));
  }

  void showHidePassword() {
    showPassword.value = !showPassword.value;
  }

  void showHideConfirmPassword() {
    showConfirmPassword.value = !showConfirmPassword.value;
  }

  void showHideLoginPassword() {
    showLoginPassword.value = !showLoginPassword.value;
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
        profilePicture: null);
    logger.i("Register Request Ob is ${requestOb.toJson()}");
    final repoService = _repository.registerUser(requestOb);
    AppUtils.showLoaderDialog();
    callAPIService(repoService, onSuccess: onSuccessLogin,
        onError: (BaseException exception) {
      Get.back();
      AppUtils.showToast(exception.message);
    });
  }

  void doLogin() async {
    if (loginUserNameController.value.text.isEmpty) {
      AppUtils.showToast("Please Enter UserName");
    }
    if (loginPasswordController.value.text.isEmpty) {
      AppUtils.showToast("Please Enter Password");
    }
    if (loginUserNameController.value.text.isNotEmpty &&
        loginPasswordController.value.text.isNotEmpty) {
      var requestOb = LoginRequestOb(
        username: loginUserNameController.value.text.trim(),
        password: loginPasswordController.value.text,
      );
      final repoService = _repository.loginUser(requestOb);
      AppUtils.showLoaderDialog();
      callAPIService(repoService, onSuccess: onSuccessLogin,
          onError: (BaseException exception) {
        Get.back();
        AppUtils.showToast(exception.message);
      });
    }
  }

  void onSuccessLogin(response) {
    if (response != null) {
      BaseApiResponse<LoginResponse> _loginData = response;
      if (_loginData.objectResult != null) {
        LoginResponse _loginResponse = _loginData.objectResult;
        if (_loginData.statusCode! == 200) {
          Get.back();
          savingData(_loginResponse);
          AppUtils.showToast("Successfully Login");
          Get.offAllNamed(Paths.MAIN_HOME, arguments: 4);
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

  void fetchProfile(int? profileId) async {
    final repoService = _repository.getProfileDetail(profileId);
    await callAPIService(
      repoService,
      onStart: profileDetail.value.id == null
          ? () => showLoading(shimmerEffect: ShimmerUtils.profile)
          : null,
      onSuccess: _handleResponseSuccess,
      onError: _handleResponseError,
    );
  }

  void _handleResponseSuccess(response) async {
    if (response != null) {
      BaseApiResponse<ProfileOb?> _profileDetailData = response;
      ProfileOb data = _profileDetailData.objectResult;
      profileDetail.value = data;
    }
  }

  void _handleResponseError(Exception exception) {
    AppUtils.showToast(errorMessage);
  }

  //Logout
  void doLogout() {
    final repoService = _repository.logoutUser();
    AppUtils.showLoaderDialog();
    callAPIService(repoService, onSuccess: onSuccessLogout,
        onError: (exception) {
      AppUtils.showToast(errorMessage);
      Get.back();
    });
  }

  void onSuccessLogout(response) {
    if (response != null) {
      BaseApiResponse<String?> baseApiResponse = response;
      print(
          "Base API Rsponse Message is ${baseApiResponse.statusCode} and ${baseApiResponse.message}");
      clearAllData();
      GlobalVariable.token = null;
      Get.offAllNamed(Paths.MAIN_HOME, arguments: 4);
      AppUtils.showToast(" ${baseApiResponse.message}");
    }
  }

  void onTapFollow(int index) {
    Get.toNamed(Paths.FOLLOW, arguments: {
      'myProfile': profileDetail.value,
      'tabIndex': index,
    })?.then((result) {
      if (result == "updated") {
        Future.delayed(Duration(milliseconds: 100))
            .then((value) => fetchProfile(loginResponse.value.user!.id!));
      }
    });
  }
}
