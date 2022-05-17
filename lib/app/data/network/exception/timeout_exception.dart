
import 'package:blog_post_flutter/app/data/network/exception/base_exception.dart';

class TimeoutException extends BaseException {
  TimeoutException(String message) : super(message: message);
}
