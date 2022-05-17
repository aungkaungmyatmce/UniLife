import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SizeConfig {
  static double? screenWidth;
  static double? screenHeight;
  static double? blockSizeHorizontal;
  static double? blockSizeVertical;

  static double? margin1dp;
  static double? margin2dp;
  static double? margin4dp;
  static double? margin5dp;
  static double? margin8dp;
  static double? margin10dp;
  static double? margin12dp;
  static double? margin16dp;
  static double? margin20dp;
  static double? margin32dp;
  static double? margin30dp;
  static double? margin80dp;

  void init() {
    screenWidth = Get.width;
    screenHeight = Get.height;
    blockSizeHorizontal = (screenWidth! / 100);
    blockSizeVertical = screenHeight! / 100;

    //Just make a computation base sizing sample
    margin1dp = Get.pixelRatio * 0.45;
    margin2dp = Get.pixelRatio * 0.9;
    margin4dp = Get.pixelRatio * 1.8;
    margin8dp = Get.pixelRatio * 2.7;
    margin10dp = Get.pixelRatio * 3.6;
    margin12dp = margin4dp! * 3;

    // Now we can customize as we want base on above sizing
    margin5dp = margin4dp! + margin1dp!;
    margin16dp = margin8dp! * 2;
    margin20dp = margin10dp! * 2;
    margin30dp = margin10dp! * 3;
    margin32dp = margin16dp! * 2;
    margin12dp = margin16dp! - margin4dp!;
    margin80dp = margin30dp! + margin30dp! + margin20dp!;
  }
}
