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

  final RefreshController refreshController =
      RefreshController(initialRefresh: false);
  final RxList<PostData> _postList = RxList.empty();

  List<PostData> get postList => _postList;

  late PaginationUtils postPagination = PaginationUtils();

  @override
  void onInit() {
    super.onInit();
    getPostList();
  }

  //Fetch Post List

  Future<void> resetAndGetPostList({
    RefreshController? refreshController,
  }) async {
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
      );

      await callAPIService(
        repoService,
        //onStart: _postList.isEmpty ? showLoading : null,
        onSuccess: _handlePostListResponseSuccess,
        onError: _handlePostListResponseError,
      );
    }
  }

  void _handlePostListResponseSuccess(response) async {
    resetRefreshController(_postList);
    if (response != null) {
      BaseApiResponse<PostListOb> _orderData = response;
      PostListOb data = _orderData.objectResult;
      _postList.addAll(data.data!.toList());
      if (data.data!.isEmpty) {
        Future.delayed(
          const Duration(seconds: 1),
          () => updatePageState(ViewState.EMPTYLIST,
              onClickTryAgain: () => {
                    resetAndGetPostList(),
                  }),
        );
      }
      postPagination.setCurrentPage(
        totalPage: data.pagination?.totalPages,
      );
    }
  }

  void _handlePostListResponseError(Exception exception) {
    AppUtils.showToast(errorMessage);
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

  //GetX pagination
  // We will fetch data from this Rest api
  final _baseUrl = 'https://jsonplaceholder.typicode.com/posts';

  // At the beginning, we fetch the first 20 posts
  RxInt page = 0.obs;
  RxInt limit = 10.obs;

  // There is next page or not
  RxBool hasNextPage = true.obs;

  // Used to display loading indicators when _firstLoad function is running
  RxBool isFirstLoadRunning = false.obs;

  // Used to display loading indicators when _loadMore function is running
  RxBool isLoadMoreRunning = false.obs;

  // This holds the posts fetched from the server
  RxList posts = [].obs;

  // The controller for the ListView
  final Rx<ScrollController> scrollController = ScrollController().obs;

  // This function will be called when the app launches (see the initState function)
  void firstLoad() async {
    isFirstLoadRunning.value = true;
    try {
      final res = await http.get(
          Uri.parse("$_baseUrl?_page=${page.value}&_limit=${limit.value}"));
      posts.value = json.decode(res.body);
      print("Post is ${posts.length}");
    } catch (err) {
      print('Something went wrong');
    }
    isFirstLoadRunning.value = false;
  }

  void loadMore() async {
    if (hasNextPage.value == true &&
        isFirstLoadRunning.value == false &&
        isLoadMoreRunning.value == false &&
        scrollController.value.position.extentAfter < 300) {
      isLoadMoreRunning.value =
          true; // Display a progress indicator at the bottom
      page.value += 1; // Increase _page by 1
      try {
        final res = await http.get(
            Uri.parse("$_baseUrl?_page=${page.value}&_limit=${limit.value}"));

        final List fetchedPosts = json.decode(res.body);
        if (fetchedPosts.isNotEmpty) {
          posts.addAll(fetchedPosts);
        } else {
          // This means there is no more data
          // and therefore, we will not send another GET request
          hasNextPage.value = false;
        }
      } catch (err) {
        print('Something went wrong!');
      }
      isLoadMoreRunning.value = false;
    }
  }
}
