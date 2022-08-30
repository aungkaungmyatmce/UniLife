import 'package:blog_post_flutter/app/core/base/base_controller.dart';
import 'package:blog_post_flutter/app/data/model/post/comment_ob.dart';
import 'package:blog_post_flutter/app/data/repository/comment/comment_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/app_utils.dart';
import '../../../data/network/base_response/base_api_response.dart';
import '../../../data/repository/post/post_repository.dart';

class CommentEditController extends BaseController {
  final CommentRepository _repository =
      Get.find(tag: (CommentRepository).toString());
  TextEditingController commentEditController = TextEditingController();
  int commentId = 0;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    CommentData comment = Get.arguments;
    print(comment);
    if (comment != null) {
      commentEditController.text = comment.comment!;
      commentId = comment.id!;
    }
  }

  void onTapCancel() {
    Get.back();
  }

  void onTapUpdate() {
    if (commentEditController.text.isEmpty) {
      AppUtils.showToast("Please Enter comment");
      return;
    }

    late Future<BaseApiResponse<String?>> repoService;

    AppUtils.showLoaderDialog();

    repoService = _repository.updateComment(
        commentId: commentId, comment: commentEditController.text);

    callAPIService(repoService, onSuccess: (dynamic response) {
      if (response != null) {
        Get.back();
        BaseApiResponse<String?> _baseApiResponse = response;
        Get.back(result: "updated");
        AppUtils.showToast(" ${_baseApiResponse.message}");
      }
    }, onError: (Exception exception) {
      Get.back();
      AppUtils.showToast(errorMessage);
    });
  }
}
