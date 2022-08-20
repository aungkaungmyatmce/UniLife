import 'package:blog_post_flutter/app/core/base/base_remote_source.dart';
import 'package:blog_post_flutter/app/data/model/authentication/profile_ob.dart';
import 'package:blog_post_flutter/app/data/model/post/comment_ob.dart';
import 'package:blog_post_flutter/app/data/model/post/comment_request_ob.dart';
import 'package:blog_post_flutter/app/data/model/post/post_ob.dart';
import 'package:blog_post_flutter/app/data/model/post/post_request_ob.dart';
import 'package:blog_post_flutter/app/data/network/base_response/base_api_response.dart';
import 'package:blog_post_flutter/app/data/network/services/dio_provider.dart';
import 'package:blog_post_flutter/app/data/repository/post/post_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

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
          .then((response) {
        print('Response Dataaaaaaaaa');
        print(response.data);
        return BaseApiResponse<String?>.fromStringJson(
          response.data,
        );
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<BaseApiResponse<String?>> updatePost(
      CreatePostRequestOb postRequestOb, postId) {
    try {
      return callApiWithErrorParser(dioClient.put(endpoint + "/posts/$postId/",
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

  @override
  Future<BaseApiResponse<String?>> deletePost(postId) {
    try {
      return callApiWithErrorParser(dioClient.delete(
        endpoint + "/posts/$postId/",
      )).then((response) => BaseApiResponse<String?>.fromStringJson(
            response.data,
          ));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<BaseApiResponse<ProfileOb>> getProfileDetail(profileId) {
    var endpoint = "${DioProvider.baseUrl}/accounts/$profileId/";

    var dioCall = dioClient.get(endpoint);
    try {
      return callApiWithErrorParser(dioCall)
          .then((response) => _parseProfileDetailResponse(response));
    } catch (e) {
      rethrow;
    }
  }

  BaseApiResponse<ProfileOb> _parseProfileDetailResponse(Response response) {
    return BaseApiResponse<ProfileOb>.fromObjectJson(response.data,
        createObject: (data) => ProfileOb.fromJson(data));
  }

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
}
