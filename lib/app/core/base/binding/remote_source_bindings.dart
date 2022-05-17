
import 'package:get/get.dart';


class RemoteSourceBindings implements Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<AuthRepository>(
    //   () => AuthRepositoryImpl(),
    //   tag: (AuthRepository).toString(),
    // );
  }
}
