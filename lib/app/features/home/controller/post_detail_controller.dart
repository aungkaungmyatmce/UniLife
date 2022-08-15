import 'package:blog_post_flutter/app/constant/routing/app_routes.dart';
import 'package:blog_post_flutter/app/core/base/base_controller.dart';
import 'package:blog_post_flutter/app/core/utils/app_utils.dart';
import 'package:blog_post_flutter/app/core/utils/global_key_utils.dart';
import 'package:blog_post_flutter/app/core/utils/pagination_utils.dart';
import 'package:blog_post_flutter/app/data/model/post/post_ob.dart';
import 'package:blog_post_flutter/app/data/network/base_response/base_api_response.dart';
import 'package:blog_post_flutter/app/data/repository/post/post_repository.dart';
import 'package:blog_post_flutter/app/features/favourite/controller/favourite_controller.dart';
import 'package:get/get.dart';

class PostDetailController extends BaseController {
  final PostRepository _repository = Get.find(tag: (PostRepository).toString());
  var postDetail = PostData().obs;
  late PaginationUtils postPagination = PaginationUtils();
  RxInt likeCount = 0.obs;
  RxBool isLikeAdded = false.obs;
  RxBool isSaved = false.obs;
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
      likeCount.value = postDetail.value.likeCounts!;
      if (postDetail.value.isLiked == true) {
        isLikeAdded.value = true;
      } else {
        isLikeAdded.value = false;
      }
      if (postDetail.value.isSaved == true) {
        isSaved.value = true;
      } else {
        isSaved.value = false;
      }
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
          //AppUtils.showToast(" ${_baseApiResponse.message}");
        }
      }, onError: (Exception exception) {
        AppUtils.showToast(errorMessage);
      });
    } else {
      Get.toNamed(Paths.LOGIN);
    }
  }

  void addLikeCount(int i, bool isLike) {
    if (isLike) {
      likeCount.value = i - 1;
      isLikeAdded.value = false;
    } else {
      likeCount.value = i + 1;
      isLikeAdded.value = true;
    }
  }

  void removeLikeCount() {
    likeCount.value = likeCount.value - 1;
    isLikeAdded.value = false;
  }

  //Toggle Save Post
  void toggleSavePost() {
    if (GlobalVariable.token != null) {
      late Future<BaseApiResponse<String?>> repoService;
      repoService = _repository.toggleSavePost(postDetail.value.id);
      callAPIService(repoService, onSuccess: (dynamic response) {
        if (response != null) {
          BaseApiResponse<String?> _baseApiResponse = response;
          AppUtils.showToast(" ${_baseApiResponse.message}");
        }
      }, onError: (Exception exception) {
        AppUtils.showToast(errorMessage);
      });
    } else {
      Get.toNamed(Paths.LOGIN);
    }
  }
}
