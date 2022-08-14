import 'package:blog_post_flutter/app/core/base/base_remote_source.dart';
import 'package:blog_post_flutter/app/data/model/post/post_ob.dart';
import 'package:blog_post_flutter/app/data/model/post/post_request_ob.dart';
import 'package:blog_post_flutter/app/data/network/base_response/base_api_response.dart';
import 'package:blog_post_flutter/app/data/network/services/dio_provider.dart';
import 'package:blog_post_flutter/app/data/repository/post/post_repository.dart';
import 'package:dio/dio.dart';

class PostRepositoryImpl extends BaseRemoteSource implements PostRepository {
  var endpoint = DioProvider.baseUrl;

  @override
  Future<BaseApiResponse<PostListOb>> getPostList(
      {int? page, String? searchText = ""}) {
    var dioCall = dioClient.get("$endpoint/posts/?q=$searchText&page=$page");
    try {
      return callApiWithErrorParser(dioCall).then(
        (response) => _parsePostListResponse(response),
      );
    } catch (e) {
      rethrow;
    }
  }

  BaseApiResponse<PostListOb> _parsePostListResponse(Response response) {
    return BaseApiResponse<PostListOb>.fromObjectJson(response.data,
        createObject: (data) => PostListOb.fromJson(data));
  }

  @override
  Future<BaseApiResponse<PostListOb>> getSavePostList({int? page}) {
    var dioCall = dioClient.get("$endpoint/posts/?saved&page=$page");
    try {
      return callApiWithErrorParser(dioCall).then(
        (response) => _parseSavePostListResponse(response),
      );
    } catch (e) {
      rethrow;
    }
  }

  BaseApiResponse<PostListOb> _parseSavePostListResponse(Response response) {
    return BaseApiResponse<PostListOb>.fromObjectJson(response.data,
        createObject: (data) => PostListOb.fromJson(data));
  }

  @override
  Future<BaseApiResponse<PostData>> getPostDetail(postId) {
    var endpoint = "${DioProvider.baseUrl}/posts/$postId/";

    var dioCall = dioClient.get(endpoint);
    try {
      return callApiWithErrorParser(dioCall)
          .then((response) => _parsePostDetailResponse(response));
    } catch (e) {
      rethrow;
    }
  }

  BaseApiResponse<PostData> _parsePostDetailResponse(Response response) {
    return BaseApiResponse<PostData>.fromObjectJson(response.data,
        createObject: (data) => PostData.fromJson(data));
  }

  @override
  Future<BaseApiResponse<String?>> createPost(
      CreatePostRequestOb postRequestOb) {
    try {
      return callApiWithErrorParser(dioClient.post(endpoint + "/posts/",
              data: postRequestOb.toJson()))
          .then((response) => BaseApiResponse<String?>.fromStringJson(
                response.data,
              ));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<BaseApiResponse<String?>> updatePost(
      CreatePostRequestOb postRequestOb, postId) {
    try {
      return callApiWithErrorParser(dioClient.put(
              endpoint + "/post/$postId/update/",
              data: postRequestOb.toJson()))
          .then((response) => BaseApiResponse<String?>.fromStringJson(
                response.data,
              ));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<BaseApiResponse<String?>> toggleLikePost(postId) {
    try {
      return callApiWithErrorParser(dioClient.post(
        endpoint + "/posts/$postId/like/",
      )).then((response) => BaseApiResponse<String?>.fromStringJson(
            response.data,
          ));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<BaseApiResponse<String?>> toggleSavePost(postId) {
    try {
      return callApiWithErrorParser(dioClient.post(
        endpoint + "/posts/$postId/save/",
      )).then((response) => BaseApiResponse<String?>.fromStringJson(
            response.data,
          ));
    } catch (e) {
      rethrow;
    }
  }
}
