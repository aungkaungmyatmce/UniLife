import 'package:blog_post_flutter/app/constant/view_state.dart';
import 'package:blog_post_flutter/app/core/base/base_controller.dart';
import 'package:blog_post_flutter/app/core/utils/app_utils.dart';
import 'package:blog_post_flutter/app/core/utils/pagination_utils.dart';
import 'package:blog_post_flutter/app/core/utils/shimmer_utils.dart';
import 'package:blog_post_flutter/app/data/model/post/post_ob.dart';
import 'package:blog_post_flutter/app/data/network/base_response/base_api_response.dart';
import 'package:blog_post_flutter/app/data/repository/post/post_repository.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class FavouriteController extends BaseController {
  final PostRepository _repository = Get.find(tag: (PostRepository).toString());

  final RefreshController refreshController =
      RefreshController(initialRefresh: false);
  final RxList<PostData> _savePostList = RxList.empty();

  List<PostData> get savePostList => _savePostList;

  late PaginationUtils postPagination = PaginationUtils();

  @override
  void onInit() {
    super.onInit();
    getSavePostList();
  }

  //Fetch Save Post List

  Future<void> resetAndGetSavePostList({
    RefreshController? refreshController,
  }) async {
    _savePostList.clear();
    postPagination = PaginationUtils();
    getSavePostList(
      refreshController: refreshController,
    );
  }

  void getSavePostList({
    RefreshController? refreshController,
  }) async {
    setRefreshController(refreshController);
    if (postPagination.isPageAvailable()) {
      final repoService = _repository.getSavePostList(
        page: postPagination.currentPage,
      );

      await callAPIService(
        repoService,
        onStart: _savePostList.isEmpty
            ? () => showLoading(shimmerEffect: ShimmerUtils.bookMark)
            : () => null,
        onSuccess: _handleSavePostListResponseSuccess,
        onError: _handleSavePostListResponseError,
      );
    }
  }

  void _handleSavePostListResponseSuccess(response) async {
    resetRefreshController(_savePostList);
    if (response != null) {
      BaseApiResponse<PostListOb> _postData = response;
      PostListOb data = _postData.objectResult;

      _savePostList.addAll(data.data!.toList());
      if (data.data!.isEmpty) {
        Future.delayed(
          const Duration(milliseconds: 100),
          () => updatePageState(ViewState.EMPTYLIST,
              onClickTryAgain: () => {
                    resetAndGetSavePostList(),
                  },
              message: 'You have no bookmark!'),
        );
      }
      postPagination.setCurrentPage(
        totalPage: data.pagination?.totalPages,
      );
    }
  }

  void _handleSavePostListResponseError(Exception exception) {
    AppUtils.showToast(errorMessage);
  }
}
