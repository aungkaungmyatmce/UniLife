import 'package:blog_post_flutter/app/data/model/post/comment_ob.dart';
import 'package:blog_post_flutter/app/data/model/post/post_ob.dart';
import 'package:blog_post_flutter/app/data/model/post/post_request_ob.dart';
import 'package:blog_post_flutter/app/data/network/base_response/base_api_response.dart';

import '../../model/authentication/profile_ob.dart';
import '../../model/post/comment_request_ob.dart';

abstract class PostRepository {
  //Get Post List
  Future<BaseApiResponse<PostListOb>> getPostList(
      {int? page, String? searchText});

  //Get Save Post List
  Future<BaseApiResponse<PostListOb>> getSavePostList({int? page});

  //Get Post Detail
  Future<BaseApiResponse<PostData>> getPostDetail(postId);

  //Create Post
  Future<BaseApiResponse<String?>> createPost(
      CreatePostRequestOb createPostRequestOb);

  //Update Post
  Future<BaseApiResponse<String?>> updatePost(
      CreatePostRequestOb createPostRequestOb, postId);

  //Like Post
  Future<BaseApiResponse<String?>> toggleLikePost(postId);

  //Save Post
  Future<BaseApiResponse<String?>> toggleSavePost(postId);

  //Delete Post
  Future<BaseApiResponse<String?>> deletePost(postId);

  //Get Profile
  Future<BaseApiResponse<ProfileOb>> getProfileDetail(profileId);

  //Get Comments
  Future<BaseApiResponse<CommentListOb>> getComments({int? page, int? postId});

  //Create Comment
  Future<BaseApiResponse<String?>> createComment(
      CreateCommentRequestOb createCommentRequestOb);

  //Update Comment
  Future<BaseApiResponse<String?>> updateComment(
      {int commentId, String comment});

  //Delete Comment
  Future<BaseApiResponse<String?>> deleteComment({int commentId});
}
