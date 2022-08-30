import 'package:blog_post_flutter/app/constant/view_state.dart';
import 'package:blog_post_flutter/app/data/local/cache_manager.dart';
import 'package:blog_post_flutter/app/data/network/exception/base_exception.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../data/network/exception/api_exception.dart';
import '../../data/network/exception/app_exception.dart';
import '../../data/network/exception/json_format_exception.dart';
import '../../data/network/exception/network_exception.dart';
import '../../data/network/exception/not_found_exception.dart';
import '../../data/network/exception/service_unavailable_exception.dart';
import '../../data/network/exception/timeout_exception.dart';
import '../../data/network/exception/unauthorize_exception.dart';

abstract class BaseController extends GetxController
    with CacheManager, GetSingleTickerProviderStateMixin {
  final logoutController = false.obs;

  final Logger logger = Logger(
    printer: PrettyPrinter(
        methodCount: 8,
        // number of method calls to be displayed
        errorMethodCount: 12,
        // number of method calls if stacktrace is provided
        lineLength: 120,
        // width of the output
        colors: true,
        // Colorful log messages
        printEmojis: true,
        // Print an emoji for each log message
        printTime: false // Should each log print contain a timestamp
        ),
  );

  //Reload the page
  RefreshController _refreshController = RefreshController();

  //Controls page state
  final Rx<PageStateHandler> _pageSateController =
      PageStateHandler(ViewState.DEFAULT, () => {}, '', null).obs;

  PageStateHandler get pageState => _pageSateController.value;

  updatePageState(ViewState state,
          {Function? onClickTryAgain,
          String? message,
          Widget? shimmerEffect}) =>
      _pageSateController(
          PageStateHandler(state, onClickTryAgain, message, shimmerEffect));

  resetPageState() => _pageSateController(
      PageStateHandler(ViewState.DEFAULT, () => {}, null, null));

  showLoading({Widget? shimmerEffect}) => updatePageState(ViewState.LOADING,
      onClickTryAgain: () => {}, shimmerEffect: shimmerEffect);

  showEmptyData() =>
      updatePageState(ViewState.EMPTYLIST, onClickTryAgain: () => {});

  dynamic callAPIService<T>(
    Future<T> future, {
    Function(BaseException exception)? onError,
    Function(T response)? onSuccess,
    Function? onStart,
    Function? onComplete,
  }) async {
    onStart != null ? onStart() : null;
    try {
      final T response = await future;
      if (onSuccess != null) onSuccess(response);
      updatePageState(ViewState.SUCCESS);
      return response;
    } on ServiceUnavailableException catch (exception) {
      showErrorMessage_(exception, onError);
    } on UnauthorizedException catch (exception) {
      showErrorMessage_(exception, onError);
    } on TimeoutException catch (exception) {
      showErrorMessage_(exception, onError);
    } on NetworkException catch (exception) {
      showErrorMessage_(exception, onError);
    } on JsonFormatException catch (exception) {
      showErrorMessage_(exception, onError);
    } on NotFoundException catch (exception) {
      showErrorMessage_(exception, onError);
    } on ApiException catch (exception) {
      showErrorMessage_(exception, onError);
    } on AppException catch (exception) {
      showErrorMessage_(exception, onError);
    } catch (error, s) {
      showErrorMessage_(AppException(message: "$error"), onError);
      debugPrint("Controller>>>>>> error $s");
    }
  }

  showErrorMessage_(var exception, onError) {
    _errorMessageController(exception.message);
    onError(exception);
  }

  final _messageController = ''.obs;

  String get message => _messageController.value;

  showMessage(String msg) => _messageController(msg);

  showErrorMessage(String msg) => _errorMessageController(msg);

  showSuccessMessage(String msg) => _successMessageController(msg);

  final RxString _errorMessageController = ''.obs;

  String get errorMessage => _errorMessageController.value;

  final RxString _successMessageController = ''.obs;

  String get successMessage => _messageController.value;

  void setRefreshController(RefreshController? refreshController) {
    _refreshController = refreshController ?? _refreshController;
  }

  void resetRefreshController<T>(RxList<T> dataList) {
    if (_refreshController.isRefresh) {
      dataList.clear();
      _refreshController.refreshCompleted();
    }
    if (_refreshController.isLoading) {
      _refreshController.loadComplete();
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    _messageController.close();
    //_refreshController.close();
    _pageSateController.close();
    super.onClose();
  }
}

class PageStateHandler {
  final ViewState viewState;
  final Function? onClickTryAgain;
  final String? message;
  final Widget? shimmerEffect;

  PageStateHandler(
    this.viewState,
    this.onClickTryAgain,
    this.message,
    this.shimmerEffect,
  );
}
