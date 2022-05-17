import 'package:blog_post_flutter/app/constant/app_colors.dart';
import 'package:blog_post_flutter/app/widget/text_view_widget.dart';
import 'package:flutter/material.dart';

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackArrow;
  final bool isCenterTitle;
  final BuildContext? context;
  final double height;
  final double elevation;
  final IconData? trillingIcon;
  final Function? trillingIconOnClick;
  final Color backgroundColor;

  const DefaultAppBar(
      {Key? key,
      required this.title,
      this.showBackArrow = true,
      this.isCenterTitle = false,
      this.context,
      this.backgroundColor = AppColors.primaryColor,
      this.height = 50,
      this.trillingIcon,
      this.trillingIconOnClick,
      this.elevation = 1.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(50.0),
      child: AppBar(
        title: TextViewWidget(
          title,
          textColor: AppColors.whiteColor,
          textSize: 18,
        ),
        backgroundColor: backgroundColor,
        automaticallyImplyLeading: showBackArrow,
        elevation: elevation,
        centerTitle: isCenterTitle,
        actions: [
          trillingIcon != null
              ? IconButton(
                  onPressed: () => trillingIconOnClick!(),
                  icon: Icon(trillingIcon))
              : const SizedBox()
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
