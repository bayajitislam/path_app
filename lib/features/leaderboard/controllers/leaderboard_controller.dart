import 'package:get/get.dart';
import 'package:path_app/features/leaderboard/models/rank_tier_model.dart';
import 'package:path_app/features/leaderboard/models/space_car_model.dart';

/// GetX controller managing Leaderboard state, active space car, and rank tiers.
class LeaderboardController extends GetxController {
  final RxInt selectedTab = 0.obs; // 0 = Career, 1 = Jackpot
  final RxString selectedCarId = 'yellow_hover_car'.obs;
  final RxInt currentPoints = 850.obs;
  final RxInt currentRank = 4.obs; // Dolphin
  final RxBool isLockedMilestoneView = false.obs; // Toggle between Milestone (Locked) View & Rank View

  final List<SpaceCarModel> cars = const [
    SpaceCarModel(
      id: 'yellow_hover_car',
      name: 'Cyber Cruiser',
      imagePath: 'assets/images/yellow_hover_car.png',
      isUnlocked: true,
      requiredPoints: 0,
    ),
    SpaceCarModel(
      id: 'purple_hover_car',
      name: 'Vortex Speeder',
      imagePath: 'assets/images/purple_hover_car.png',
      isUnlocked: true,
      requiredPoints: 200,
    ),
    SpaceCarModel(
      id: 'space_ufo',
      name: 'Lunar Saucer',
      imagePath: 'assets/images/space_ufo.png',
      isUnlocked: true,
      requiredPoints: 400,
    ),
    SpaceCarModel(
      id: 'space_rocket_1',
      name: 'Aero Rocket',
      imagePath: 'assets/images/space_rocket_1.png',
      isUnlocked: true,
      requiredPoints: 600,
    ),
    SpaceCarModel(
      id: 'space_rocket_2',
      name: 'Flame Stalker',
      imagePath: 'assets/images/space_rocket_2.png',
      isUnlocked: true,
      requiredPoints: 800,
    ),
    SpaceCarModel(
      id: 'space_rocket_3',
      name: 'Solar Dart',
      imagePath: 'assets/images/space_rocket_3.png',
      isUnlocked: false,
      requiredPoints: 1000,
    ),
    SpaceCarModel(
      id: 'space_rocket_4',
      name: 'Shadow Striker',
      imagePath: 'assets/images/space_rocket_4.png',
      isUnlocked: false,
      requiredPoints: 1200,
    ),
    SpaceCarModel(
      id: 'space_saucer_2',
      name: 'Astro Tripod',
      imagePath: 'assets/images/space_saucer_2.png',
      isUnlocked: false,
      requiredPoints: 1500,
    ),
    SpaceCarModel(
      id: 'space_saucer_3',
      name: 'Cosmic Dome',
      imagePath: 'assets/images/space_saucer_3.png',
      isUnlocked: false,
      requiredPoints: 1800,
    ),
    SpaceCarModel(
      id: 'space_saucer_4',
      name: 'Crimson Orbit',
      imagePath: 'assets/images/space_saucer_4.png',
      isUnlocked: false,
      requiredPoints: 2000,
    ),
  ];

  SpaceCarModel get activeCar =>
      cars.firstWhere((c) => c.id == selectedCarId.value, orElse: () => cars.first);

  RankTierModel get activeTier =>
      RankTierModel.defaultTiers.firstWhere((t) => t.rank == currentRank.value);

  void selectCar(String id) {
    selectedCarId.value = id;
  }

  void selectTab(int index) {
    selectedTab.value = index;
  }
}
