class Meta {
  int? currentPage;
  int? from;
  int? lastPage;
  String? path;
  String? perPage;
  int? to;
  int? total;
  int? totalPrice;

  Meta({
    this.currentPage,
    this.from,
    this.lastPage,
    this.path,
    this.perPage,
    this.to,
    this.total,
    this.totalPrice
  });

  Meta.fromJson(dynamic json) {
    currentPage = json["current_page"];
    from = json["from"];
    lastPage = json["last_page"];
    path = json["path"];
    perPage = json["per_page"];
    to = json["to"];
    total = json["total"];
    totalPrice = json["totalPrice"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["current_page"] = currentPage;
    map["from"] = from;
    map["last_page"] = lastPage;
    map["path"] = path;
    map["per_page"] = perPage;
    map["to"] = to;
    map["total"] = total;
    map["totalPrice"] = totalPrice;
    return map;
  }

}

class Links {
  String? first;
  String? last;
  String? prev;
  String? next;

  Links({
    this.first,
    this.last,
    this.prev,
    this.next});

  Links.fromJson(dynamic json) {
    first = json["first"];
    last = json["last"];
    prev = json["prev"];
    next = json["next"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["first"] = first;
    map["last"] = last;
    map["prev"] = prev;
    map["next"] = next;
    return map;
  }

}
