import 'package:flutter/material.dart';
import 'package:path_app/core/theme/app_pallete.dart';
import 'package:path_app/core/theme/app_text_style.dart';

class HostMatchWagerSelector extends StatelessWidget {
  final int selectedAmount;
  final ValueChanged<int>? onChanged;

  const HostMatchWagerSelector({
    super.key,
    this.selectedAmount = 100,
    this.onChanged,
  });

  static const _amounts = [10, 20, 100, 200, 500];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Wager',
          style: AppTextStyle.s14w7sora(
            color: AppPallete.primaryText,
          ).copyWith(fontWeight: FontWeight.w600, fontSize: 12),
        ),
        const SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.01),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: List.generate(_amounts.length, (i) {
                final isSelected = _amounts[i] == selectedAmount;
                return Padding(
                  padding: EdgeInsets.only(
                    right: i < _amounts.length - 1 ? 8 : 0,
                  ),
                  child: GestureDetector(
                    onTap: () => onChanged?.call(_amounts[i]),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFFD9F7E8)
                            : AppPallete.white,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: isSelected
                              ? AppPallete.primary
                              : AppPallete.secondaryText,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Coin icon
                          Container(
                            width: 16,
                            height: 16,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,

                              border: Border.all(
                                color: isSelected
                                    ? AppPallete.primary
                                    : AppPallete.secondaryText,
                                width: 1,
                              ),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.monetization_on_outlined,
                                size: 10,
                                color: isSelected
                                    ? AppPallete.primary
                                    : AppPallete.secondaryText,
                              ),
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            '${_amounts[i]}',
                            style: AppTextStyle.s14w7sora(
                              color: isSelected
                                  ? AppPallete.primary
                                  : AppPallete.secondaryText,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ],
    );
  }
}
