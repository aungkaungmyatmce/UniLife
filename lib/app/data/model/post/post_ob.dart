/// data : [{"id":12,"posted_by":{"id":1,"username":"pyaephyokyaw","email":"pyaephyokyaw@gmail.com"},"title":"Post20","content":"This is Post18","created_date":"2022-05-31T11:30:27.076739Z","image":null,"like_counts":0,"is_liked":false,"is_saved":false,"is_owner":false},{"id":11,"posted_by":{"id":1,"username":"pyaephyokyaw","email":"pyaephyokyaw@gmail.com"},"title":"Post20","content":"This is Post18","created_date":"2022-05-31T11:30:14.605367Z","image":null,"like_counts":0,"is_liked":false,"is_saved":false,"is_owner":false},{"id":10,"posted_by":{"id":1,"username":"pyaephyokyaw","email":"pyaephyokyaw@gmail.com"},"title":"Post20","content":"This is Post18","created_date":"2022-05-30T11:36:57.442041Z","image":null,"like_counts":0,"is_liked":false,"is_saved":false,"is_owner":false},{"id":9,"posted_by":{"id":1,"username":"pyaephyokyaw","email":"pyaephyokyaw@gmail.com"},"title":"Post20","content":"This is Post18","created_date":"2022-05-30T11:27:27.929081Z","image":null,"like_counts":0,"is_liked":false,"is_saved":false,"is_owner":false},{"id":8,"posted_by":{"id":3,"username":"mzp@1234","email":"mzp@gmail.com"},"title":"Post18","content":"This is Post18","created_date":"2022-05-28T11:50:30.817798Z","image":null,"like_counts":1,"is_liked":false,"is_saved":false,"is_owner":false},{"id":6,"posted_by":{"id":3,"username":"mzp@1234","email":"mzp@gmail.com"},"title":"Post18","content":"This is Post18","created_date":"2022-05-28T11:35:32.317790Z","image":null,"like_counts":0,"is_liked":false,"is_saved":false,"is_owner":false},{"id":4,"posted_by":{"id":1,"username":"pyaephyokyaw","email":"pyaephyokyaw@gmail.com"},"title":"Post18","content":"This is Post18","created_date":"2022-05-24T12:36:55.167212Z","image":"https://pyaephyokyaw.pythonanywhere.com/media/d803b1ed-1965-47e0-a613-a431aaab0b94.jpg","like_counts":1,"is_liked":false,"is_saved":false,"is_owner":false},{"id":3,"posted_by":{"id":1,"username":"pyaephyokyaw","email":"pyaephyokyaw@gmail.com"},"title":"Post18","content":"This is Post18","created_date":"2022-05-24T05:05:39.617366Z","image":"https://pyaephyokyaw.pythonanywhere.com/media/1808462e-3856-437a-9513-145f786d0e3a.jpg","like_counts":0,"is_liked":false,"is_saved":false,"is_owner":false},{"id":2,"posted_by":{"id":1,"username":"pyaephyokyaw","email":"pyaephyokyaw@gmail.com"},"title":"Post18","content":"This is Post18","created_date":"2022-05-24T05:05:11.038353Z","image":null,"like_counts":0,"is_liked":false,"is_saved":false,"is_owner":false},{"id":1,"posted_by":{"id":1,"username":"pyaephyokyaw","email":"pyaephyokyaw@gmail.com"},"title":"Post18","content":"This is Post18","created_date":"2022-05-24T05:04:34.473867Z","image":null,"like_counts":1,"is_liked":false,"is_saved":false,"is_owner":false}]
/// pagination : {"total_pages":1,"current_page":1,"next_page":null,"previous_page":null}

class PostListOb {
  PostListOb({
      this.data, 
      this.pagination,});

  PostListOb.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(PostData.fromJson(v));
      });
    }
    pagination = json['pagination'] != null ? Pagination.fromJson(json['pagination']) : null;
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

/// total_pages : 1
/// current_page : 1
/// next_page : null
/// previous_page : null

class Pagination {
  Pagination({
      this.totalPages, 
      this.currentPage, 
      this.nextPage, 
      this.previousPage,});

  Pagination.fromJson(dynamic json) {
    totalPages = json['total_pages'];
    currentPage = json['current_page'];
    nextPage = json['next_page'];
    previousPage = json['previous_page'];
  }
  int? totalPages;
  int? currentPage;
  dynamic nextPage;
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

/// id : 12
/// posted_by : {"id":1,"username":"pyaephyokyaw","email":"pyaephyokyaw@gmail.com"}
/// title : "Post20"
/// content : "This is Post18"
/// created_date : "2022-05-31T11:30:27.076739Z"
/// image : null
/// like_counts : 0
/// is_liked : false
/// is_saved : false
/// is_owner : false

class PostData {
  PostData({
      this.id, 
      this.postedBy, 
      this.title, 
      this.content, 
      this.createdDate, 
      this.image, 
      this.likeCounts, 
      this.isLiked, 
      this.isSaved, 
      this.isOwner,});

  PostData.fromJson(dynamic json) {
    id = json['id'];
    postedBy = json['posted_by'] != null ? PostedBy.fromJson(json['posted_by']) : null;
    title = json['title'];
    content = json['content'];
    createdDate = json['created_date'];
    image = json['image'];
    likeCounts = json['like_counts'];
    isLiked = json['is_liked'];
    isSaved = json['is_saved'];
    isOwner = json['is_owner'];
  }
  int? id;
  PostedBy? postedBy;
  String? title;
  String? content;
  String? createdDate;
  String? image;
  int? likeCounts;
  bool? isLiked;
  bool? isSaved;
  bool? isOwner;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    if (postedBy != null) {
      map['posted_by'] = postedBy?.toJson();
    }
    map['title'] = title;
    map['content'] = content;
    map['created_date'] = createdDate;
    map['image'] = image;
    map['like_counts'] = likeCounts;
    map['is_liked'] = isLiked;
    map['is_saved'] = isSaved;
    map['is_owner'] = isOwner;
    return map;
  }

}

/// id : 1
/// username : "pyaephyokyaw"
/// email : "pyaephyokyaw@gmail.com"

class PostedBy {
  PostedBy({
      this.id, 
      this.username, 
      this.email,});

  PostedBy.fromJson(dynamic json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
  }
  int? id;
  String? username;
  String? email;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['username'] = username;
    map['email'] = email;
    return map;
  }

}