import 'dart:convert';

import 'package:blog_post_flutter/app/constant/routing/app_routes.dart';
import 'package:blog_post_flutter/app/core/base/base_controller.dart';
import 'package:blog_post_flutter/app/core/utils/app_utils.dart';
import 'package:blog_post_flutter/app/data/model/authentication/profile_ob.dart';
import 'package:blog_post_flutter/app/data/network/base_response/base_api_response.dart';
import 'package:blog_post_flutter/app/data/repository/comment/comment_repository_impl.dart';
import 'package:blog_post_flutter/app/data/repository/post/post_repository.dart';
import 'package:get/get.dart';
import 'package:async/async.dart';
import '../../../data/local/cache_manager.dart';
import '../../../data/model/authentication/login_response.dart';
import '../../../data/repository/comment/comment_repository.dart';

class OtherProfileController extends BaseController {
  final PostRepository _repository = Get.find(tag: (PostRepository).toString());
  // final CommentRepository _followRepository =
  //     Get.find(tag: (CommentRepository).toString());
  final CommentRepository _followRepository = CommentRepositoryImpl();
  int? profileId;
  var profileDetail = ProfileOb().obs;
  RxBool isFollow = false.obs;
  RxBool notLogin = false.obs;
  Rx<LoginResponse> loginResponse = LoginResponse().obs;

  RestartableTimer _toggleSaveTimer =
      RestartableTimer(Duration.zero, () => null);

  @override
  void onInit() {
    if (getString(CacheManagerKey.loginResponseData) != null) {
      Map<String, dynamic> authenticationResponse =
          jsonDecode(getString(CacheManagerKey.loginResponseData)!);
      loginResponse.value = LoginResponse.fromJson(authenticationResponse);
    }
    super.onInit();
    profileId = Get.arguments;
    if (profileId != null) fetchProfile(profileId!);
  }

  //Fetch Profile

  void fetchProfile(int profileId) async {
    final repoService = _repository.getProfileDetail(profileId);
    await callAPIService(
      repoService,
      onSuccess: _handleProfileResponseSuccess,
      onError: _handleProfileResponseError,
    );
  }

  void _handleProfileResponseSuccess(response) async {
    if (response != null) {
      BaseApiResponse<ProfileOb?> _profileDetailData = response;
      ProfileOb data = _profileDetailData.objectResult;
      profileDetail.value = data;
      if (profileDetail.value.isFollowing != null) {
        isFollow.value = profileDetail.value.isFollowing!;
        notLogin.value = false;
      } else {
        notLogin.value = true;
      }
    }
  }

  void _handleProfileResponseError(Exception exception) {
    AppUtils.showToast(errorMessage);
  }

  void onTapFollow(int index) {
    Get.toNamed(Paths.FOLLOW, arguments: {
      'myProfile': profileDetail.value,
      'tabIndex': index,
    });
  }

  void toggleFollowTimer(Function onTimerStart) {
    _toggleSaveTimer.cancel();
    Duration _timerDuration = const Duration(seconds: 3);
    _toggleSaveTimer = RestartableTimer(
      _timerDuration,
      () {
        onTimerStart();
      },
    );
    _toggleSaveTimer.reset();
  }

  //Toggle Save Post
  void toggleFollow() {
    isFollow.value = !isFollow.value;
    if (isFollow.value) {
      // if (profileDetail.value.followers == null) {
      //   profileDetail.value.followers = [];
      // }
      profileDetail.value.followers!.add(Owner(
        id: loginResponse.value.user!.id,
        firstName: loginResponse.value.user!.firstName,
        lastName: loginResponse.value.user!.lastName,
        profilePicture: loginResponse.value.user!.profileImage,
      ));
    } else {
      profileDetail.value.followers!
          .removeWhere((owner) => owner.id == loginResponse.value.user!.id);
    }
    if (isFollow.value != profileDetail.value.isFollowing!) {
      toggleFollowTimer(() {
        updateFollowApi();
      });
    } else {
      _toggleSaveTimer.cancel();
    }
  }

  void updateFollowApi() {
    late Future<BaseApiResponse<String?>> repoService;
    repoService = _followRepository.followUser(userId: profileDetail.value.id!);

    callAPIService(repoService, onSuccess: (dynamic response) {
      if (response != null) {
        BaseApiResponse<String?> _baseApiResponse = response;
        AppUtils.showToast(" ${_baseApiResponse.message}");
        profileDetail.value.isFollowing = isFollow.value;
      }
    }, onError: (Exception exception) {
      AppUtils.showToast(errorMessage);
    });
  }
}
