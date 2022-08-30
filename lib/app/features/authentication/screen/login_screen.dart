import 'package:blog_post_flutter/app/constant/app_colors.dart';
import 'package:blog_post_flutter/app/constant/app_dimens.dart';
import 'package:blog_post_flutter/app/core/base/base_view.dart';
import 'package:blog_post_flutter/app/features/authentication/controller/authentication_controller.dart';
import 'package:blog_post_flutter/app/widget/signInUpLogoWidget.dart';
import 'package:blog_post_flutter/app/widget/text_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends BaseView<AuthenticationController> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    // return AppBar(
    //   centerTitle: true,
    //   backgroundColor: AppColors.primaryColor,
    //   title: const TextViewWidget(
    //     'Login',
    //     textSize: AppDimens.TEXT_HEADING_1X,
    //     textColor: Colors.black,
    //   ),
    // );
    return null;
  }

  @override
  Widget body(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            child: Form(
                key: controller.loginFormKey,
                child: Obx(() => Column(children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: TextFormField(
                          controller: controller.loginUserNameController.value,
                          decoration: InputDecoration(
                            enabledBorder: const UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppColors.primaryColor),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppColors.primaryColor),
                            ),
                            labelStyle: const TextStyle(
                                color: AppColors.primaryTextColor),
                            labelText: 'Username',
                            suffixIcon:
                                controller.loginUserName.value.isNotEmpty
                                    ? const Icon(
                                        Icons.done,
                                        color: AppColors.primaryColor,
                                      )
                                    : const SizedBox(),
                          ),
                          onChanged: (String value) {
                            controller.loginUserName.value = value;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: TextFormField(
                          controller: controller.loginPasswordController.value,
                          obscureText: !controller.showLoginPassword.value,
                          decoration: InputDecoration(
                            enabledBorder: const UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppColors.primaryColor),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppColors.primaryColor),
                            ),
                            labelStyle: const TextStyle(
                                color: AppColors.primaryTextColor),
                            labelText: 'Password',
                            // enabledBorder: const UnderlineInputBorder(
                            //   borderSide: BorderSide(color: Color(0xffF6B90A)),
                            // ),
                            suffixIcon: IconButton(
                              onPressed: () =>
                                  controller.showHideLoginPassword(),
                              icon: Icon(
                                controller.showLoginPassword.value
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]))),
          ),
          // Center(
          //   child: Padding(
          //     padding: const EdgeInsets.only(top: 25),
          //     child: TextButton(
          //       onPressed: () {},
          //       child: const Text(
          //         'Forgot Password?',
          //         style: TextStyle(
          //             fontFamily: 'Roboto',
          //             fontSize: 14,
          //             color: Color(0xffB9B9B9)),
          //       ),
          //     ),
          //   ),
          // ),

          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color(0xffF2F2F2)),
                    alignment: Alignment.center,
                    fixedSize:
                        MaterialStateProperty.all(const Size.square(60))),
                onPressed: () => controller.doLogin(),
                child: const Icon(
                  Icons.arrow_forward_sharp,
                  size: 40,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const TextViewWidget(
                    "Don't have an account? ",
                    textSize: 14,
                    textColor: AppColors.primaryTextColor,
                  ),
                  TextButton(
                      onPressed: () => Get.back(),
                      child: const TextViewWidget(
                        "Sign Up",
                        textDecoration: TextDecoration.underline,
                        textSize: 14,
                        textColor: AppColors.primaryColor,
                      )),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
