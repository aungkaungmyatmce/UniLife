import 'package:blog_post_flutter/app/constant/app_colors.dart';
import 'package:blog_post_flutter/app/constant/app_dimens.dart';
import 'package:blog_post_flutter/app/core/config/size_config.dart';
import 'package:blog_post_flutter/app/features/authentication/controller/login_controller.dart';
import 'package:blog_post_flutter/app/widget/primary_button_widget.dart';
import 'package:blog_post_flutter/app/widget/show_image_widget.dart';
import 'package:blog_post_flutter/app/widget/text_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Login'),
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              SizedBox(
                height: SizeConfig.screenHeight,
                width: SizeConfig.screenWidth,
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: AppDimens.MARGIN_MEDIUM,
                    ),
                    const TextViewWidget(
                      "Login",
                      textSize: 18,
                      fontWeight: FontWeight.w700,
                      textColor: AppColors.blackColor,
                    ),
                    const SizedBox(
                      height: AppDimens.MARGIN_LARGE,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(
                        AppDimens.MARGIN_MEDIUM_2,
                      ),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            AppDimens.MARGIN_MEDIUM_2,
                          ),
                        ),
                        elevation: 4.0,
                        child: Container(
                          padding: const EdgeInsets.all(
                            AppDimens.MARGIN_MEDIUM_2,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  TextField(
                                    controller: controller.userNameController,
                                    autofocus: false,
                                    decoration: InputDecoration(
                                      enabledBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(AppDimens.MARGIN_MEDIUM),
                                        ),
                                        borderSide: BorderSide(
                                            color: AppColors.spaceWhiteColor),
                                      ),
                                      focusedBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(AppDimens.MARGIN_MEDIUM),
                                        ),
                                        borderSide: BorderSide(
                                            color: AppColors.spaceWhiteColor),
                                      ),
                                      filled: true,
                                      hintStyle: TextStyle(
                                        color: AppColors.textColor.withOpacity(
                                          0.5,
                                        ),
                                        height: 1,
                                      ),
                                      hintText: "Enter username or phone",
                                      contentPadding: const EdgeInsets.all(
                                        AppDimens.MARGIN_CARD_MEDIUM_2,
                                      ),
                                      fillColor: AppColors.spaceWhiteColor,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: AppDimens.MARGIN_CARD_MEDIUM_2,
                                  ),
                                  Obx(() => TextField(
                                    autofocus: false,
                                    obscureText: !controller.showPassword.value,
                                    controller: controller.passwordController,
                                    decoration: InputDecoration(
                                      focusedBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              AppDimens.MARGIN_MEDIUM),
                                        ),
                                        borderSide: BorderSide(
                                            color: AppColors.spaceWhiteColor),
                                      ),
                                      enabledBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              AppDimens.MARGIN_MEDIUM),
                                        ),
                                        borderSide: BorderSide(
                                            color: AppColors.spaceWhiteColor),
                                      ),
                                      filled: true,
                                      hintStyle: TextStyle(
                                        color: AppColors.textColor
                                            .withOpacity(
                                          0.5,
                                        ),
                                        height: 1,
                                      ),
                                      hintText: "Password",
                                      isDense: true,
                                      contentPadding: const EdgeInsets.all(
                                        AppDimens.MARGIN_CARD_MEDIUM_2,
                                      ),
                                      suffixIcon: IconButton(
                                        icon: controller.showPassword.value
                                            ? Icon(
                                          Icons.visibility,
                                          color: AppColors.textColor
                                              .withOpacity(
                                            0.6,
                                          ),
                                        )
                                            : Icon(
                                          Icons.visibility_off,
                                          color: AppColors.textColor
                                              .withOpacity(
                                            0.6,
                                          ),
                                        ),
                                        onPressed: () =>
                                            controller.showHidePassword(),
                                      ),
                                      fillColor: AppColors.spaceWhiteColor,
                                    ),
                                  )),
                                ],
                              ),
                              const SizedBox(
                                height: AppDimens.MARGIN_XLARGE,
                              ),
                              PrimaryButton(
                                "Login",
                                    () => controller.doLogin(),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      // bottomNavigationBar:
    );
  }
}
