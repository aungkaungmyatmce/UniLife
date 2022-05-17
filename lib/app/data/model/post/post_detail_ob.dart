/// id : 4
/// posted_by : {"id":2,"username":"minzinphyo","email":""}
/// title : "Post10"
/// content : "This is Post10."
/// created_date : "2022-04-30T07:49:19.690645Z"
/// image : "https://pyaephyokyaw.pythonanywhere.com/media/default.jpg"

class PostDetailOb {
  PostDetailOb({
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

  PostDetailOb.fromJson(dynamic json) {
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
PostDetailOb copyWith({  int? id,
  PostedBy? postedBy,
  String? title,
  String? content,
  String? createdDate,
  String? image,
}) => PostDetailOb(  id: id ?? _id,
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

/// id : 2
/// username : "minzinphyo"
/// email : ""

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