/// user : {"id":2,"username":"minzinphyo","email":""}
/// token : "2e5a2c4548b8e09ff514907e713d0879505d0f36"

class LoginResponse {
  LoginResponse({
      User? user, 
      String? token,}){
    _user = user;
    _token = token;
}

  LoginResponse.fromJson(dynamic json) {
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
    _token = json['token'];
  }
  User? _user;
  String? _token;
LoginResponse copyWith({  User? user,
  String? token,
}) => LoginResponse(  user: user ?? _user,
  token: token ?? _token,
);
  User? get user => _user;
  String? get token => _token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    map['token'] = _token;
    return map;
  }

}

/// id : 2
/// username : "minzinphyo"
/// email : ""

class User {
  User({
      int? id, 
      String? username, 
      String? email,}){
    _id = id;
    _username = username;
    _email = email;
}

  User.fromJson(dynamic json) {
    _id = json['id'];
    _username = json['username'];
    _email = json['email'];
  }
  int? _id;
  String? _username;
  String? _email;
User copyWith({  int? id,
  String? username,
  String? email,
}) => User(  id: id ?? _id,
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