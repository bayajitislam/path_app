import 'package:flutter/material.dart';
import 'package:path_app/core/theme/app_pallete.dart';

class PlayFilterChips extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int>? onChanged;

  const PlayFilterChips({super.key, this.selectedIndex = 2, this.onChanged});

  static const _filters = [
    _FilterOption(label: 'Nearby ≤3km', icon: null),
    _FilterOption(label: 'High stakes', icon: Icons.tune_rounded),
    _FilterOption(label: 'All modes', icon: null),
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(_filters.length, (i) {
        final isSelected = i == selectedIndex;
        return Padding(
          padding: EdgeInsets.only(right: i < _filters.length - 1 ? 8 : 0),
          child: GestureDetector(
            onTap: () => onChanged?.call(i),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0x2622E07A) : AppPallete.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected ? AppPallete.primary : AppPallete.border,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (_filters[i].icon != null) ...[
                    Icon(
                      _filters[i].icon,
                      size: 14,
                      color: isSelected
                          ? AppPallete.primary
                          : AppPallete.secondaryText,
                    ),
                    const SizedBox(width: 4),
                  ],
                  Text(
                    _filters[i].label,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: isSelected
                          ? const Color(0xFF34C759)
                          : AppPallete.primaryText,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

class _FilterOption {
  final String label;
  final IconData? icon;
  const _FilterOption({required this.label, this.icon});
}
