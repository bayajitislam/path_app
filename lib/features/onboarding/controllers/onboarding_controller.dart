import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class OnboardingController extends GetxController {
  final PageController pageController = PageController();
  final RxInt currentStep = 1.obs;
  final RxInt selectedIndex = 0.obs;
  final RxString selectedCountry = ''.obs;

  final List<Map<String, String>> options = const [
    {'title': 'Driver', 'subtitle': 'Drive and earn'},
    {'title': 'Rider', 'subtitle': 'Book rides'},
  ];

  void select(int index) {
    selectedIndex.value = index;
  }

  void setCountry(String country) {
    selectedCountry.value = country;
  }

  void nextPage() {
    if (currentStep.value < 4) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void previousPage() {
    if (currentStep.value > 1) {
      pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
