import 'package:get/get.dart';

class OnboardingController extends GetxController {
  var currentStep = 1.obs;
  var selectedIndex = 0.obs;

  List<Map<String, String>> options = [
    {'title': 'Driver', 'subtitle': 'Drive and earn'},
    {'title': 'Rider', 'subtitle': 'Book rides'},
  ];

  void select(int index) {
    selectedIndex.value = index;
  }
}