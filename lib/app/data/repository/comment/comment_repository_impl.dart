import 'package:blog_post_flutter/app/core/base/base_remote_source.dart';
import 'package:blog_post_flutter/app/data/model/post/comment_request_ob.dart';
import '../../model/post/comment_ob.dart';
import '../../network/base_response/base_api_response.dart';
import '../../network/services/dio_provider.dart';
import 'comment_repository.dart';
import 'package:dio/dio.dart';

class CommentRepositoryImpl extends BaseRemoteSource
    implements CommentRepository {
  var endpoint = DioProvider.baseUrl;

  @override
  Future<BaseApiResponse<String?>> createComment(
      CreateCommentRequestOb commentRequestOb) {
    try {
      return callApiWithErrorParser(dioClient.post(endpoint + "/comments/",
              data: commentRequestOb.toJson()))
          .then((response) {
        return BaseApiResponse<String?>.fromStringJson(
          response.data,
        );
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<BaseApiResponse<CommentListOb>> getComments({int? page, int? postId}) {
    var endpoint =
        "${DioProvider.baseUrl}/comments/?post_id=$postId&page=$page";

    var dioCall = dioClient.get(endpoint);
    try {
      return callApiWithErrorParser(dioCall)
          .then((response) => _parseCommentListResponse(response));
    } catch (e) {
      rethrow;
    }
  }

  // BaseApiResponse<List<CommentData>> _parseCommentListResponse(
  //     Response response) {
  //   return BaseApiResponse<List<CommentData>>.fromListJson(response.data,
  //       createList: (data) {
  //     return CommentData.fromJson(data);
  //   });
  // }

  BaseApiResponse<CommentListOb> _parseCommentListResponse(Response response) {
    return BaseApiResponse<CommentListOb>.fromObjectJson(response.data,
        createObject: (data) => CommentListOb.fromJson(data));
  }

  @override
  Future<BaseApiResponse<String?>> updateComment(
      {int? commentId, String? comment}) {
    try {
      return callApiWithErrorParser(dioClient.patch(
          endpoint + "/comments/$commentId/",
          data: {'comment': comment})).then((response) {
        return BaseApiResponse<String?>.fromStringJson(
          response.data,
        );
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<BaseApiResponse<String?>> deleteComment({int? commentId}) {
    try {
      return callApiWithErrorParser(
              dioClient.delete(endpoint + "/comments/$commentId/"))
          .then((response) {
        return BaseApiResponse<String?>.fromStringJson(
          response.data,
        );
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<BaseApiResponse<String?>> followUser({int? userId}) {
    try {
      return callApiWithErrorParser(dioClient.post(
        endpoint + "/accounts/$userId/follow/",
      )).then((response) {
        return BaseApiResponse<String?>.fromStringJson(
          response.data,
        );
      });
    } catch (e) {
      rethrow;
    }
  }
}
