import 'package:blog_post_flutter/app/data/model/post/post_ob.dart';
import 'package:blog_post_flutter/app/data/model/post/post_request_ob.dart';
import 'package:blog_post_flutter/app/data/network/base_response/base_api_response.dart';

abstract class PostRepository {
  //Get Post List
  Future<BaseApiResponse<PostListOb>> getPostList({int? page,String? searchText});

  //Get Save Post List
  Future<BaseApiResponse<PostListOb>> getSavePostList({int? page});

  //Get Post Detail
  Future<BaseApiResponse<PostData>> getPostDetail(postId);

  //Create Post
  Future<BaseApiResponse<String?>> createPost(
      CreatePostRequestOb createPostRequestOb);

  //Update Post
  Future<BaseApiResponse<String?>> updatePost(
      CreatePostRequestOb createPostRequestOb,postId);

  //Like Post
  Future<BaseApiResponse<String?>> toggleLikePost(postId);

  //Save Post
  Future<BaseApiResponse<String?>> toggleSavePost(postId);
}
