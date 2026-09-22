import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:path_app/core/constants/app_images.dart';
import 'package:path_app/core/theme/app_pallete.dart';
import 'package:path_app/core/widgets/primary_button.dart';
import 'package:path_app/core/widgets/secondary_app_bar.dart';
import 'package:path_app/features/leaderboard/controllers/leaderboard_controller.dart';
import 'package:path_app/features/leaderboard/view/widgets/space_car_grid_card.dart';

/// Screen allowing players to choose their space vehicle displayed on the career leaderboard.
class SelectSpaceCarPage extends StatelessWidget {
  const SelectSpaceCarPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.isRegistered<LeaderboardController>()
        ? Get.find<LeaderboardController>()
        : Get.put(LeaderboardController());

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Cosmic Wallpaper
          Image.asset(AppImages.cosmicStarfieldBg, fit: BoxFit.cover),

          // Translucent gradient overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.6),
                  Colors.black.withValues(alpha: 0.3),
                  Colors.black.withValues(alpha: 0.8),
                ],
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                // Top App Bar
                SecondaryAppBar(
                  title: "Select Space Car",
                  titleColor: AppPallete.secondary,
                  backButtonColor: AppPallete.secondary,
                ),

                SizedBox(height: 8.h),

                // Vehicle Grid
                Expanded(
                  child: GridView.builder(
                    padding: EdgeInsets.symmetric(
                      horizontal: 18.w,
                      vertical: 8.h,
                    ),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 14.w,
                      mainAxisSpacing: 14.h,
                      childAspectRatio: 1.15,
                    ),
                    itemCount: controller.cars.length,
                    itemBuilder: (context, index) {
                      final car = controller.cars[index];

                      return Obx(() {
                        final isSelected =
                            controller.selectedCarId.value == car.id;

                        return SpaceCarGridCard(
                          car: car,
                          isSelected: isSelected,
                          onTap: () {
                            controller.selectCar(car.id);
                          },
                        );
                      });
                    },
                  ),
                ),

                // Bottom Action
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 16.h,
                  ),
                  child: PrimaryButton(
                    buttonName: 'Equip Space Car',
                    onPressed: () => Get.back(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
