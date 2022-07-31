import 'dart:async';
import 'dart:io';

import 'package:blog_post_flutter/app/constant/routing/app_routes.dart';
import 'package:blog_post_flutter/app/core/utils/app_utils.dart';
import 'package:blog_post_flutter/app/data/local/cache_manager.dart';
import 'package:blog_post_flutter/app/data/network/exception/api_exception.dart';
import 'package:blog_post_flutter/app/data/network/exception/app_exception.dart';
import 'package:blog_post_flutter/app/data/network/exception/network_exception.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'exception/not_found_exception.dart';
import 'exception/service_unavailable_exception.dart';


Exception handleError(String error) {
  final Logger logger = Logger(
    printer: PrettyPrinter(
        methodCount: 8,
        // number of method calls to be displayed
        errorMethodCount: 12,
        // number of method calls if stacktrace is provided
        lineLength: 120,
        // width of the output
        colors: true,
        // Colorful log messages
        printEmojis: true,
        // Print an emoji for each log message
        printTime: false // Should each log print contain a timestamp
    ),
  );
  logger.e("Generic exception: $error");

  return AppException(message: error);
}

Exception handleDioError(DioError dioError) {
  switch (dioError.type) {
    case DioErrorType.cancel:
      return AppException(message: "Request to API server was cancelled");
    case DioErrorType.connectTimeout:
      return AppException(message: "Connection timeout with API server");
    case DioErrorType.other:
      return NetworkException("There is no internet connection");
    case DioErrorType.receiveTimeout:
      return TimeoutException("Receive timeout in connection with API server");
    case DioErrorType.sendTimeout:
      return TimeoutException("Send timeout in connection with API server");
    case DioErrorType.response:
      return _parseDioErrorResponse(dioError);
  }
}

 _parseDioErrorResponse(DioError dioError) {
  final Logger logger = Logger(
    printer: PrettyPrinter(
        methodCount: 8,
        // number of method calls to be displayed
        errorMethodCount: 12,
        // number of method calls if stacktrace is provided
        lineLength: 120,
        // width of the output
        colors: true,
        // Colorful log messages
        printEmojis: true,
        // Print an emoji for each log message
        printTime: false // Should each log print contain a timestamp
    ),
  );

  int statusCode = dioError.response?.statusCode ?? -1;
  String? serverMessage;
  try {
    if (statusCode == -1 || statusCode == HttpStatus.ok) {
      statusCode = dioError.response?.data["status_code"];
    } else if (dioError.response?.data["status_code"] == 40101 ||
        dioError.response?.data["status_code"] == 40102 ||
        dioError.response?.data["status_code"] == 401) {
      Get.find<CacheManager>().clearAllData();
      AppUtils.showToast("Unauthorized: Please login again");
      Get.offAllNamed(
        Paths.LOGIN,
      );
    }
    serverMessage = dioError.response?.data["message"];
  } catch (e, s) {
    logger.i("$e");
    logger.i(s.toString());

    serverMessage = "Something went wrong. Please try again later.";
  }

  switch (statusCode) {
    case HttpStatus.serviceUnavailable:
      return ServiceUnavailableException("Service Temporarily Unavailable");
    case HttpStatus.notFound:
      return NotFoundException(serverMessage ?? "", "Not Found");
    default:
      return ApiException(
        httpCode: statusCode,
        status: "Not found",
        message: serverMessage ?? "",
      );
  }
}
