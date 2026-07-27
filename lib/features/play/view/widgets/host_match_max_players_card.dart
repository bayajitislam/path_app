import 'package:flutter/material.dart';
import 'package:path_app/core/theme/app_pallete.dart';
import 'package:path_app/core/theme/app_text_style.dart';

class HostMatchMaxPlayersCard extends StatelessWidget {
  final int value;
  final int min;
  final int max;
  final ValueChanged<int>? onChanged;

  const HostMatchMaxPlayersCard({
    super.key,
    required this.value,
    this.min = 2,
    this.max = 10,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Max players',
                  style: AppTextStyle.s14w7sora(
                    color: AppPallete.primaryText,
                  ).copyWith(fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 3),
                Text(
                  'Total slots including you',
                  style: AppTextStyle.s14w7sora(
                    color: AppPallete.secondaryText,
                  ).copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
          // Stepper
          Row(
            children: [
              _StepperBtn(
                icon: Icons.remove,
                onTap: value > min ? () => onChanged?.call(value - 1) : null,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  '$value',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppPallete.primary,
                  ),
                ),
              ),
              _StepperBtn(
                icon: Icons.add,
                onTap: value < max ? () => onChanged?.call(value + 1) : null,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StepperBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const _StepperBtn({required this.icon, this.onTap});

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
          color: enabled ? AppPallete.border : const Color(0xFFE7E8E7),
          border: Border.all(
            color: enabled ? AppPallete.border : const Color(0xFFE0E0E0),
            width: 1.5,
          ),
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
