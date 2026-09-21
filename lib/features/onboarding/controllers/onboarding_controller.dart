import 'package:get/get.dart';

class OnboardingController extends GetxController {
  var currentStep = 1.obs;
  var selectedIndex = 0.obs;
  var selectedCountry = ''.obs;

  List<Map<String, String>> options = [
    {'title': 'Driver', 'subtitle': 'Drive and earn'},
    {'title': 'Rider', 'subtitle': 'Book rides'},
  ];

  void select(int index) {
    selectedIndex.value = index;
  }

  void setCountry(String country) {
    selectedCountry.value = country;
  }
}
