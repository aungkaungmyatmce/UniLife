import 'dart:convert';
import 'package:blog_post_flutter/app/core/utils/date_utils.dart';
import 'package:blog_post_flutter/app/core/utils/dialog_utils.dart';
import 'package:blog_post_flutter/app/core/utils/shimmer_utils.dart';
import 'package:blog_post_flutter/app/data/repository/comment/comment_repository.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../constant/routing/app_routes.dart';
import '../../../constant/view_state.dart';
import '../../../core/base/base_controller.dart';
import '../../../core/utils/app_utils.dart';
import '../../../core/utils/pagination_utils.dart';
import '../../../data/local/cache_manager.dart';
import '../../../data/model/authentication/login_response.dart';
import '../../../data/model/authentication/profile_ob.dart';
import '../../../data/model/post/comment_ob.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../data/model/post/comment_request_ob.dart';
import '../../../data/network/base_response/base_api_response.dart';

class CommentController extends BaseController {
  final CommentRepository _repository =
      Get.find(tag: (CommentRepository).toString());
  CreateCommentRequestOb createCommentRequestOb = CreateCommentRequestOb();

  late final RxList<CommentData> _commentList = RxList.empty();
  int postId = 0;
  var commentString = ''.obs;
  TextEditingController commentController = TextEditingController();
  List<CommentData> get commentList => _commentList;
  set commentList(List<CommentData> data) => _commentList.value = data;
  Rx<LoginResponse> loginResponse = LoginResponse().obs;
  Rx<bool> isLogin = false.obs;

  late PaginationUtils commentPagination = PaginationUtils();

  @override
  void onInit() {
    if (getString(CacheManagerKey.loginResponseData) != null) {
      Map<String, dynamic> authenticationResponse =
          jsonDecode(getString(CacheManagerKey.loginResponseData)!);
      loginResponse.value = LoginResponse.fromJson(authenticationResponse);
      if (loginResponse.value.user!.id != null) {
        isLogin.value = true;
      } else {
        isLogin.value = false;
      }
    }
    postId = Get.arguments['postId'];
    if (Get.arguments['commentList'].isNotEmpty) {
      _commentList.value = Get.arguments['commentList'];
    } else {
      resetAndGetCommentList();
    }
    super.onInit();
  }

  void createComment() {
    if (commentController.text.isEmpty) {
      AppUtils.showToast("Please Enter comment");
      return;
    }

    putVirtualObj();
    createCommentRequestOb.comment = commentController.text;
    createCommentRequestOb.post = postId;
    commentController.clear();
    commentString.value = '';
    late Future<BaseApiResponse<String?>> repoService;
    print("Create Comment is ${createCommentRequestOb.toJson()}");

    //AppUtils.showLoaderDialog();

    repoService = _repository.createComment(createCommentRequestOb);

    callAPIService(repoService, onSuccess: (dynamic response) {
      if (response != null) {
        //Get.back();
        BaseApiResponse<String?> _baseApiResponse = response;
        resetAndGetCommentList();
        AppUtils.showToast(" ${_baseApiResponse.message}");
      }
    }, onError: (Exception exception) {
      Get.back();
      AppUtils.showToast(errorMessage);
    });
  }

  void resetAndGetCommentList({
    RefreshController? refreshController,
  }) {
    _commentList.clear();
    commentPagination = PaginationUtils();
    getCommentList(
      refreshController: refreshController,
    );
  }

  void getCommentList({
    RefreshController? refreshController,
  }) async {
    setRefreshController(refreshController);
    if (commentPagination.isPageAvailable()) {
      final repoService = _repository.getComments(
          page: commentPagination.currentPage, postId: postId);

      await callAPIService(
        repoService,
        onStart: _commentList.isEmpty ? () => showLoading() : null,
        onSuccess: _handlePostListResponseSuccess,
        onError: _handleAllListResponseError,
      );
    }
  }

  void _handlePostListResponseSuccess(response) async {
    resetRefreshController(_commentList);
    if (response != null) {
      BaseApiResponse<CommentListOb> _commentData = response;
      CommentListOb data = _commentData.objectResult;
      _commentList.addAll(data.data!.toList());

      if (data.data!.isEmpty) {
        Future.delayed(const Duration(microseconds: 500), () {
          _commentList.clear();
          updatePageState(ViewState.EMPTYLIST, message: 'No comments here!');
        });
      }
      commentPagination.setCurrentPage(
        totalPage: data.pagination?.totalPages,
      );
    }
  }

  void _handleAllListResponseError(Exception exception) {
    resetRefreshController(_commentList);
    if (_commentList.isEmpty) {
      updatePageState(
        ViewState.FAILED,
        onClickTryAgain: () => resetAndGetCommentList(),
      );
    } else {
      AppUtils.showToast(errorMessage);
    }
    return;
  }

  void deleteComment({required int commentId}) {
    Get.back();
    DialogUtils.showPromptDialog(
        okBtnFunction: () {
          Get.back();
          late Future<BaseApiResponse<String?>> repoService;
          AppUtils.showLoaderDialog();
          repoService = _repository.deleteComment(commentId: commentId);

          callAPIService(repoService, onSuccess: (dynamic response) {
            if (response != null) {
              Get.back();
              BaseApiResponse<String?> _baseApiResponse = response;
              resetAndGetCommentList();
              AppUtils.showToast(" ${_baseApiResponse.message}");
            }
          }, onError: (Exception exception) {
            Get.back();
            AppUtils.showToast(errorMessage);
          });
        },
        content: 'Are you sure to delete comment?');
  }

  void showBottomSheet(CommentData cmtData) {
    if (cmtData.isOwner == true) {
      DialogUtils.showEditAndDeleteBottomSheet(
          cmtData: cmtData,
          onEdit: () {
            Get.back();
            Get.toNamed(Paths.COMMENT_EDIT, arguments: cmtData)?.then((result) {
              if (result == "updated") {
                resetAndGetCommentList();
              }
            });
          },
          onDelete: () {
            deleteComment(commentId: cmtData.id!);
          });
    }
  }

  void putVirtualObj() {
    Owner? owner = Owner(firstName: 'You', lastName: '');

    CommentData cmt = CommentData(
      comment: commentController.text,
      isOwner: false,
      owner: owner,
    );
    _commentList.insert(0, cmt);
  }
}
