import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_app/core/constants/app_images.dart';

/// Animated vehicle marker placed on the cosmic path at the user's current rank.
class RoadVehicleMarker extends StatefulWidget {
  final String carId;
  final VoidCallback onTap;

  const RoadVehicleMarker({
    super.key,
    required this.carId,
    required this.onTap,
  });

  @override
  State<RoadVehicleMarker> createState() => _RoadVehicleMarkerState();
}

class _RoadVehicleMarkerState extends State<RoadVehicleMarker>
    with SingleTickerProviderStateMixin {
  late final AnimationController _hoverCtrl;

  @override
  void initState() {
    super.initState();
    _hoverCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _hoverCtrl.dispose();
    super.dispose();
  }

  String _resolveCarAsset() {
    switch (widget.carId) {
      case 'purple_hover_car':
        return AppImages.purpleHoverCar;
      case 'space_ufo':
        return AppImages.spaceUfo;
      case 'space_rocket_1':
        return AppImages.spaceRocket1;
      case 'space_rocket_2':
        return AppImages.spaceRocket2;
      case 'space_rocket_3':
        return AppImages.spaceRocket3;
      case 'space_rocket_4':
        return AppImages.spaceRocket4;
      case 'space_saucer_2':
        return AppImages.spaceSaucer2;
      case 'space_saucer_3':
        return AppImages.spaceSaucer3;
      case 'space_saucer_4':
        return AppImages.spaceSaucer4;
      case 'yellow_hover_car':
      default:
        return AppImages.yellowHoverCar;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: _hoverCtrl,
        builder: (context, child) {
          final dy = math.sin(_hoverCtrl.value * math.pi) * 4.0;
          return Transform.translate(
            offset: Offset(0, dy),
            child: child,
          );
        },
        child: Container(
          width: 78.w,
          height: 116.h,
          alignment: Alignment.center,
          child: Image.asset(
            _resolveCarAsset(),
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
