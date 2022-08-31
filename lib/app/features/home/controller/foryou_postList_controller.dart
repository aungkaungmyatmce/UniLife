import 'package:blog_post_flutter/app/core/base/base_controller.dart';
import 'package:blog_post_flutter/app/core/utils/shimmer_utils.dart';
import 'package:blog_post_flutter/app/data/network/services/dio_provider.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../constant/routing/app_routes.dart';
import '../../../constant/view_state.dart';
import '../../../core/utils/app_utils.dart';
import '../../../core/utils/pagination_utils.dart';
import '../../../data/model/post/post_ob.dart';
import '../../../data/network/base_response/base_api_response.dart';
import '../../../data/repository/post/post_repository.dart';
import 'package:get/get.dart';

class ForYouPostListController extends BaseController {
  final PostRepository _repository = Get.find(tag: (PostRepository).toString());

  final RxList<PostData> _postList = RxList.empty();

  List<PostData> get postList => _postList;

  late PaginationUtils postPagination = PaginationUtils();

  @override
  void onInit() {
    super.onInit();
    resetAndGetPostList(isFollowing: false);
  }

  void navigateToSearchScreen() {
    Get.toNamed(Paths.SEARCH);
  }

  //Search Post
  void searchPostList({
    RefreshController? refreshController,
    required bool isFollowing,
  }) {
    resetAndGetPostList(
      refreshController: refreshController,
      isFollowing: isFollowing,
    );
  }

  void resetAndGetPostList({
    RefreshController? refreshController,
    required bool isFollowing,
  }) {
    _postList.clear();
    postPagination = PaginationUtils();
    getPostList(
      refreshController: refreshController,
      isFollowing: isFollowing,
    );
  }

  void getPostList({
    RefreshController? refreshController,
    required bool isFollowing,
  }) async {
    setRefreshController(refreshController);

    if (postPagination.isPageAvailable()) {
      final repoService = _repository.getPostList(
          page: postPagination.currentPage, isFollowing: false);

      await callAPIService(
        repoService,
        // onStart: _postList.isEmpty
        //     ? () => showLoading(shimmerEffect: ShimmerUtils.postList)
        //     : () => Container(),
        onSuccess: _handlePostListResponseSuccess,
        onError: _handleAllListResponseError,
      );
    }
  }

  void _handlePostListResponseSuccess(response) async {
    resetRefreshController(_postList);
    if (response != null) {
      BaseApiResponse<PostListOb> _postData = response;
      PostListOb data = _postData.objectResult;
      _postList.addAll(data.data!.toList());

      if (data.data!.isEmpty) {
        Future.delayed(const Duration(microseconds: 500), () {
          _postList.clear();
          updatePageState(ViewState.EMPTYLIST, onClickTryAgain: () {
            resetAndGetPostList(isFollowing: false);
          });
        });
      }
      postPagination.setCurrentPage(
        totalPage: data.pagination?.totalPages,
      );
    }
  }

  void _handleAllListResponseError(Exception exception) {
    resetRefreshController(_postList);
    if (_postList.isEmpty) {
      updatePageState(
        ViewState.FAILED,
        onClickTryAgain: () => resetAndGetPostList(isFollowing: false),
      );
    } else {
      AppUtils.showToast(errorMessage);
    }
    return;
  }

  @override
  void clearAllData() {
    // TODO: implement clearAllData
    super.clearAllData();
  }

  void navigateToLoginScreen() {
    clearAllData();
    Get.offAllNamed(Paths.LOGIN);
  }

  void navigateToDetailScreen(PostData postDetail) {
    Get.toNamed(Paths.POST_DETAIL, arguments: postDetail);
  }
}
