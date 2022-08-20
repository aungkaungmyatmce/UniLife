import 'package:blog_post_flutter/app/data/model/authentication/profile_ob.dart';

import '../pagination/pagination_ob.dart';

// "id": 1,
// "comment": "CommentA",
// "owner": {
// "id": 5,
// "username": "aungkaungmyat",
// "first_name": "Aung kaung",
// "last_name": "Myat",
// "university": "MTU",
// "profile_picture": "https://pyaephyokyaw.pythonanywhere.com/media/profile_pictures/0af055db-3012-4aaf-8971-d2de788e104b.jpg",
// "self_profile": false
// },
// "created_date": "2022-08-17T14:49:27.370793Z",
// "post": 30,
// "url": "https://pyaephyokyaw.pythonanywhere.com/api/v2/comments/1/",
// "is_owner": false

class CommentData {
  int? id;
  String? comment;
  Owner? owner;
  String? createdDate;
  int? post;
  String? url;
  bool? isOwner;

  CommentData({
    this.id,
    this.comment,
    this.owner,
    this.createdDate,
    this.post,
    this.url,
    this.isOwner,
  });

  CommentData.fromJson(dynamic json) {
    id = json['id'];
    comment = json['comment'];
    owner = json['owner'] != null ? Owner.fromJson(json['owner']) : null;
    createdDate = json['created_date'];
    post = json['post'];
    url = json['url'];
    isOwner = json['is_owner'];
  }

  Map<String, dynamic> toJson(CommentData cmtData) {
    final map = <String, dynamic>{};
    map['id'] = cmtData.id;
    if (owner != null) {
      map['owner'] = cmtData.owner?.toJson();
    }
    map['comment'] = cmtData.comment;
    map['created_date'] = cmtData.createdDate;
    map['post'] = cmtData.post;
    map['url'] = cmtData.url;
    map['is_owner'] = cmtData.isOwner;
    return map;
  }
}

class CommentListOb {
  CommentListOb({
    this.data,
    this.pagination,
  });

  CommentListOb.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(CommentData.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
  }
  List<CommentData>? data;
  Pagination? pagination;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson).toList();
    }
    if (pagination != null) {
      map['pagination'] = pagination?.toJson();
    }
    return map;
  }
}
