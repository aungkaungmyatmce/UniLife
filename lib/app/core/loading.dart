import 'package:blog_post_flutter/app/constant/app_colors.dart';
import 'package:flutter/material.dart';


class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Container(
        padding: const EdgeInsets.all(12),
        child: const CircularProgressIndicator(
          color: AppColors.primaryColor,
        ),
      ),
    );
  }
}
