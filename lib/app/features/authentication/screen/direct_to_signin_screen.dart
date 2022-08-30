import 'package:blog_post_flutter/app/constant/app_colors.dart';
import 'package:blog_post_flutter/app/constant/app_dimens.dart';
import 'package:blog_post_flutter/app/widget/text_view_widget.dart';
import 'package:flutter/material.dart';
import '../../../constant/routing/app_routes.dart';
import '../../../widget/signInUpLogoWidget.dart';
import 'package:get/get.dart';

class DirectToSignInScreen extends StatelessWidget {
  const DirectToSignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: Column(
          children: [
            Stack(
              children: [
                SignInUpLogoWidget(width: MediaQuery.of(context).size.width),
                Positioned(
                    top: 120,
                    left: MediaQuery.of(context).size.width * 0.3,
                    child: const TextViewWidget(
                      "UniLife",
                      textSize: 60,
                      textColor: AppColors.secondaryTextColor,
                    )),
              ],
            ),
            const SizedBox(height: 70),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: TextViewWidget(
                'To create a post, you need to Signup first!',
                textSize: AppDimens.TEXT_REGULAR_2,
                textColor: AppColors.primaryTextColor,
              ),
            ),
            TextButton(
              onPressed: () => Get.toNamed(Paths.SIGN_UP),
              child: const TextViewWidget(
                'Signup',
                textDecoration: TextDecoration.underline,
                textSize: AppDimens.TEXT_REGULAR_2,
                textColor: AppColors.primaryColor,
              ),
            )
          ],
        ),
      ),
    ));
  }
}
