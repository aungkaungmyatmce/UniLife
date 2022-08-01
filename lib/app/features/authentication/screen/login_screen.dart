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
    return AppBar(
      centerTitle: true,
      title: const TextViewWidget(
        'Login',
        textSize: AppDimens.TEXT_REGULAR_2X,
        textColor: AppColors.whiteColor,
      ),
    );
  }

  @override
  Widget body(BuildContext context) {
    return SingleChildScrollView(
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
                          labelText: 'Username',
                          suffixIcon: controller.loginUserName.value.isNotEmpty
                              ? const Icon(
                                  Icons.done,
                                  color: Color(0xff4135F3),
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
                          labelText: 'Password',
                          // enabledBorder: const UnderlineInputBorder(
                          //   borderSide: BorderSide(color: Color(0xffF6B90A)),
                          // ),
                          suffixIcon: IconButton(
                            onPressed: () => controller.showHideLoginPassword(),
                            icon: Icon(
                              controller.showLoginPassword.value
                                  ? Icons.visibility
                                  : Icons.visibility_off,
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
            padding: const EdgeInsets.only(top: 5),
            child: TextButton(
                onPressed: () => Get.back(),
                child: const TextViewWidget(
                  "Create account",
                  textSize: 14,
                  textColor: Color(0xffB9B9B9),
                )),
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(const Color(0xffF2F2F2)),
                  alignment: Alignment.center,
                  fixedSize: MaterialStateProperty.all(const Size.square(60))),
              onPressed: () => controller.doLogin(),
              child: const Icon(
                Icons.arrow_forward_sharp,
                size: 40,
                color: Colors.black87,
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
