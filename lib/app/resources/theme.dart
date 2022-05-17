import 'package:blog_post_flutter/app/constant/app_colors.dart';
import 'package:blog_post_flutter/app/widget/custom_tab_indicator_widget.dart';
import 'package:flutter/material.dart';

MaterialColor primaryColor = const MaterialColor(
  0xFF2B4CD2,
  <int, Color>{
    50: Color(0x1aff6e66),
    100: Color(0xa1ff6e66),
    200: Color(0xaaff6e66),
    300: Color(0xafff6e66),
    400: Color(0xffff6e66),
    500: Color(0xffff6e66),
    600: Color(0xffff6e66),
    700: Color(0xffff6e66),
    800: Color(0xffff6e66),
    900: Color(0xffff6e66)
  },
);

ThemeData lightTheme() => ThemeData(
    primarySwatch: primaryColor,
    colorScheme: const ColorScheme.light(brightness: Brightness.light),
    primaryColor: primaryColor,
    appBarTheme: AppBarTheme(backgroundColor: primaryColor),
    canvasColor: Colors.white,
    scaffoldBackgroundColor: AppColors.pageBackground,
    tabBarTheme: const TabBarTheme(
      labelColor: AppColors.whiteColor,
      unselectedLabelColor: AppColors.grayColor, // color for text
      indicator: CustomTabIndicator(),
    ),
    iconTheme: IconThemeData(color: primaryColor));
