import 'package:get/get.dart';
import 'package:path_app/features/leaderboard/controllers/leaderboard_controller.dart';

class LeaderboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LeaderboardController>(() => LeaderboardController());
  }
}

