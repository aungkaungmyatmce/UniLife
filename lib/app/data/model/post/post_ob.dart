

import 'package:blog_post_flutter/app/data/model/pagination/pagination_ob.dart';

/// data : [{"id":17,"posted_by":{"id":1,"username":"pyaephyokyaw","email":"pyaephyokyaw@gmail.com"},"title":"Post7 Updated","content":"This is Post7 Updated","created_date":"2022-05-01T11:55:29.368856Z","image":"https://pyaephyokyaw.pythonanywhere.com/media/default.jpg"},{"id":18,"posted_by":{"id":1,"username":"pyaephyokyaw","email":"pyaephyokyaw@gmail.com"},"title":"Post19","content":"This is Post19","created_date":"2022-05-01T11:55:44.208051Z","image":"https://pyaephyokyaw.pythonanywhere.com/media/default.jpg"},{"id":19,"posted_by":{"id":2,"username":"minzinphyo","email":""},"title":"Post18","content":"This is Post18","created_date":"2022-05-01T11:56:18.396092Z","image":"https://pyaephyokyaw.pythonanywhere.com/media/default.jpg"},{"id":20,"posted_by":{"id":1,"username":"pyaephyokyaw","email":"pyaephyokyaw@gmail.com"},"title":"Post19","content":"This is Post19","created_date":"2022-05-01T12:03:32.025300Z","image":"https://pyaephyokyaw.pythonanywhere.com/media/30fda547-4443-40c3-8259-aae72a63e1ba.jpg"},{"id":22,"posted_by":{"id":1,"username":"pyaephyokyaw","email":"pyaephyokyaw@gmail.com"},"title":"Post18","content":"This is Post18","created_date":"2022-05-01T14:23:28.865668Z","image":"https://pyaephyokyaw.pythonanywhere.com/media/default.jpg"},{"id":23,"posted_by":{"id":1,"username":"pyaephyokyaw","email":"pyaephyokyaw@gmail.com"},"title":"Post18","content":"This is Post18","created_date":"2022-05-03T16:11:48.321301Z","image":"https://pyaephyokyaw.pythonanywhere.com/media/default.jpg"}]
/// pagination : {"total_pages":2,"current_page":2,"next_page":null,"previous_page":1}

class PostListOb {
  PostListOb({
      List<PostData>? data,
      Pagination? pagination,}){
    _data = data;
    _pagination = pagination;
}

  PostListOb.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(PostData.fromJson(v));
      });
    }
    _pagination = json['pagination'] != null ? Pagination.fromJson(json['pagination']) : null;
  }
  List<PostData>? _data;
  Pagination? _pagination;
PostListOb copyWith({  List<PostData>? data,
  Pagination? pagination,
}) => PostListOb(  data: data ?? _data,
  pagination: pagination ?? _pagination,
);
  List<PostData>? get data => _data;
  Pagination? get pagination => _pagination;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    if (_pagination != null) {
      map['pagination'] = _pagination?.toJson();
    }
    return map;
  }

}



/// id : 17
/// posted_by : {"id":1,"username":"pyaephyokyaw","email":"pyaephyokyaw@gmail.com"}
/// title : "Post7 Updated"
/// content : "This is Post7 Updated"
/// created_date : "2022-05-01T11:55:29.368856Z"
/// image : "https://pyaephyokyaw.pythonanywhere.com/media/default.jpg"

class PostData {
  PostData({
      int? id, 
      PostedBy? postedBy, 
      String? title, 
      String? content, 
      String? createdDate, 
      String? image,}){
    _id = id;
    _postedBy = postedBy;
    _title = title;
    _content = content;
    _createdDate = createdDate;
    _image = image;
}

  PostData.fromJson(dynamic json) {
    _id = json['id'];
    _postedBy = json['posted_by'] != null ? PostedBy.fromJson(json['posted_by']) : null;
    _title = json['title'];
    _content = json['content'];
    _createdDate = json['created_date'];
    _image = json['image'];
  }
  int? _id;
  PostedBy? _postedBy;
  String? _title;
  String? _content;
  String? _createdDate;
  String? _image;
PostData copyWith({  int? id,
  PostedBy? postedBy,
  String? title,
  String? content,
  String? createdDate,
  String? image,
}) => PostData(  id: id ?? _id,
  postedBy: postedBy ?? _postedBy,
  title: title ?? _title,
  content: content ?? _content,
  createdDate: createdDate ?? _createdDate,
  image: image ?? _image,
);
  int? get id => _id;
  PostedBy? get postedBy => _postedBy;
  String? get title => _title;
  String? get content => _content;
  String? get createdDate => _createdDate;
  String? get image => _image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    if (_postedBy != null) {
      map['posted_by'] = _postedBy?.toJson();
    }
    map['title'] = _title;
    map['content'] = _content;
    map['created_date'] = _createdDate;
    map['image'] = _image;
    return map;
  }

}

/// id : 1
/// username : "pyaephyokyaw"
/// email : "pyaephyokyaw@gmail.com"

class PostedBy {
  PostedBy({
      int? id, 
      String? username, 
      String? email,}){
    _id = id;
    _username = username;
    _email = email;
}

  PostedBy.fromJson(dynamic json) {
    _id = json['id'];
    _username = json['username'];
    _email = json['email'];
  }
  int? _id;
  String? _username;
  String? _email;
PostedBy copyWith({  int? id,
  String? username,
  String? email,
}) => PostedBy(  id: id ?? _id,
  username: username ?? _username,
  email: email ?? _email,
);
  int? get id => _id;
  String? get username => _username;
  String? get email => _email;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['username'] = _username;
    map['email'] = _email;
    return map;
  }

}