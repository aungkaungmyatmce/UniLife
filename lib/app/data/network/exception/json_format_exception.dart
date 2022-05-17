
import 'package:blog_post_flutter/app/data/network/exception/base_exception.dart';

class JsonFormatException extends BaseException {
  JsonFormatException(String message) : super(message: message);
}
