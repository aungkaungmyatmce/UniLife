import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'dart:io' as Io;


class AppUtils {
  static void showSnackBar({required String message, required String title}) {
    Get.snackbar(title, message, snackPosition: SnackPosition.BOTTOM);
  }

  static void showToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        fontSize: 16.0);
  }

  static String doEncoding(String? filePath) {
    String _fileName;
    Map<String, String> _paths = {};
    _fileName = filePath != null
        ? filePath.split('/').last
        : filePath != null
        ? _paths.keys.toString()
        : '...';

    print("FILE PATH" + _fileName);
    List<String> fileType;
    String type;
    final bytes = Io.File(filePath!).readAsBytesSync();
    String img64 = base64Encode(bytes);
    fileType = _fileName.split('.');
    type = fileType[1];
    String param = "data:" "image/" + type.toLowerCase() + ";base64";
    return param + ", " + img64;
  }

  static showLoaderDialog({String? title}) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
            margin: const EdgeInsets.only(left: 7),
            child: Text(title ?? "Loading"),
          ),
        ],
      ),
    );
    Get.dialog(alert);
  }

  static hideAlertDialog() {
   Get.back();
  }
}
