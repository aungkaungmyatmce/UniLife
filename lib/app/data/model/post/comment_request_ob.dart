class CreateCommentRequestOb {
  int? post;
  String? comment;

  CreateCommentRequestOb({
    this.post,
    this.comment,
  });

  CreateCommentRequestOb.fromJson(Map<String, dynamic> json) {
    post = json['post'];
    comment = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['post'] = post;
    data['comment'] = comment;
    return data;
  }
}
