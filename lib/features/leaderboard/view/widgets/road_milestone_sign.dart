import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_app/core/constants/app_images.dart';

/// Green circular signboard milestone marker indicating point thresholds along the cosmic road.
class RoadMilestoneSign extends StatelessWidget {
  final int points;
  final VoidCallback? onTap;

  const RoadMilestoneSign({
    super.key,
    required this.points,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Green Circular 3D Signpost Image
          Image.asset(
            AppImages.roadSign,
            width: 46.r,
            height: 46.r,
            fit: BoxFit.contain,
          ),

          SizedBox(height: 3.h),

          // Point Label
          Text(
            '$points pts',
            style: GoogleFonts.inter(
              fontSize: 11.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              shadows: [
                Shadow(
                  color: Colors.black.withValues(alpha: 0.9),
                  blurRadius: 4,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
