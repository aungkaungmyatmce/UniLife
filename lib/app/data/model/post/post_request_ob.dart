class CreatePostRequestOb {
  String? title;
  String? content;
  String? image;

  CreatePostRequestOb({this.title, this.content, this.image});

  CreatePostRequestOb.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    content = json['content'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['content'] = this.content;
    data['image'] = this.image;
    return data;
  }
}