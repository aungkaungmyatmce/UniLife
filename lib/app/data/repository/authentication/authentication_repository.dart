import 'package:blog_post_flutter/app/data/model/authentication/login_request_ob.dart';
import 'package:blog_post_flutter/app/data/model/authentication/login_response.dart';
import 'package:blog_post_flutter/app/data/model/authentication/profile_ob.dart';
import 'package:blog_post_flutter/app/data/model/authentication/register_request_ob.dart';
import 'package:blog_post_flutter/app/data/network/base_response/base_api_response.dart';

abstract class AuthRepository {
  //Register
  Future<BaseApiResponse<LoginResponse>> registerUser(
      RegisterRequestOb registerRequestOb);

  //Login
  Future<BaseApiResponse<LoginResponse>> loginUser(
      LoginRequestOb loginRequestOb);

  //Get Profile
  Future<BaseApiResponse<ProfileOb>> getProfileDetail(profileId);

  //Logout
  Future<BaseApiResponse<String?>> logoutUser();

  //Register
  Future<BaseApiResponse<String?>> updateProfile(
      RegisterRequestOb registerRequestOb,
      {required int profileId});
}
