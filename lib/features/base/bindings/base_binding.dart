import 'package:get/get.dart';
import 'package:path_app/features/base/controllers/base_controller.dart';
import 'package:path_app/features/leaderboard/controllers/leaderboard_controller.dart';

class BaseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BaseController>(() => BaseController());
    Get.lazyPut<LeaderboardController>(() => LeaderboardController());
  }
}

