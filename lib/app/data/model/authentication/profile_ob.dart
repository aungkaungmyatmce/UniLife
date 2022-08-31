import 'package:blog_post_flutter/app/data/model/post/post_ob.dart';

/// id : 1
/// username : "pyaephyokyaw15"
/// first_name : "Pyae Phyo"
/// last_name : "Kyaw"
/// university : "MTU"
/// profile_picture : null
/// posts : [{"id":15,"owner":{"id":1,"username":"pyaephyokyaw15","first_name":"Pyae Phyo","last_name":"Kyaw","university":"MTU","profile_picture":null,"self_profile":false},"title":"Where can I get some?","content":"There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.","created_date":"2022-08-03T03:18:55.543550Z","image":null,"like_counts":0,"comment_counts":0,"comments":[],"is_liked":false,"is_saved":false,"is_owner":false},{"id":14,"owner":{"id":1,"username":"pyaephyokyaw15","first_name":"Pyae Phyo","last_name":"Kyaw","university":"MTU","profile_picture":null,"self_profile":false},"title":"Why do we use it?","content":"It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).","created_date":"2022-08-03T03:18:19.653673Z","image":null,"like_counts":0,"comment_counts":0,"comments":[],"is_liked":false,"is_saved":false,"is_owner":false},{"id":13,"owner":{"id":1,"username":"pyaephyokyaw15","first_name":"Pyae Phyo","last_name":"Kyaw","university":"MTU","profile_picture":null,"self_profile":false},"title":"Where does it come from?","content":"Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of","created_date":"2022-08-03T03:17:53.942719Z","image":null,"like_counts":0,"comment_counts":0,"comments":[],"is_liked":false,"is_saved":false,"is_owner":false},{"id":12,"owner":{"id":1,"username":"pyaephyokyaw15","first_name":"Pyae Phyo","last_name":"Kyaw","university":"MTU","profile_picture":null,"self_profile":false},"title":"What is Lorem Ipsum?","content":"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.","created_date":"2022-08-03T03:15:59.159902Z","image":null,"like_counts":0,"comment_counts":0,"comments":[],"is_liked":false,"is_saved":false,"is_owner":false}]
/// self_profile : false

class ProfileOb {
  ProfileOb({
    this.id,
    this.username,
    this.firstName,
    this.lastName,
    this.university,
    this.profilePicture,
    this.posts,
    this.followers,
    this.following,
    this.isFollowing,
    this.selfProfile,
  });

  ProfileOb.fromJson(dynamic json) {
    id = json['id'];
    username = json['username'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    university = json['university'];
    profilePicture = json['profile_picture'];
    isFollowing = json['is_following'];
    if (json['posts'] != null) {
      posts = [];
      json['posts'].forEach((v) {
        posts?.add(PostData.fromJson(v));
      });
    }
    if (json['followers'] != null) {
      followers = [];
      json['followers'].forEach((v) {
        followers?.add(Owner.fromJson(v));
      });
    }

    if (json['following'] != null) {
      following = [];
      json['following'].forEach((v) {
        following?.add(Owner.fromJson(v));
      });
    }
    selfProfile = json['is_self_profile'];
  }

  int? id;
  String? username;
  String? firstName;
  String? lastName;
  String? university;
  dynamic profilePicture;
  List<PostData>? posts;
  List<Owner>? followers;
  List<Owner>? following;
  bool? isFollowing;
  bool? selfProfile;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['username'] = username;
    map['first_name'] = firstName;
    map['last_name'] = lastName;
    map['university'] = university;
    map['profile_picture'] = profilePicture;
    map['is_following'] = isFollowing;
    if (posts != null) {
      map['posts'] = posts?.map((v) => v.toJson()).toList();
    }
    if (followers != null) {
      map['followers'] = followers?.map((v) => v.toJson()).toList();
    }
    if (following != null) {
      map['following'] = following?.map((v) => v.toJson()).toList();
    }
    map['is_self_profile'] = selfProfile;
    return map;
  }
}

/// id : 1
/// username : "pyaephyokyaw15"
/// first_name : "Pyae Phyo"
/// last_name : "Kyaw"
/// university : "MTU"
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
    this.isFollowing,
  });

  Owner.fromJson(dynamic json) {
    id = json['id'];
    username = json['username'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    university = json['university'];
    profilePicture = json['profile_picture'];
    selfProfile = json['self_profile'];
    isFollowing = json['is_following'];
  }

  int? id;
  String? username;
  String? firstName;
  String? lastName;
  String? university;
  dynamic profilePicture;
  bool? selfProfile;
  bool? isFollowing;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['username'] = username;
    map['first_name'] = firstName;
    map['last_name'] = lastName;
    map['university'] = university;
    map['profile_picture'] = profilePicture;
    map['self_profile'] = selfProfile;
    map['is_following'] = isFollowing;
    return map;
  }
}
