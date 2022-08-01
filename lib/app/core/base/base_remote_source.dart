import 'package:blog_post_flutter/app/data/network/error_handlers.dart';
import 'package:blog_post_flutter/app/data/network/services/dio_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:logger/logger.dart';

import '../../data/network/exception/base_exception.dart';

abstract class BaseRemoteSource  {
  Dio get dioClient => DioProvider.dioWithHeaderToken;

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

  Future<Response<T>> callApiWithErrorParser<T>(Future<Response<T>> api) async {
    try {
      Response<T> response = await api;

      if (response.statusCode != HttpStatus.ok ||
          (response.data as Map<String, dynamic>)['status_code'] !=
              HttpStatus.ok) {
        // TODO
      }

      return response;
    } on DioError catch (dioError) {
      Exception exception = handleDioError(dioError);
      if (kDebugMode) {
        print(
          "Throwing error from repository: >>>>>>> $exception : ${(exception as BaseException).message}");
      }
      throw exception;
    } catch (error) {
      if (kDebugMode) {
        print("Generic error: >>>>>>> $error");
      }

      if (error is BaseException) {
        rethrow;
      }

      throw handleError("$error");
    }
  }
}
