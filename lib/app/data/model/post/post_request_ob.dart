class CreatePostRequestOb {
  String? title;
  String? content;
  String? image;
  bool? isImageRemoved;

  CreatePostRequestOb(
      {this.title, this.content, this.image, this.isImageRemoved});

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
    if (this.isImageRemoved != null) {
      data['image_removed'] = this.isImageRemoved;
    }

    return data;
  }
}
