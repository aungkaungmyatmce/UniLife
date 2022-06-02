import 'package:blog_post_flutter/app/core/base/base_controller.dart';
import 'package:blog_post_flutter/app/core/utils/app_utils.dart';
import 'package:blog_post_flutter/app/core/utils/pagination_utils.dart';
import 'package:blog_post_flutter/app/data/model/post/post_ob.dart';
import 'package:blog_post_flutter/app/data/network/base_response/base_api_response.dart';
import 'package:blog_post_flutter/app/data/repository/post/post_repository.dart';
import 'package:get/get.dart';

class PostDetailController extends BaseController {
  final PostRepository _repository = Get.find(tag: (PostRepository).toString());
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
  }

  //Toggle Like Post
  void toggleSavePost() {
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
  }
}
