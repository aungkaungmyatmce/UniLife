import 'package:blog_post_flutter/app/core/base/base_remote_source.dart';
import 'package:blog_post_flutter/app/data/model/post/post_detail_ob.dart';
import 'package:blog_post_flutter/app/data/model/post/post_ob.dart';
import 'package:blog_post_flutter/app/data/model/post/post_request_ob.dart';
import 'package:blog_post_flutter/app/data/network/base_response/base_api_response.dart';
import 'package:blog_post_flutter/app/data/network/services/dio_provider.dart';
import 'package:blog_post_flutter/app/data/repository/post/post_repository.dart';
import 'package:dio/dio.dart';

class PostRepositoryImpl extends BaseRemoteSource implements PostRepository {
  var endpoint = DioProvider.baseUrl;

  @override
  Future<BaseApiResponse<PostListOb>> getPostList({int? page}) {
    var dioCall = dioClient.get(
        "$endpoint/post/list/?page=$page");
    try {
      return callApiWithErrorParser(dioCall).then(
            (response) => _parsePostListResponse(response),
      );
    } catch (e) {
      rethrow;
    }
  }
  BaseApiResponse<PostListOb> _parsePostListResponse(
      Response response) {
    return BaseApiResponse<PostListOb>.fromObjectJson(response.data,
        createObject: (data) => PostListOb.fromJson(data));
  }

  @override
  Future<BaseApiResponse<PostDetailOb>> getPostDetail(postId) {
    var endpoint = "${DioProvider.baseUrl}/post/$postId/";

    var dioCall = dioClient.get(endpoint);
    try {
      return callApiWithErrorParser(dioCall)
          .then((response) => _parsePostDetailResponse(response));
    } catch (e) {
      rethrow;
    }
  }

  BaseApiResponse<PostDetailOb> _parsePostDetailResponse(
      Response response) {
    return BaseApiResponse<PostDetailOb>.fromObjectJson(response.data,
        createObject: (data) => PostDetailOb.fromJson(data));
  }

  @override
  Future<BaseApiResponse<String?>> createPost(
      CreatePostRequestOb postRequestOb) {
    try {
      return callApiWithErrorParser(dioClient.post(endpoint + "/post/create/",
          data: postRequestOb.toJson()))
          .then((response) => BaseApiResponse<String?>.fromStringJson(
        response.data,
      ));
    } catch (e) {
      rethrow;
    }
  }
}
