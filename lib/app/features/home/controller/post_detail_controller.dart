import 'package:blog_post_flutter/app/constant/routing/app_routes.dart';
import 'package:blog_post_flutter/app/core/base/base_controller.dart';
import 'package:blog_post_flutter/app/core/utils/app_utils.dart';
import 'package:blog_post_flutter/app/core/utils/global_key_utils.dart';
import 'package:blog_post_flutter/app/core/utils/pagination_utils.dart';
import 'package:blog_post_flutter/app/data/model/post/post_ob.dart';
import 'package:blog_post_flutter/app/data/network/base_response/base_api_response.dart';
import 'package:blog_post_flutter/app/data/repository/post/post_repository.dart';
import 'package:blog_post_flutter/app/features/favourite/controller/favourite_controller.dart';
import 'package:blog_post_flutter/app/features/home/controller/post_create_controller.dart';
import 'package:get/get.dart';

import '../../../constant/enum_image_type.dart';
import '../../../core/utils/dialog_utils.dart';
import '../../../data/custom_image_phaser_ob.dart';

class PostDetailController extends BaseController {
  final PostRepository _repository = Get.find(tag: (PostRepository).toString());
  final CreatePostController postCreateController =
      Get.find<CreatePostController>();
  var postDetail = PostData().obs;
  late PaginationUtils postPagination = PaginationUtils();
  int? postId;

  @override
  void onInit() {
    super.onInit();
    postId = Get.arguments;
    if (postId != null) getPostDetail(postId!);
  }

  //Get Post Detail
  void getPostDetail(int _postId) async {
    postId = _postId;
    final repoService = _repository.getPostDetail(postId);

    await callAPIService(
      repoService,
      onSuccess: _handleResponseSuccess,
      onError: _handleResponseError,
    );
  }

  void _handleResponseSuccess(response) async {
    if (response != null) {
      BaseApiResponse<PostData?> _orderDetailData = response;
      PostData data = _orderDetailData.objectResult;
      postDetail.value = data;
    }
  }

  void _handleResponseError(Exception exception) {
    AppUtils.showToast(errorMessage);
  }

  //Toggle Like Post
  void toggleLikePost() {
    if (GlobalVariable.token != null) {
      late Future<BaseApiResponse<String?>> repoService;
      repoService = _repository.toggleLikePost(postDetail.value.id);
      callAPIService(repoService, onSuccess: (dynamic response) {
        if (response != null) {
          BaseApiResponse<String?> _baseApiResponse = response;
          getPostDetail(postId!);
          AppUtils.showToast(" ${_baseApiResponse.message}");
        }
      }, onError: (Exception exception) {
        AppUtils.showToast(errorMessage);
      });
    } else {
      Get.toNamed(Paths.LOGIN);
    }
  }

  //Toggle Like Post
  void toggleSavePost() {
    if (GlobalVariable.token != null) {
      late Future<BaseApiResponse<String?>> repoService;
      repoService = _repository.toggleSavePost(postDetail.value.id);
      callAPIService(repoService, onSuccess: (dynamic response) {
        if (response != null) {
          BaseApiResponse<String?> _baseApiResponse = response;
          getPostDetail(postId!);
          AppUtils.showToast(" ${_baseApiResponse.message}");
        }
      }, onError: (Exception exception) {
        AppUtils.showToast(errorMessage);
      });
    } else {
      Get.toNamed(Paths.LOGIN);
    }
  }

  void editPost() {
    postCreateController.titleController.text = postDetail.value.title!;
    postCreateController.descriptionController.text = postDetail.value.content!;
    if (postDetail.value.image != null) {
      // CustomImagePhaserOb customImagePhaserOb = CustomImagePhaserOb();
      // customImagePhaserOb.image = postDetail.value.image;
      // customImagePhaserOb.type = ImageType.networkImage;
      postCreateController.postImage.value = CustomImagePhaserOb(
          image: postDetail.value.image, type: ImageType.networkImage);
    }
    postCreateController.postId = postDetail.value.id!;
    Get.back();
    Get.toNamed(Paths.POST_CREATE)?.then((value) async {
      postCreateController.titleController.clear();
      postCreateController.descriptionController.clear();
    });
  }

  void confirmDelete() {
    Get.back();
    DialogUtils.showPromptDialog(
        okBtnFunction: deletePost,
        content: 'Are you Sure to delete this post ?');
  }

  void deletePost() {
    late Future<BaseApiResponse<String?>> repoService;
    Get.back();
    AppUtils.showLoaderDialog();

    repoService = _repository.deletePost(postId);

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
