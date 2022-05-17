import 'package:blog_post_flutter/app/constant/app_colors.dart';
import 'package:blog_post_flutter/app/core/config/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PrimaryButton extends StatelessWidget {
  final String buttonText;
  final Function onTabMovie;
  final double buttonTextPadding;

  const PrimaryButton(this.buttonText, this.onTabMovie,
      {this.buttonTextPadding = 0.0});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: flatButtonStyle,
      onPressed: () {
        onTabMovie();
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: buttonTextPadding),
        child: Text(
          buttonText.tr,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

final ButtonStyle flatButtonStyle = TextButton.styleFrom(
  minimumSize: Size(Get.width, SizeConfig.margin8dp! * 6),
  padding: EdgeInsets.symmetric(horizontal: SizeConfig.margin8dp! * 2),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(
     4,
    )),
  ),
  primary: AppColors.primaryColor,
  backgroundColor: AppColors.primaryColor,
);
