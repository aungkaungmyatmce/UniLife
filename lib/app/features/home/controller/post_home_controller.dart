import 'package:blog_post_flutter/app/constant/routing/app_routes.dart';
import 'package:blog_post_flutter/app/constant/view_state.dart';
import 'package:blog_post_flutter/app/core/base/base_controller.dart';
import 'package:blog_post_flutter/app/core/utils/app_utils.dart';
import 'package:blog_post_flutter/app/core/utils/pagination_utils.dart';
import 'package:blog_post_flutter/app/data/model/post/post_ob.dart';
import 'package:blog_post_flutter/app/data/network/base_response/base_api_response.dart';
import 'package:blog_post_flutter/app/data/network/exception/base_exception.dart';
import 'package:blog_post_flutter/app/data/repository/post/post_repository.dart';
import 'package:get/get.dart';
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

  void _handlePostListResponseError(BaseException exception) {
    resetRefreshController(_postList);
    if (_postList.isEmpty) {
      updatePageState(
        ViewState.FAILED,
        onClickTryAgain: () => resetAndGetPostList(),
      );
    } else {
      AppUtils.showToast(exception.message);
    }
    return;
  }

  @override
  void clearAllData() {
    // TODO: implement clearAllData
    super.clearAllData();
  }

  void navigateToLoginScreen(){
    clearAllData();
    Get.offAllNamed(Paths.LOGIN);
  }
}
