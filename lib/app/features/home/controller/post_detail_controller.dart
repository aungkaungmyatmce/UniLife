import 'package:blog_post_flutter/app/constant/routing/app_routes.dart';
import 'package:blog_post_flutter/app/core/base/base_controller.dart';
import 'package:blog_post_flutter/app/core/utils/app_utils.dart';
import 'package:blog_post_flutter/app/core/utils/global_key_utils.dart';
import 'package:blog_post_flutter/app/core/utils/pagination_utils.dart';
import 'package:blog_post_flutter/app/data/model/authentication/profile_ob.dart';
import 'package:blog_post_flutter/app/data/model/post/post_ob.dart';
import 'package:blog_post_flutter/app/data/network/base_response/base_api_response.dart';
import 'package:blog_post_flutter/app/data/repository/post/post_repository.dart';
import 'package:blog_post_flutter/app/features/home/controller/comment_controller.dart';
import 'package:blog_post_flutter/app/features/home/controller/post_create_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import '../../../constant/enum_image_type.dart';
import '../../../core/utils/dialog_utils.dart';
import '../../../core/utils/shimmer_utils.dart';
import '../../../data/custom_image_phaser_ob.dart';
import 'package:async/async.dart';

class PostDetailController extends BaseController {
  final PostRepository _repository = Get.find(tag: (PostRepository).toString());
  final CreatePostController postCreateController =
      Get.find<CreatePostController>();

  var postDetail = PostData().obs;
  var virtualPostDetail = PostData();
  late PaginationUtils postPagination = PaginationUtils();
  RxInt likeCount = 0.obs;
  RxBool isLikeAdded = false.obs;
  RxBool isSaved = false.obs;
  int? postId;
  var profileDetail = ProfileOb().obs;
  RestartableTimer _toggleLikeTimer =
      RestartableTimer(Duration.zero, () => null);
  RestartableTimer _toggleSaveTimer =
      RestartableTimer(Duration.zero, () => null);
  late ScrollController buttonController;
  var isVisible = true.obs;

  @override
  void onInit() {
    super.onInit();
    var post = Get.arguments;
    postId = post.id;
    // isLikeAdded.value = postDetail.value.isLiked!;
    // isSaved.value = postDetail.value.isSaved!;
    // likeCount.value = postDetail.value.likeCounts!;
    if (postId != null) getPostDetail(postId!);

    isVisible.value = true;
    buttonController = ScrollController();
    buttonController.addListener(() {
      if (buttonController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (isVisible.value == true) {
          isVisible.value = false;
        }
      } else {
        if (buttonController.position.userScrollDirection ==
            ScrollDirection.forward) {
          if (isVisible.value == false) {
            isVisible.value = true;
          }
        }
      }

      if (buttonController.position.pixels == 0) {
        isVisible.value = true;
      }
    });
  }

  //Get Post Detail
  void getPostDetail(int _postId) async {
    postId = _postId;
    final repoService = _repository.getPostDetail(postId);

    await callAPIService(
      repoService,
      onStart: postDetail.value.id == null
          ? () => showLoading(shimmerEffect: ShimmerUtils.postDetail)
          : null,
      onSuccess: _handleResponseSuccess,
      onError: _handleResponseError,
    );
  }

  void _handleResponseSuccess(response) async {
    if (response != null) {
      BaseApiResponse<PostData?> _orderDetailData = response;
      PostData data = _orderDetailData.objectResult;
      postDetail.value = data;
      likeCount.value = postDetail.value.likeCounts!;
      if (postDetail.value.isLiked == true) {
        isLikeAdded.value = true;
      } else {
        isLikeAdded.value = false;
      }
      if (postDetail.value.isSaved == true) {
        isSaved.value = true;
      } else {
        isSaved.value = false;
      }
    }
  }

  void _handleResponseError(Exception exception) {
    AppUtils.showToast(errorMessage);
  }

  //Toggle Like Post
  void toggleLikePost() {
    isLikeAdded.value = !isLikeAdded.value;
    if (isLikeAdded.value) {
      likeCount = likeCount + 1;
    } else {
      likeCount = likeCount - 1;
    }
    if (isLikeAdded.value != postDetail.value.isLiked!) {
      toggleLikeTimer(() {
        if (GlobalVariable.token != null) {
          late Future<BaseApiResponse<String?>> repoService;
          repoService = _repository.toggleLikePost(postDetail.value.id);
          callAPIService(repoService, onSuccess: (dynamic response) {
            if (response != null) {
              BaseApiResponse<String?> _baseApiResponse = response;
              //AppUtils.showToast(" ${_baseApiResponse.message}");
              postDetail.value.isLiked = isLikeAdded.value;
            }
          }, onError: (Exception exception) {
            AppUtils.showToast(errorMessage);
          });
        } else {
          Get.toNamed(Paths.LOGIN);
        }
      });
    } else {
      _toggleLikeTimer.cancel();
    }
  }

  void toggleLikeTimer(Function onTimerStart) {
    _toggleLikeTimer.cancel();
    Duration _timerDuration = const Duration(seconds: 3);
    _toggleLikeTimer = RestartableTimer(
      _timerDuration,
      () {
        onTimerStart();
      },
    );
    _toggleLikeTimer.reset();
  }

  void toggleSaveTimer(Function onTimerStart) {
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
  void toggleSavePost() {
    isSaved.value = !isSaved.value;
    if (isSaved.value != postDetail.value.isSaved!) {
      toggleSaveTimer(() {
        if (GlobalVariable.token != null) {
          late Future<BaseApiResponse<String?>> repoService;
          repoService = _repository.toggleSavePost(postDetail.value.id);
          callAPIService(repoService, onSuccess: (dynamic response) {
            if (response != null) {
              BaseApiResponse<String?> _baseApiResponse = response;
              AppUtils.showToast(" ${_baseApiResponse.message}");
              postDetail.value.isSaved = isSaved.value;
            }
          }, onError: (Exception exception) {
            AppUtils.showToast(errorMessage);
          });
        } else {
          Get.toNamed(Paths.LOGIN);
        }
      });
    } else {
      _toggleSaveTimer.cancel();
    }
  }

  //Fetch Profile
  void fetchProfile(int profileId) async {
    Get.toNamed(Paths.OTHER_PROFILE);
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

  void editPost() {
    postCreateController.titleController.text = postDetail.value.title!;
    postCreateController.descriptionController.text = postDetail.value.content!;
    if (postDetail.value.image != null) {
      // CustomImagePhaserOb customImagePhaserOb = CustomImagePhaserOb();
      // customImagePhaserOb.image = postDetail.value.image;
      // customImagePhaserOb.type = ImageType.networkImage;
      postCreateController.postImage.value = CustomImagePhaserOb(
          image: postDetail.value.image, type: ImageType.networkImage);
    }
    postCreateController.postId = postDetail.value.id!;
    Get.back();
    Get.toNamed(Paths.POST_CREATE)?.then((value) async {
      postCreateController.titleController.clear();
      postCreateController.descriptionController.clear();
    });
  }

  void confirmDelete() {
    Get.back();
    DialogUtils.showPromptDialog(
        okBtnFunction: deletePost,
        content: 'Are you Sure to delete this post ?');
  }

  void deletePost() {
    late Future<BaseApiResponse<String?>> repoService;
    Get.back();
    AppUtils.showLoaderDialog();

    repoService = _repository.deletePost(postId);

    callAPIService(repoService, onSuccess: (dynamic response) {
      if (response != null) {
        Get.back();
        BaseApiResponse<String?> _baseApiResponse = response;
        Get.offAllNamed(Paths.MAIN_HOME);
        AppUtils.showToast(" ${_baseApiResponse.message}");
      }
    }, onError: (Exception exception) {
      Get.back();
      AppUtils.showToast(errorMessage);
    });
  }

  void onCmtTap() {
    Get.toNamed(Paths.COMMENT, arguments: {
      'commentList': postDetail.value.comments!,
      'postId': postDetail.value.id!,
    })?.then((result) => getPostDetail(postId!));
  }
}
