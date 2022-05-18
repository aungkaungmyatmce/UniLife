import 'package:blog_post_flutter/app/data/model/post/post_detail_ob.dart';
import 'package:blog_post_flutter/app/data/model/post/post_ob.dart';
import 'package:blog_post_flutter/app/data/model/post/post_request_ob.dart';
import 'package:blog_post_flutter/app/data/network/base_response/base_api_response.dart';

abstract class PostRepository {
  //Get Post List
  Future<BaseApiResponse<PostListOb>> getPostList({int? page});

  //Get Post Detail
  Future<BaseApiResponse<PostDetailOb>> getPostDetail(postId);

  //Create Post
  Future<BaseApiResponse<String?>> createPost(CreatePostRequestOb createPostRequestOb);
}