import 'package:flutter/material.dart';

import '../../../constant/app_colors.dart';
import '../../../constant/app_dimens.dart';
import '../../../widget/text_view_widget.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: const [
            SizedBox(height: 40),
            TextViewWidget(
              'Notifications',
              textSize: AppDimens.TEXT_HEADING_1X,
              textColor: AppColors.primaryTextColor,
            ),
            SizedBox(
              height: 100,
            ),
            TextViewWidget(
              'Coming Soon...',
              textSize: AppDimens.TEXT_HEADING_1X,
              textColor: AppColors.primaryTextColor,
            ),
          ],
        ),
      ),
    );
  }
}
