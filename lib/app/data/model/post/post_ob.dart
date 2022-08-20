import 'package:blog_post_flutter/app/data/model/post/comment_ob.dart';

/// data : [{"id":11,"owner":{"id":1,"username":"pyaephyokyaw15","first_name":"UPdated","last_name":"UPdate","university":"Updated","profile_picture":null,"self_profile":false},"title":"sSGDyh","content":"sdhdfg","created_date":"2022-08-01T13:21:42.200892Z","image":null,"like_counts":0,"comment_counts":0,"url":"https://pyaephyokyaw.pythonanywhere.com/api/v2/posts/11/","is_liked":false,"is_saved":false,"is_owner":false},{"id":10,"owner":{"id":2,"username":"user1","first_name":"Mg Mg","last_name":"Aye","university":"Sagaing","profile_picture":null,"self_profile":false},"title":"GFdhg","content":"sdhfhf","created_date":"2022-08-01T13:21:31.879923Z","image":null,"like_counts":0,"comment_counts":0,"url":"https://pyaephyokyaw.pythonanywhere.com/api/v2/posts/10/","is_liked":false,"is_saved":false,"is_owner":false},{"id":9,"owner":{"id":2,"username":"user1","first_name":"Mg Mg","last_name":"Aye","university":"Sagaing","profile_picture":null,"self_profile":false},"title":"This is First Post","content":"AAAA","created_date":"2022-08-01T13:21:12.154819Z","image":null,"like_counts":0,"comment_counts":0,"url":"https://pyaephyokyaw.pythonanywhere.com/api/v2/posts/9/","is_liked":false,"is_saved":false,"is_owner":false},{"id":8,"owner":{"id":1,"username":"pyaephyokyaw15","first_name":"UPdated","last_name":"UPdate","university":"Updated","profile_picture":null,"self_profile":false},"title":"Post8","content":"sdgdhfdhf","created_date":"2022-08-01T13:20:27.670719Z","image":null,"like_counts":0,"comment_counts":0,"url":"https://pyaephyokyaw.pythonanywhere.com/api/v2/posts/8/","is_liked":false,"is_saved":false,"is_owner":false},{"id":7,"owner":{"id":1,"username":"pyaephyokyaw15","first_name":"UPdated","last_name":"UPdate","university":"Updated","profile_picture":null,"self_profile":false},"title":"Post7","content":"asdfgsdhgdfhsdfh","created_date":"2022-08-01T13:20:10.000640Z","image":"https://pyaephyokyaw.pythonanywhere.com/media/ipad.jpg","like_counts":0,"comment_counts":0,"url":"https://pyaephyokyaw.pythonanywhere.com/api/v2/posts/7/","is_liked":false,"is_saved":false,"is_owner":false},{"id":6,"owner":{"id":1,"username":"pyaephyokyaw15","first_name":"UPdated","last_name":"UPdate","university":"Updated","profile_picture":null,"self_profile":false},"title":"Post6","content":"sdgdgdgdg","created_date":"2022-08-01T13:19:54.372221Z","image":null,"like_counts":0,"comment_counts":0,"url":"https://pyaephyokyaw.pythonanywhere.com/api/v2/posts/6/","is_liked":false,"is_saved":false,"is_owner":false},{"id":5,"owner":{"id":1,"username":"pyaephyokyaw15","first_name":"UPdated","last_name":"UPdate","university":"Updated","profile_picture":null,"self_profile":false},"title":"This is First Post","content":"AAAA","created_date":"2022-08-01T13:19:13.262073Z","image":null,"like_counts":0,"comment_counts":0,"url":"https://pyaephyokyaw.pythonanywhere.com/api/v2/posts/5/","is_liked":false,"is_saved":false,"is_owner":false},{"id":4,"owner":{"id":1,"username":"pyaephyokyaw15","first_name":"UPdated","last_name":"UPdate","university":"Updated","profile_picture":null,"self_profile":false},"title":"Post4","content":"This is post4","created_date":"2022-08-01T13:19:01.931985Z","image":null,"like_counts":0,"comment_counts":0,"url":"https://pyaephyokyaw.pythonanywhere.com/api/v2/posts/4/","is_liked":false,"is_saved":false,"is_owner":false},{"id":3,"owner":{"id":1,"username":"pyaephyokyaw15","first_name":"UPdated","last_name":"UPdate","university":"Updated","profile_picture":null,"self_profile":false},"title":"Post3","content":"THis is post3","created_date":"2022-08-01T13:18:47.841894Z","image":null,"like_counts":1,"comment_counts":0,"url":"https://pyaephyokyaw.pythonanywhere.com/api/v2/posts/3/","is_liked":false,"is_saved":false,"is_owner":false},{"id":2,"owner":{"id":1,"username":"pyaephyokyaw15","first_name":"UPdated","last_name":"UPdate","university":"Updated","profile_picture":null,"self_profile":false},"title":"Post2","content":"This is post2","created_date":"2022-08-01T13:18:17.456501Z","image":"https://pyaephyokyaw.pythonanywhere.com/media/iphone.jpeg","like_counts":1,"comment_counts":0,"url":"https://pyaephyokyaw.pythonanywhere.com/api/v2/posts/2/","is_liked":false,"is_saved":false,"is_owner":false}]
/// pagination : {"total_pages":2,"current_page":1,"next_page":2,"previous_page":null}

class PostListOb {
  PostListOb({
    this.data,
    this.pagination,
  });

  PostListOb.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(PostData.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
  }
  List<PostData>? data;
  Pagination? pagination;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    if (pagination != null) {
      map['pagination'] = pagination?.toJson();
    }
    return map;
  }
}

/// total_pages : 2
/// current_page : 1
/// next_page : 2
/// previous_page : null

class Pagination {
  Pagination({
    this.totalPages,
    this.currentPage,
    this.nextPage,
    this.previousPage,
  });

  Pagination.fromJson(dynamic json) {
    totalPages = json['total_pages'];
    currentPage = json['current_page'];
    nextPage = json['next_page'];
    previousPage = json['previous_page'];
  }
  int? totalPages;
  int? currentPage;
  int? nextPage;
  dynamic previousPage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total_pages'] = totalPages;
    map['current_page'] = currentPage;
    map['next_page'] = nextPage;
    map['previous_page'] = previousPage;
    return map;
  }
}

/// id : 11
/// owner : {"id":1,"username":"pyaephyokyaw15","first_name":"UPdated","last_name":"UPdate","university":"Updated","profile_picture":null,"self_profile":false}
/// title : "sSGDyh"
/// content : "sdhdfg"
/// created_date : "2022-08-01T13:21:42.200892Z"
/// image : null
/// like_counts : 0
/// comment_counts : 0
/// url : "https://pyaephyokyaw.pythonanywhere.com/api/v2/posts/11/"
/// is_liked : false
/// is_saved : false
/// is_owner : false
/// "comments": [
///             {
///                "id": 2,
///                 "comment": "Comment B",
///                 "owner": {
///                     "id": 5,
///                     "username": "aungkaungmyat",
///                     "first_name": "Aung kaung",
///                     "last_name": "Myat",
///                     "university": "MTU",
///                     "profile_picture": "https://pyaephyokyaw.pythonanywhere.com/media/profile_pictures/0af055db-3012-4aaf-8971-d2de788e104b.jpg",
///                     "self_profile": false
///                 },
///                 "created_date": "2022-08-17T14:50:36.821430Z",
///                 "post": 30,
///                 "url": "https://pyaephyokyaw.pythonanywhere.com/api/v2/comments/2/",
///                 "is_owner": false
///             },
///        ],

class PostData {
  PostData({
    this.id,
    this.owner,
    this.title,
    this.content,
    this.createdDate,
    this.image,
    this.likeCounts,
    this.commentCounts,
    this.comments,
    this.url,
    this.isLiked,
    this.isSaved,
    this.isOwner,
  });

  PostData.fromJson(dynamic json) {
    List<dynamic> cmtDataList =
        json['comments'] != null ? json['comments'].cast<dynamic>() : [];
    id = json['id'];
    owner = json['owner'] != null ? Owner.fromJson(json['owner']) : null;
    title = json['title'];
    content = json['content'];
    createdDate = json['created_date'];
    image = json['image'];
    likeCounts = json['like_counts'];
    commentCounts = json['comment_counts'];
    comments =
        cmtDataList.map((cmtData) => CommentData.fromJson(cmtData)).toList();

    url = json['url'];
    isLiked = json['is_liked'];
    isSaved = json['is_saved'];
    isOwner = json['is_owner'];
  }
  int? id;
  Owner? owner;
  String? title;
  String? content;
  String? createdDate;
  dynamic image;
  int? likeCounts;
  int? commentCounts;
  List<CommentData>? comments;
  String? url;
  bool? isLiked;
  bool? isSaved;
  bool? isOwner;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    if (owner != null) {
      map['owner'] = owner?.toJson();
    }
    map['title'] = title;
    map['content'] = content;
    map['created_date'] = createdDate;
    map['image'] = image;
    map['like_counts'] = likeCounts;
    map['comment_counts'] = commentCounts;
    map['comments'] =
        comments?.map((cmt) => CommentData().toJson(cmt)).toList();
    map['url'] = url;
    map['is_liked'] = isLiked;
    map['is_saved'] = isSaved;
    map['is_owner'] = isOwner;
    return map;
  }
}

/// id : 1
/// username : "pyaephyokyaw15"
/// first_name : "UPdated"
/// last_name : "UPdate"
/// university : "Updated"
/// profile_picture : null
/// self_profile : false

class Owner {
  Owner({
    this.id,
    this.username,
    this.firstName,
    this.lastName,
    this.university,
    this.profilePicture,
    this.selfProfile,
  });

  Owner.fromJson(dynamic json) {
    id = json['id'];
    username = json['username'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    university = json['university'];
    profilePicture = json['profile_picture'];
    selfProfile = json['self_profile'];
  }
  int? id;
  String? username;
  String? firstName;
  String? lastName;
  String? university;
  dynamic profilePicture;
  bool? selfProfile;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['username'] = username;
    map['first_name'] = firstName;
    map['last_name'] = lastName;
    map['university'] = university;
    map['profile_picture'] = profilePicture;
    map['self_profile'] = selfProfile;
    return map;
  }
}
