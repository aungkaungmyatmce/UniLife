
import 'package:blog_post_flutter/app/data/network/exception/base_exception.dart';

class AppException extends BaseException {
  AppException({
    String message = "",
  }) : super(message: message);
}
