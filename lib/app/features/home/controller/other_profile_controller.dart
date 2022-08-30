import 'package:blog_post_flutter/app/constant/routing/app_routes.dart';
import 'package:blog_post_flutter/app/core/base/base_controller.dart';
import 'package:blog_post_flutter/app/core/utils/app_utils.dart';
import 'package:blog_post_flutter/app/data/model/authentication/profile_ob.dart';
import 'package:blog_post_flutter/app/data/model/post/post_ob.dart';
import 'package:blog_post_flutter/app/data/network/base_response/base_api_response.dart';
import 'package:blog_post_flutter/app/data/repository/post/post_repository.dart';
import 'package:get/get.dart';
import 'package:async/async.dart';

import '../../../data/repository/comment/comment_repository.dart';

class OtherProfileController extends BaseController {
  final PostRepository _repository = Get.find(tag: (PostRepository).toString());
  final CommentRepository _followRepository =
      Get.find(tag: (CommentRepository).toString());
  int? profileId;
  var profileDetail = ProfileOb().obs;
  RxBool isFollow = false.obs;
  RxBool notLogin = false.obs;

  RestartableTimer _toggleSaveTimer =
      RestartableTimer(Duration.zero, () => null);

  @override
  void onInit() {
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
