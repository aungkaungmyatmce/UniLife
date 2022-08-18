import 'package:get/get.dart';

class MainHomeController extends GetxController {
  RxInt selectedPage = 0.obs;

  void setSelectedIndex(int index) {
    selectedPage.value = index;
    print("Selected Index is ${selectedPage.value}");
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
}
