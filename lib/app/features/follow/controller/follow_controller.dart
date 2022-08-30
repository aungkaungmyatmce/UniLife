import 'package:blog_post_flutter/app/core/base/base_controller.dart';
import 'package:blog_post_flutter/app/features/follow/controller/tab_controller.dart';
import 'package:get/get.dart';
import '../../../core/utils/app_utils.dart';
import '../../../data/model/authentication/profile_ob.dart';
import '../../../data/network/base_response/base_api_response.dart';
import '../../../data/repository/comment/comment_repository.dart';

class FollowController extends BaseController {
  final CommentRepository _repository =
      Get.find(tag: (CommentRepository).toString());

  var followers = [].obs;
  var following = [].obs;
  var myProfile = ProfileOb().obs;
  //List<bool> followerList = [];
  //List<bool> followingList = [];

  final MyTabController tab = Get.find<MyTabController>();

  @override
  void onInit() {
    myProfile.value = Get.arguments['myProfile'];
    tab.controller.index = Get.arguments['tabIndex'];
    if (myProfile.value.followers != null) {
      followers.value = myProfile.value.followers!;
    }
    if (myProfile.value.following != null) {
      following.value = myProfile.value.following!;
    }

    // followers.forEach((f) {
    //   followerList.add(f.isFollowing!);
    // });
    // following.forEach((f) {
    //   followingList.add(f.isFollowing!);
    // });
    super.onInit();
  }

  void toggleFollow({required int followerId}) {
    for (int i = 0; i < followers.length; i++) {
      if (followers[i].id == followerId) {
        followers[i].isFollowing = !followers[i].isFollowing;
      }
    }
    for (var f in following) {
      if (f.id == followerId) {
        f.isFollowing = !f.isFollowing;
      }
    }
    update();
  }

  // void updateFollow() {
  //   List<int?> idList = [];
  //   for (int i = 0; i < followers.length; i++) {
  //     if (followerList[i] != followers[i].isFollowing) {
  //       idList.add(followers[i].id);
  //     }
  //   }
  //
  //   for (int i = 0; i < following.length; i++) {
  //     if (followingList[i] != following[i].isFollowing) {
  //       idList.add(following[i].id);
  //     }
  //   }
  //   idList = idList.toSet().toList();
  //   idList.forEach((id) {
  //     updateFollowApi(id!);
  //   });
  // }
  //
  // void updateFollowApi(int userId) {
  //   late Future<BaseApiResponse<String?>> repoService;
  //   repoService = _repository.followUser(userId: userId);
  //
  //   callAPIService(repoService, onSuccess: (dynamic response) {
  //     if (response != null) {
  //       Get.back(result: 'updated');
  //       BaseApiResponse<String?> _baseApiResponse = response;
  //       AppUtils.showToast(" ${_baseApiResponse.message}");
  //     }
  //   }, onError: (Exception exception) {
  //     Get.back();
  //     AppUtils.showToast(errorMessage);
  //   });
  // }
  //
  // // @override
  // // void onClose() {
  // //   print('Close');
  // //   Get.back(result: 'updated');
  // //   updateFollow();
  // //
  // //   super.onClose();
  // // }
  //
  // void tapBack() {
  //   Get.back(result: 'updated');
  //   updateFollow();
  // }
}
