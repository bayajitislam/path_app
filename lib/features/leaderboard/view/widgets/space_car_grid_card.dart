import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_app/features/leaderboard/models/space_car_model.dart';

/// Card widget representing a space car in the vehicle selection grid.
class SpaceCarGridCard extends StatelessWidget {
  final SpaceCarModel car;
  final bool isSelected;
  final VoidCallback onTap;

  const SpaceCarGridCard({
    super.key,
    required this.car,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: car.isUnlocked ? onTap : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        padding: EdgeInsets.all(12.r),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF0F263A).withValues(alpha: 0.85)
              : const Color(0xFF0D1527).withValues(alpha: 0.65),
          borderRadius: BorderRadius.circular(18.r),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF00E5FF)
                : Colors.white.withValues(alpha: 0.12),
            width: isSelected ? 2.0 : 1.0,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: const Color(0xFF00E5FF).withValues(alpha: 0.35),
                    blurRadius: 14,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.25),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: Stack(
          children: [
            // Selected Radio Dot Indicator
            if (isSelected)
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  width: 14.r,
                  height: 14.r,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF00E5FF),
                  ),
                  child: Center(
                    child: Container(
                      width: 6.r,
                      height: 6.r,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),

            // Card Body (Vehicle Artwork & Title)
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Opacity(
                          opacity: car.isUnlocked ? 1.0 : 0.35,
                          child: Padding(
                            padding: EdgeInsets.all(4.r),
                            child: Image.asset(
                              car.imagePath,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        if (!car.isUnlocked)
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black.withValues(alpha: 0.6),
                            ),
                            child: const Icon(
                              Icons.lock_rounded,
                              color: Colors.white70,
                              size: 20,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  car.name,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                    color: isSelected ? Colors.white : Colors.white70,
                    letterSpacing: 0.1,
                  ),
                ),
                if (!car.isUnlocked) ...[
                  SizedBox(height: 2.h),
                  Text(
                    '${car.requiredPoints} pts',
                    style: GoogleFonts.inter(
                      fontSize: 10.sp,
                      color: const Color(0xFF7DD3FC),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
