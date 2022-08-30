import 'dart:io';
import 'package:blog_post_flutter/app/constant/enum_image_type.dart';
import 'package:blog_post_flutter/app/constant/routing/app_routes.dart';
import 'package:blog_post_flutter/app/core/base/base_controller.dart';
import 'package:blog_post_flutter/app/core/utils/app_utils.dart';
import 'package:blog_post_flutter/app/data/custom_image_phaser_ob.dart';
import 'package:blog_post_flutter/app/data/model/post/post_ob.dart';
import 'package:blog_post_flutter/app/data/model/post/post_request_ob.dart';
import 'package:blog_post_flutter/app/data/network/base_response/base_api_response.dart';
import 'package:blog_post_flutter/app/data/repository/post/post_repository.dart';
import 'package:blog_post_flutter/app/widget/post_file_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditPostController extends BaseController {
  final PostRepository _repository = Get.find(tag: (PostRepository).toString());
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  Rx<CustomImagePhaserOb?> postImage = CustomImagePhaserOb().obs;
  CreatePostRequestOb createPostRequestOb = CreatePostRequestOb();
  RxInt titleCount = 0.obs;
  RxInt descriptionCount = 0.obs;
  Rx<PostData?> postOb = PostData().obs;

  @override
  void onInit() {
    if (Get.arguments != null) {
      postOb.value = Get.arguments as PostData;
      if (postOb.value?.id != null) {
        setPostData();
      }
    }
    super.onInit();
  }

  void setPostData() {
    CustomImagePhaserOb customImagePhaserOb = CustomImagePhaserOb();
    customImagePhaserOb.id = postOb.value?.id;
    customImagePhaserOb.image = postOb.value?.image;
    customImagePhaserOb.type = ImageType.networkImage;
    //postImage.value = customImagePhaserOb;
    postImage.value = CustomImagePhaserOb(
      id: postOb.value?.id,
      image: postOb.value?.image,
    );
    titleController.text = postOb.value?.title ?? "";
    descriptionController.text = postOb.value?.content ?? "";
  }

  void addPostImage(File file) {
    CustomImagePhaserOb customImagePhaserOb = CustomImagePhaserOb();
    customImagePhaserOb.image = file;
    customImagePhaserOb.type = ImageType.fileImage;
    postImage.value =
        CustomImagePhaserOb(image: file, type: ImageType.fileImage);
  }

  Widget getPostImage() {
    return Obx(() => PostFileImageWidget(
          showRemoveIcon: true,
          width: double.infinity,
          height: 150,
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

  void updatePost() {
    String? base64Image = "";
    if (postImage.value?.image != null &&
        postImage.value?.type == ImageType.fileImage) {
      File? file = postImage.value?.image;
      base64Image = AppUtils.doEncoding(file?.path);
      logger.i("Base64 String is ${AppUtils.doEncoding(file?.path)}");
    }

    if (titleController.text.isEmpty) {
      AppUtils.showToast("Please Enter title");
      return;
    }
    if (descriptionController.text.isEmpty) {
      AppUtils.showToast("Please Enter Description ");
      return;
    }
    if (descriptionCount.value < 80) {
      AppUtils.showToast("Description must be at least 80 letters");
      return;
    }
    createPostRequestOb.title = titleController.text;
    createPostRequestOb.content = descriptionController.text;
    createPostRequestOb.image = base64Image;

    late Future<BaseApiResponse<String?>> repoService;
    print("Update Post is ${createPostRequestOb.toJson()}");
    AppUtils.showLoaderDialog();
    repoService = _repository.updatePost(createPostRequestOb, postOb.value?.id);
    callAPIService(repoService, onSuccess: (dynamic response) {
      if (response != null) {
        Get.back();
        BaseApiResponse<String?> _baseApiResponse = response;
        Get.offAllNamed(Paths.MAIN_HOME);
        AppUtils.showToast(" ${_baseApiResponse.message}");
      }
    }, onError: (Exception exception) {
      Get.back();
      AppUtils.showToast(errorMessage);
    });
  }
}
