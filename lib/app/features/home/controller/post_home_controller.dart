import 'dart:convert';

import 'package:blog_post_flutter/app/constant/routing/app_routes.dart';
import 'package:blog_post_flutter/app/constant/view_state.dart';
import 'package:blog_post_flutter/app/core/base/base_controller.dart';
import 'package:blog_post_flutter/app/core/utils/app_utils.dart';
import 'package:blog_post_flutter/app/core/utils/pagination_utils.dart';
import 'package:blog_post_flutter/app/data/model/post/post_ob.dart';
import 'package:blog_post_flutter/app/data/network/base_response/base_api_response.dart';
import 'package:blog_post_flutter/app/data/repository/post/post_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PostHomeController extends BaseController {
  final PostRepository _repository = Get.find(tag: (PostRepository).toString());

  final RxList<PostData> _postList = RxList.empty();
  Rx<TextEditingController> searchTextEditingController =
      TextEditingController().obs;
  RxBool isSearch = false.obs;
  RxBool isFavourite = false.obs;

  List<PostData> get postList => _postList;

  late PaginationUtils postPagination = PaginationUtils();

  @override
  void onInit() {
    super.onInit();
    getPostList();
  }

  void toggleSearch() {
    isSearch.value = !isSearch.value;
  }

  //Search Post
  void searchPostList({
    RefreshController? refreshController,
  }) {
    resetAndGetPostList(
      refreshController: refreshController,
    );
  }

  //Fetch Post List

  void resetAndGetPostList({
    RefreshController? refreshController,
  }) {
    _postList.clear();
    postPagination = PaginationUtils();
    getPostList(
      refreshController: refreshController,
    );
  }

  void getPostList({
    RefreshController? refreshController,
  }) async {
    setRefreshController(refreshController);
    if (postPagination.isPageAvailable()) {
      final repoService = _repository.getPostList(
          page: postPagination.currentPage,
          searchText: searchTextEditingController.value.text);

      await callAPIService(
        repoService,
        onStart: _postList.isEmpty ? () => showLoading() : null,
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
            searchTextEditingController.value.clear();
            resetAndGetPostList();
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
        onClickTryAgain: () => resetAndGetPostList(),
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

  void savePost(bool isSave){
    isFavourite.value = !isSave;
  }
}
