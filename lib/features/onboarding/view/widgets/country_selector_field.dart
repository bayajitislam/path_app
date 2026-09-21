import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_app/core/theme/app_pallete.dart';
import 'package:path_app/features/onboarding/view/widgets/country_picker_bottom_sheet.dart';

/// A sleek pill-shaped country selection field.
/// Tapping it opens the [CountryPickerBottomSheet] with all countries of the world.
class CountrySelectorField extends StatelessWidget {
  final String? selectedCountry;
  final ValueChanged<Country> onCountrySelected;
  final String hintText;

  const CountrySelectorField({
    super.key,
    this.selectedCountry,
    required this.onCountrySelected,
    this.hintText = 'Search or select your country',
  });

  @override
  Widget build(BuildContext context) {
    final hasSelection = selectedCountry != null && selectedCountry!.isNotEmpty;

    return GestureDetector(
      onTap: () {
        CountryPickerBottomSheet.show(
          context: context,
          selectedCountry: selectedCountry,
          onSelect: onCountrySelected,
        );
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: AppPallete.white,
          borderRadius: BorderRadius.circular(333.r),
          border: Border.all(
            color: const Color(0xFFE5E7EB),
            width: 1.w,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                hasSelection ? selectedCountry! : hintText,
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp,
                  color: hasSelection
                      ? const Color(0xFF111827)
                      : const Color(0xFF6B7280),
                ),
              ),
            ),
            Icon(
              Icons.arrow_drop_down,
              size: 24.sp,
              color: const Color(0xFF6B7280),
            ),
          ],
        ),
      ),
    );
  }
}
