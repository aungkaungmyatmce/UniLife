import 'package:blog_post_flutter/app/core/base/base_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../constant/routing/app_routes.dart';
import '../../../constant/view_state.dart';
import '../../../core/utils/app_utils.dart';
import '../../../core/utils/pagination_utils.dart';
import '../../../data/model/post/post_ob.dart';
import '../../../data/network/base_response/base_api_response.dart';
import '../../../data/repository/post/post_repository.dart';

class SearchController extends BaseController {
  final PostRepository _repository = Get.find(tag: (PostRepository).toString());
  Rx<TextEditingController> searchTextEditingController =
      TextEditingController().obs;
  late final RxList<PostData> _postList = RxList.empty();
  List<PostData> get postList => _postList;
  late PaginationUtils postPagination = PaginationUtils();
  RxBool isSearching = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  //Search Post
  void searchPostList({
    RefreshController? refreshController,
  }) {
    if (searchTextEditingController.value.text.isEmpty) {
      _postList.clear();
    } else {
      resetAndGetPostList(
        refreshController: refreshController,
      );
    }
  }

  //Fetch Post List

  void resetAndGetPostList({
    RefreshController? refreshController,
  }) {
    _postList.clear();
    postPagination = PaginationUtils();
    updatePageState(
      ViewState.DEFAULT,
    );
    getPostList(
      refreshController: refreshController,
    );
  }

  void getPostList({
    RefreshController? refreshController,
  }) async {
    if (postPagination.isPageAvailable()) {
      final repoService = _repository.getPostList(
        page: postPagination.currentPage,
        searchText: searchTextEditingController.value.text,
        isFollowing: false,
      );

      await callAPIService(
        repoService,
        onStart: _postList.isEmpty
            ? () => isSearching.value = true
            : () => isSearching.value = false,
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
      isSearching.value = false;
      if (searchTextEditingController.value.text.isNotEmpty) {
        _postList.addAll(data.data!.toList());
      }

      if (data.data!.isEmpty) {
        Future.delayed(const Duration(microseconds: 500), () {
          _postList.clear();
          updatePageState(ViewState.EMPTYLIST, onClickTryAgain: () {
            searchTextEditingController.value.clear();
            resetAndGetPostList();
          });
        });
      }
      print('_postList.length');
      print(_postList.length);
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
        onClickTryAgain: () => resetAndGetPostList(),
      );
    } else {
      AppUtils.showToast(errorMessage);
    }
    return;
  }

  void navigateToDetailScreen(PostData postDetail) {
    Get.toNamed(Paths.POST_DETAIL, arguments: postDetail);
  }
}
