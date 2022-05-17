class ReturnObject{
  Success? success;
  Failure? failure;
  ReturnObject({this.success,this.failure});
}

class Success<T>{
  T? successObject;
  List<T>? successList;
  String? message;
  bool? status;
  Success({this.successObject,this.successList,this.message,this.status});
}

class Failure{
  String? errorMessage;
  Failure({this.errorMessage});
}
