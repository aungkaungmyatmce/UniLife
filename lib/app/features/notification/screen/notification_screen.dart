import 'package:blog_post_flutter/app/constant/routing/app_routes.dart';
import 'package:blog_post_flutter/app/features/main_home/controller/main_home_controller.dart';
import 'package:flutter/material.dart';

import '../../../constant/app_colors.dart';
import '../../../constant/app_dimens.dart';
import '../../../widget/text_view_widget.dart';
import 'package:get/get.dart';

import '../../main_home/screen/main_home_screen.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({Key? key}) : super(key: key);
  MainHomeController homeController = Get.find<MainHomeController>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        //Get.offAllNamed(Paths.MAIN_HOME, arguments: 0);
        homeController.setSelectedIndex(0);

        return false;
      },
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              SizedBox(height: 50),
              TextViewWidget(
                'Notifications',
                textSize: AppDimens.TEXT_HEADING_1X,
                textColor: AppColors.primaryColor,
              ),
              SizedBox(
                height: 300,
              ),
              TextViewWidget(
                'Coming Soon...',
                textSize: AppDimens.TEXT_HEADING_1X,
                textColor: AppColors.primaryTextColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
