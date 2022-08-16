import 'package:blog_post_flutter/app/constant/routing/app_routes.dart';
import 'package:blog_post_flutter/app/core/base/base_controller.dart';
import 'package:blog_post_flutter/app/core/utils/app_utils.dart';
import 'package:blog_post_flutter/app/core/utils/global_key_utils.dart';
import 'package:blog_post_flutter/app/core/utils/pagination_utils.dart';
import 'package:blog_post_flutter/app/data/model/authentication/profile_ob.dart';
import 'package:blog_post_flutter/app/data/model/post/post_ob.dart';
import 'package:blog_post_flutter/app/data/network/base_response/base_api_response.dart';
import 'package:blog_post_flutter/app/data/repository/post/post_repository.dart';
import 'package:blog_post_flutter/app/features/favourite/controller/favourite_controller.dart';
import 'package:get/get.dart';

class OtherProfileController extends BaseController {
  final PostRepository _repository = Get.find(tag: (PostRepository).toString());
  int? profileId;
  var profileDetail = ProfileOb().obs;

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
    }
  }

  void _handleProfileResponseError(Exception exception) {
    AppUtils.showToast(errorMessage);
  }
}
