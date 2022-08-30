import 'package:blog_post_flutter/app/data/model/post/comment_ob.dart';
import 'package:blog_post_flutter/app/data/model/post/post_ob.dart';
import 'package:blog_post_flutter/app/data/model/post/post_request_ob.dart';
import 'package:blog_post_flutter/app/data/network/base_response/base_api_response.dart';

import '../../model/authentication/profile_ob.dart';
import '../../model/post/comment_request_ob.dart';

abstract class CommentRepository {
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

  //Follow a User
  Future<BaseApiResponse<String?>> followUser({int userId});
}
