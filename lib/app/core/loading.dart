import 'package:blog_post_flutter/app/constant/app_colors.dart';
import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key, this.shimmerEffect}) : super(key: key);
  final Widget? shimmerEffect;

  @override
  Widget build(BuildContext context) {
    if (shimmerEffect != null) {
      return shimmerEffect!;
    }
    return Center(
      child: Container(
        padding: const EdgeInsets.all(12),
        child: const CircularProgressIndicator(
          color: AppColors.primaryColor,
        ),
      ),
    );
  }
}
