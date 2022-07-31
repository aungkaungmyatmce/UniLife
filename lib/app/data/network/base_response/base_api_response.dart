
import 'package:blog_post_flutter/app/data/network/model/pagination/pagination_ob.dart';
import 'package:flutter/cupertino.dart';

class BaseApiResponse<T> {
  T? _objectResult;
  List<T>? _listResult;
  int? _statusCode;
  String? _message;
  Meta? _meta;
  Links? _links;

  dynamic get objectResult => _objectResult;

  dynamic get listResult => _listResult;

  int? get statusCode => _statusCode;

  String? get message => _message;

  Meta? get meta => _meta;

  Links? get link => _links;

  BaseApiResponse(
      {dynamic objectResult,
      dynamic listResult,
      int? statusCode,
      String? message,Meta? meta,
        Links? links}) {
    _objectResult = objectResult;
    _listResult = listResult;
    _statusCode = statusCode;
    _message = message;
    _meta = meta;
    _links = links;
  }

  factory BaseApiResponse.fromObjectJson(Map<String, dynamic> json,
      {@required Function(Map<String, dynamic>)? createObject}) {
    return BaseApiResponse<T>(
      objectResult: json["result"] != null ? createObject!(json["result"]) : null,
      statusCode: json["status_code"],
      message: json["message"],
    );
  }
  factory BaseApiResponse.fromListJsonWithPagination(Map<String, dynamic> json,
      {required Function(Map<String, dynamic>) create,
        required Function(Map<String, dynamic>) createMetaObject,
        required Function(Map<String, dynamic>) createLinkObject}) {
    List<T> data = [];
    json['data'].forEach((v) {
      data.add(create(v));
    });

    return BaseApiResponse<T>(
        statusCode: json["statusCode"],
        message: json["message"],
        listResult: data,
        links: createLinkObject(json["links"]),
        meta: createMetaObject(json["meta"]));
  }

  factory BaseApiResponse.fromStringJson(
    Map<String, dynamic> json,
  ) {
    return BaseApiResponse<T>(
      objectResult: json["data"],
      statusCode: json["status"],
      message: json["message"],
    );
  }

  factory BaseApiResponse.fromListJson(Map<String, dynamic> json,
      {Function(Map<String, dynamic>)? createList}) {
    var data = <T>[];
    json['data'].forEach((v) {
      data.add(createList!(v));
    });

    return BaseApiResponse<T>(
        statusCode: json["status"],
        message: json["message"],
        listResult: data);
  }
}
