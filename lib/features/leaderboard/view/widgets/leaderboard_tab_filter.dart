import 'package:flutter/material.dart';
import 'package:path_app/core/theme/app_pallete.dart';
import 'package:path_app/core/theme/app_text_style.dart';

class LeaderboardTabFilter extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int>? onChanged;

  const LeaderboardTabFilter({
    super.key,
    this.selectedIndex = 0,
    this.onChanged,
  });

  static const _tabs = ['Jackpot', 'Career'];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: List.generate(_tabs.length, (i) {
          final isSelected = i == selectedIndex;
          return Expanded(
            child: GestureDetector(
              onTap: () => onChanged?.call(i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  color: isSelected ? AppPallete.white : AppPallete.transparent,
                  borderRadius: BorderRadius.circular(9),
                ),
                child: Center(
                  child: Text(
                    _tabs[i],
                    style: AppTextStyle.s14w4i().copyWith(
                      fontWeight: FontWeight.w600,
                      color: isSelected
                          ? AppPallete.primaryText
                          : AppPallete.secondaryText
                    )
                  )
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}