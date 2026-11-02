import 'package:flutter/material.dart';
import 'package:path_app/core/theme/app_pallete.dart';
import 'package:path_app/core/theme/app_text_style.dart';

class HostMatchDurationCard extends StatelessWidget {
  final int hours;
  final int minHours;
  final int maxHours;
  final ValueChanged<int>? onChanged;

  const HostMatchDurationCard({
    super.key,
    required this.hours,
    this.minHours = 1,
    this.maxHours = 24,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppPallete.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppPallete.border, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Label
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Game Duration',
                  style: AppTextStyle.s14w7sora(
                    color: AppPallete.primaryText,
                  ).copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 3),
                Text(
                  'Game Availability Duration',
                  style: AppTextStyle.s14w7sora(
                    color: AppPallete.secondaryText,
                  ).copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
          // Stepper
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _DurationStepperBtn(
                icon: Icons.remove,
                onTap: hours > minHours
                    ? () => onChanged?.call(hours - 1)
                    : null,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Text(
                  '$hours hr',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF4AC4CF),
                  ),
                ),
              ),
              _DurationStepperBtn(
                icon: Icons.add,
                onTap: hours < maxHours
                    ? () => onChanged?.call(hours + 1)
                    : null,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DurationStepperBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const _DurationStepperBtn({required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    final enabled = onTap != null;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: enabled ? const Color(0xFFEDEDED) : const Color(0xFFF7F7F7),
        ),
        child: Center(
          child: Icon(
            icon,
            size: 16,
            color: enabled ? AppPallete.primaryText : AppPallete.secondaryText,
          ),
        ),
      ),
    );
  }
}

