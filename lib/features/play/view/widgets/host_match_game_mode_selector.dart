import 'package:flutter/material.dart';
import 'package:path_app/core/theme/app_pallete.dart';
import 'package:path_app/core/theme/app_text_style.dart';

class HostMatchGameModeSelector extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int>? onChanged;

  const HostMatchGameModeSelector({
    super.key,
    this.selectedIndex = 0,
    this.onChanged,
  });

  static const _modes = [
    'Delivery Driver',
    'Grocery Run',
    'Ride Sharing',
    '1V1',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Game mode',
          style: AppTextStyle.s14w7sora(
            color: AppPallete.primaryText,
          ).copyWith(fontWeight: FontWeight.w600, fontSize: 12),
        ),
        const SizedBox(height: 10),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 3.5,
          children: List.generate(_modes.length, (i) {
            final isSelected = i == selectedIndex;
            return GestureDetector(
              onTap: () => onChanged?.call(i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFFD9F7E8)
                      : AppPallete.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected ? AppPallete.primary : AppPallete.border,
                    width: 1,
                  ),
                ),
                child: Center(
                  child: Text(
                    _modes[i],
                    style: AppTextStyle.s14w7sora(
                      color: isSelected
                          ? AppPallete.primary
                          : AppPallete.primaryText,
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}
