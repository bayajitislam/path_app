import 'package:flutter/material.dart';
import 'package:path_app/core/theme/app_pallete.dart';
import 'package:path_app/core/theme/app_text_style.dart';

// ─── Distance / Duration Toggle ──────────────────────────────────────────────

class HostMatchModeToggle extends StatelessWidget {
  final int selectedIndex; // 0 = Distance, 1 = Duration
  final ValueChanged<int>? onChanged;

  const HostMatchModeToggle({
    super.key,
    this.selectedIndex = 0,
    this.onChanged,
  });

  static const _tabs = ['Distance', 'Duration'];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: AppPallete.border, width: 1),
      ),
      child: Row(
        children: List.generate(_tabs.length, (i) {
          final isSelected = i == selectedIndex;
          return Expanded(
            child: GestureDetector(
              onTap: () => onChanged?.call(i),
              child: AnimatedContainer(
                margin: const EdgeInsets.only(left: 2, right: 2),
                duration: const Duration(milliseconds: 180),
                decoration: BoxDecoration(
                  color: isSelected ? AppPallete.primary : Color(0xFFE7E8E7),
                  borderRadius: BorderRadius.circular(26),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 12,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    _tabs[i],
                    style: AppTextStyle.s14w7sora(
                      color: AppPallete.primaryText,
                    ).copyWith(fontSize: 12),
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

// ─── Target Distance Slider Card ─────────────────────────────────────────────

class HostMatchDistanceCard extends StatelessWidget {
  final double value; // current km
  final double min;
  final double max;
  final ValueChanged<double>? onChanged;

  const HostMatchDistanceCard({
    super.key,
    required this.value,
    this.min = 1,
    this.max = 50,
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
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Target distance',
                style: AppTextStyle.s14w7sora(
                  color: AppPallete.primaryText,
                ).copyWith(fontWeight: FontWeight.w400),
              ),
              Text(
                '${value.toStringAsFixed(0)} km',
                style: AppTextStyle.s14w7sora(color: AppPallete.primaryText),
              ),
            ],
          ),
          const SizedBox(height: 10),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: AppPallete.primary,
              inactiveTrackColor: const Color(0xFFE0E0E0),
              thumbColor: AppPallete.primary,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 16),
              trackHeight: 4,
            ),
            child: Slider(
              value: value,
              min: min,
              max: max,
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}
