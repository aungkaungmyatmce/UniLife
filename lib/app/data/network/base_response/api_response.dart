import 'object_response.dart';

class ApiResponse<T> {
  Status? status;
  Success? successData;
  String? message;

  ApiResponse.initial(this.message) : status = Status.INITIAL;

  ApiResponse.loading(this.message) : status = Status.LOADING;

  ApiResponse.completed(this.successData) : status = Status.COMPLETED;

  ApiResponse.error(this.message) : status = Status.ERROR;

  @override
  String toString() {
    return message!;
  }
}

enum Status { INITIAL, LOADING, COMPLETED, ERROR }
