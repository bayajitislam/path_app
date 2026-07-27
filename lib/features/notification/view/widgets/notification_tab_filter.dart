import 'package:flutter/material.dart';
import 'package:path_app/core/theme/app_pallete.dart';

// ─── Tab Filter (All / Unread) ───────────────────────────────────────────────

class NotificationTabFilter extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int>? onChanged;

  const NotificationTabFilter({
    super.key,
    this.selectedIndex = 0,
    this.onChanged,
  });

  static const _tabs = ['All', 'Unread'];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppPallete.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
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
                  color: isSelected
                      ? Color(0xFFF9FAFB)
                      : AppPallete.transparent,
                  borderRadius: BorderRadius.circular(9),
                  border: Border.all(
                    color: isSelected
                        ? AppPallete.border
                        : AppPallete.transparent,
                  ),
                ),
                child: Center(
                  child: Text(
                    _tabs[i],
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: isSelected
                          ? AppPallete.primaryText
                          : AppPallete.secondaryText,
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
