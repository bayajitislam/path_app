import 'package:get/get.dart';

/// Controller managing the active navigation tab index in BasePage.
class BaseController extends GetxController {
  final RxInt currentIndex = 0.obs;

  void changeIndex(int index) {
    currentIndex.value = index;
  }
}
