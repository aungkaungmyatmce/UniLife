import 'package:blog_post_flutter/app/constant/app_colors.dart';
import 'package:flutter/material.dart';

class RoundedIconWidget extends StatelessWidget {
  final Widget icon;
  final Function onClickIcon;
  final Color splashColor;
  final Color highlightColor;
  final Color backgroundColor;
  final double contentPadding;

  const RoundedIconWidget({
    Key? key,
     required this.icon,
     this.backgroundColor = AppColors.secondaryColor,
     this.splashColor = AppColors.orderVerticalDividerColor,
     this.highlightColor = AppColors.orderVerticalDividerColor,
     this.contentPadding = 12.0,
    required this.onClickIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      onPressed: ()=> onClickIcon(),
      elevation: 0,
      constraints: const BoxConstraints(), //removes empty spaces around of icon
      shape: const CircleBorder(), //circular button
      splashColor: splashColor,
      highlightColor: highlightColor ,
      highlightElevation: 0,
      fillColor: backgroundColor,
      child: icon,
      padding:  EdgeInsets.all(contentPadding),
    );
  }
}
