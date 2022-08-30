import 'package:blog_post_flutter/app/constant/app_colors.dart';
import 'package:blog_post_flutter/app/constant/view_state.dart';
import 'package:blog_post_flutter/app/core/base/base_controller.dart';
import 'package:blog_post_flutter/app/core/loading.dart';
import 'package:blog_post_flutter/app/widget/error_handling_widget.dart';
import 'package:blog_post_flutter/app/widget/text_view_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

abstract class BaseView<Controller extends BaseController>
    extends GetView<Controller> {
  final GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();

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

  BaseView({Key? key}) : super(key: key);

  Widget body(BuildContext context);

  PreferredSizeWidget? appBar(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBackgroundColor(),
      key: globalKey,
      appBar: appBar(context),
      floatingActionButton: floatingActionButton(),
      floatingActionButtonLocation: floatingActionButtonLocation(),
      bottomNavigationBar: bottomNavigationBar(),
      body: Stack(
        children: [
          body(context),
          Center(
            child: Obx(
              () => getErrorHandlingView(controller.pageState),
            ),
          ),
        ],
      ),
    );
  }

  Widget showErrorSnackBar(String message) {
    final snackBar = SnackBar(content: Text(message));
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
    });

    return Container();
  }

  void showToast(String message) {
    Fluttertoast.showToast(
        msg: message, toastLength: Toast.LENGTH_SHORT, timeInSecForIosWeb: 1);
  }

  Color pageBackgroundColor() {
    return AppColors.pageBackground;
  }

  Color statusBarColor() {
    return AppColors.pageBackground;
  }

  Widget? floatingActionButton() {
    return null;
  }

  FloatingActionButtonLocation? floatingActionButtonLocation() {
    return null;
  }

  Widget? bottomNavigationBar() {
    return null;
  }

  Widget? drawer() {
    return null;
  }

  Widget showLoading(Widget? shimmer) {
    return Loading(shimmerEffect: shimmer);
  }

  Widget getErrorHandlingView(PageStateHandler pageState) {
    print("PageState ${controller.pageState.viewState}");
    switch (pageState.viewState) {
      case ViewState.EMPTYLIST:
        return ErrorHandlingWidget(
          message: pageState.message ?? "No Data Found",
          onClickTryAgain: pageState.onClickTryAgain,
        );
      case ViewState.DEFAULT:
        return const SizedBox();
      case ViewState.LOADING:
        return showLoading(pageState.shimmerEffect);
      case ViewState.SUCCESS:
        return const SizedBox();
      case ViewState.FAILED:
        return ErrorHandlingWidget(
          message: controller.errorMessage,
          onClickTryAgain: pageState.onClickTryAgain,
        );
      case ViewState.UPDATED:
        return const SizedBox();
      case ViewState.CREATED:
        return const SizedBox();
      case ViewState.NO_INTERNET:
        return const TextViewWidget("No Internet");
      case ViewState.MESSAGE:
        return const SizedBox();
      case ViewState.UNAUTHORIZED:
        return const SizedBox();
      case ViewState.INITIAL:
        return const SizedBox();
    }
  }
}
