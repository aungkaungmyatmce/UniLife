import 'package:blog_post_flutter/app/data/model/authentication/login_request_ob.dart';
import 'package:blog_post_flutter/app/data/model/authentication/login_response.dart';
import 'package:blog_post_flutter/app/data/network/base_response/base_api_response.dart';

abstract class AuthRepository {
  Future<BaseApiResponse<LoginResponse>> loginUser(
      LoginRequestOb loginRequestOb);
}
