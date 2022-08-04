import 'package:blog_post_flutter/app/core/base/base_remote_source.dart';
import 'package:blog_post_flutter/app/data/model/authentication/login_request_ob.dart';
import 'package:blog_post_flutter/app/data/model/authentication/login_response.dart';
import 'package:blog_post_flutter/app/data/model/authentication/profile_ob.dart';
import 'package:blog_post_flutter/app/data/model/authentication/register_request_ob.dart';
import 'package:blog_post_flutter/app/data/network/base_response/base_api_response.dart';
import 'package:blog_post_flutter/app/data/network/services/dio_provider.dart';
import 'package:blog_post_flutter/app/data/repository/authentication/authentication_repository.dart';
import 'package:dio/dio.dart';

class AuthRepositoryImpl extends BaseRemoteSource implements AuthRepository {
  @override
  Future<BaseApiResponse<LoginResponse>> registerUser(
      RegisterRequestOb registerRequestOb) {
    var endpoint = "${DioProvider.baseUrl}/auth/register/";

    var dioCall = dioClient.post(endpoint, data: registerRequestOb.toJson());
    try {
      return callApiWithErrorParser(dioCall)
          .then((response) => _parseLoginResponse(response));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<BaseApiResponse<LoginResponse>> loginUser(
      LoginRequestOb loginRequestOb) {
    var endpoint = "${DioProvider.baseUrl}/auth/token/";

    var dioCall = dioClient.post(endpoint, data: loginRequestOb.toJson());
    try {
      return callApiWithErrorParser(dioCall)
          .then((response) => _parseLoginResponse(response));
    } catch (e) {
      rethrow;
    }
  }

  BaseApiResponse<LoginResponse> _parseLoginResponse(Response response) {
    return BaseApiResponse<LoginResponse>.fromObjectJson(response.data,
        createObject: (data) => LoginResponse.fromJson(data));
  }

  @override
  Future<BaseApiResponse<ProfileOb>> getProfileDetail(profileId) {
    var endpoint = "${DioProvider.baseUrl}/accounts/$profileId/";

    var dioCall = dioClient.get(endpoint);
    try {
      return callApiWithErrorParser(dioCall)
          .then((response) => _parseProfileDetailResponse(response));
    } catch (e) {
      rethrow;
    }
  }

  BaseApiResponse<ProfileOb> _parseProfileDetailResponse(Response response) {
    return BaseApiResponse<ProfileOb>.fromObjectJson(response.data,
        createObject: (data) => ProfileOb.fromJson(data));
  }
}
