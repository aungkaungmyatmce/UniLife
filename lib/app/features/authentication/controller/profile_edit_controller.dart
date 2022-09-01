import 'dart:convert';
import 'dart:io';
import 'dart:io' as Io;
import 'package:blog_post_flutter/app/core/base/base_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../constant/enum_image_type.dart';
import '../../../core/utils/app_utils.dart';
import '../../../data/custom_image_phaser_ob.dart';
import '../../../data/model/authentication/profile_ob.dart';
import '../../../data/model/authentication/register_request_ob.dart';
import '../../../data/network/base_response/base_api_response.dart';
import '../../../data/network/exception/base_exception.dart';
import '../../../data/repository/authentication/authentication_repository.dart';
import '../../../widget/post_file_image_widget.dart';

class ProfileEditController extends BaseController {
  final AuthRepository _repository = Get.find(tag: (AuthRepository).toString());
  final Rx<TextEditingController> userNameController =
      TextEditingController().obs;
  final Rx<TextEditingController> firstNameController =
      TextEditingController().obs;
  final Rx<TextEditingController> lastNameController =
      TextEditingController().obs;
  final Rx<TextEditingController> universityController =
      TextEditingController().obs;
  final GlobalKey formKey = GlobalKey<FormState>();
  RxString userName = "".obs;
  RxString firstName = "".obs;
  RxString lastName = "".obs;
  RxString universityName = "".obs;
  var chooseProfileImage = Rxn<CustomImagePhaserOb>();
  RxString base64ProfileImage = "".obs;
  var profileDetail = ProfileOb().obs;
  Rx<CustomImagePhaserOb?> profileImage = CustomImagePhaserOb().obs;

  @override
  void onInit() {
    profileDetail.value = Get.arguments();
    userNameController.value.text = profileDetail.value.username!;
    firstNameController.value.text = profileDetail.value.firstName!;
    lastNameController.value.text = profileDetail.value.lastName!;
    universityController.value.text = profileDetail.value.university!;
    if (profileDetail.value.profilePicture != null) {
      chooseProfileImage.value = CustomImagePhaserOb(
          image: profileDetail.value.profilePicture,
          type: ImageType.networkImage);
    }

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

  Widget getProfileImage({double? height}) {
    return Obx(() => PostFileImageWidget(
          showRemoveIcon: true,
          width: double.infinity,
          height: height,
          imageType: profileImage.value!.type!,
          onDeleteCallBack: () {
            removePostImage();
          },
          file: profileImage.value?.type == ImageType.fileImage
              ? profileImage.value?.image
              : null,
          imagePath: profileImage.value?.type == ImageType.networkImage
              ? profileImage.value?.image
              : null,
        ));
  }

  void removePostImage() {
    profileImage.value = CustomImagePhaserOb();
  }

  void doUpdateProfile() {
    String? base64Image = "";
    if (chooseProfileImage.value?.image != null &&
        chooseProfileImage.value?.type == ImageType.fileImage) {
      File? file = chooseProfileImage.value?.image;
      base64Image = AppUtils.doEncoding(file?.path);
      logger.i("Base64 String is ${AppUtils.doEncoding(file?.path)}");
    }
    // if (base64ProfileImage.value.isEmpty || base64ProfileImage.value == "") {
    //   AppUtils.showToast("Please Choose Profile Image");
    //   return;
    // }
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

    var requestOb = RegisterRequestOb(
        username: userNameController.value.text.trim(),
        firstName: firstNameController.value.text.trim(),
        lastName: lastNameController.value.text.trim(),
        university: universityController.value.text.trim(),
        profilePicture: base64Image);
    logger.i("Register Request Ob is ${requestOb.toJson()}");
    final repoService = _repository.updateProfile(requestOb,
        profileId: profileDetail.value.id!);
    AppUtils.showLoaderDialog();
    callAPIService(repoService, onSuccess: (dynamic response) {
      if (response != null) {
        Get.back();
        Get.back(result: 'updated');

        BaseApiResponse<String?> _baseApiResponse = response;
        // final PostHomeController postHomeController =
        //     Get.put(PostHomeController());
        // postHomeController.resetAndGetPostList(isFollowing: false);
        //Get.put(() => PostHomeTabController());
        //Get.back();
        AppUtils.showToast(" ${_baseApiResponse.message}");
      }
    }, onError: (BaseException exception) {
      Get.back();
      AppUtils.showToast(exception.message);
    });
  }
}
