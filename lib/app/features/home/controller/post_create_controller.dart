import 'dart:convert';
import 'dart:io';

import 'package:blog_post_flutter/app/constant/enum_image_type.dart';
import 'package:blog_post_flutter/app/constant/routing/app_routes.dart';
import 'package:blog_post_flutter/app/core/base/base_controller.dart';
import 'package:blog_post_flutter/app/core/utils/app_utils.dart';
import 'package:blog_post_flutter/app/data/custom_image_phaser_ob.dart';
import 'package:blog_post_flutter/app/data/model/post/post_request_ob.dart';
import 'package:blog_post_flutter/app/data/network/base_response/base_api_response.dart';
import 'package:blog_post_flutter/app/data/repository/post/post_repository.dart';
import 'package:blog_post_flutter/app/features/home/controller/post_home_controller.dart';
import 'package:blog_post_flutter/app/features/home/controller/post_home_tab_controller.dart';
import 'package:blog_post_flutter/app/widget/post_file_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/local/cache_manager.dart';
import '../../../data/model/authentication/login_response.dart';

class CreatePostController extends BaseController {
  final PostRepository _repository = Get.find(tag: (PostRepository).toString());
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  var loginResponse = LoginResponse().obs;
  Rx<CustomImagePhaserOb?> postImage = CustomImagePhaserOb().obs;
  CreatePostRequestOb createPostRequestOb = CreatePostRequestOb();
  RxInt titleCount = 0.obs;
  RxInt descriptionCount = 0.obs;
  int? postId;

  @override
  void onInit() {
    if (getString(CacheManagerKey.loginResponseData) != null) {
      Map<String, dynamic> authenticationResponse =
          jsonDecode(getString(CacheManagerKey.loginResponseData)!);
      loginResponse.value = LoginResponse.fromJson(authenticationResponse);
      print("Login Response is ${loginResponse.value.user!.profileImage}");
    }
    super.onInit();
  }

  void addPostImage(File file) {
    CustomImagePhaserOb customImagePhaserOb = CustomImagePhaserOb();
    customImagePhaserOb.image = file;
    customImagePhaserOb.type = ImageType.fileImage;
    postImage.value =
        CustomImagePhaserOb(image: file, type: ImageType.fileImage);
  }

  Widget getPostImage({double? height}) {
    return Obx(() => PostFileImageWidget(
          showRemoveIcon: true,
          width: double.infinity,
          height: height,
          imageType: postImage.value!.type!,
          onDeleteCallBack: () {
            removePostImage();
          },
          file: postImage.value?.type == ImageType.fileImage
              ? postImage.value?.image
              : null,
          imagePath: postImage.value?.type == ImageType.networkImage
              ? postImage.value?.image
              : null,
        ));
  }

  void removePostImage() {
    postImage.value = CustomImagePhaserOb();
  }

  void setTitleCount(int i) {
    titleCount.value = i;
  }

  void setDescriptionCount(int i) {
    descriptionCount.value = i;
  }

  void uploadPost() {
    String? base64Image = "";
    if (postImage.value?.image != null &&
        postImage.value?.type == ImageType.fileImage) {
      File? file = postImage.value?.image;
      base64Image = AppUtils.doEncoding(file?.path);
      logger.i("Base64 String is ${AppUtils.doEncoding(file?.path)}");
      createPostRequestOb.isImageRemoved = false;
    }

    if (postImage.value?.image != null &&
        postImage.value?.type == ImageType.networkImage) {
      base64Image = null;
      createPostRequestOb.isImageRemoved = false;
    }

    if (postImage.value?.image == null) {
      base64Image = null;
      createPostRequestOb.isImageRemoved = true;
    }

    if (titleController.text.isEmpty) {
      AppUtils.showToast("Please Enter title");
      return;
    }
    // if (titleCount.value < 5) {
    //   AppUtils.showToast("Title must be at least 5 letters");
    //   return;
    // }
    if (descriptionController.text.isEmpty) {
      AppUtils.showToast("Please Enter Description ");
      return;
    }

    // if (descriptionCount.value < 10) {
    //   AppUtils.showToast("Description must be at least 10 letters");
    //   return;
    // }
    createPostRequestOb.title = titleController.text;
    createPostRequestOb.content = descriptionController.text;
    createPostRequestOb.image = base64Image;

    late Future<BaseApiResponse<String?>> repoService;
    print("Create Post is ${createPostRequestOb.toJson()}");
    AppUtils.showLoaderDialog();
    if (postId != null) {
      repoService = _repository.updatePost(createPostRequestOb, postId);
    } else {
      repoService = _repository.createPost(createPostRequestOb);
    }

    callAPIService(repoService, onSuccess: (dynamic response) {
      if (response != null) {
        Get.back();
        BaseApiResponse<String?> _baseApiResponse = response;
        // final PostHomeController postHomeController =
        //     Get.put(PostHomeController());
        // postHomeController.resetAndGetPostList(isFollowing: false);
        //Get.put(() => PostHomeTabController());
        Get.offAllNamed(
          Paths.MAIN_HOME,
          arguments: 0,
        );
        //Get.back();
        AppUtils.showToast(" ${_baseApiResponse.message}");
      }
    }, onError: (Exception exception) {
      Get.back();
      AppUtils.showToast(errorMessage);
    });
  }
}
