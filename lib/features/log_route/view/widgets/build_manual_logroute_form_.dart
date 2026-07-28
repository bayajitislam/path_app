// --- Expanded Form Inputs Widget ---
import 'package:flutter/material.dart';
import 'package:path_app/core/theme/app_pallete.dart';
import 'package:path_app/core/theme/app_text_style.dart';

class BuildManualLogrouteForm extends StatelessWidget {
  // --- Constructor ---
  final void Function()? onPressed;
  const BuildManualLogrouteForm({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Start & End Locations
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Start Location',
                    style: AppTextStyle.s12w4i(
                      color: const Color(0xFF374151),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 6),
                  _buildTextField(
                    hint: 'e.g. Restaurant',
                    icon: Icons.location_on_outlined,
                    iconColor: AppPallete.secondaryText,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'End Location',
                    style: AppTextStyle.s12w4i(
                      color: const Color(0xFF374151),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 6),
                  _buildTextField(
                    hint: 'e.g. Customer',
                    icon: Icons.location_on,
                    iconColor: const Color(0xFFFF5252),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),

        // Transport Mode
        Text(
          'Transport Mode',
          style: AppTextStyle.s12w4i(
            color: const Color(0xFF374151),
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: AppPallete.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(),
              Icon(
                Icons.keyboard_arrow_down_rounded,
                color: AppPallete.secondaryText,
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // Distance, Duration, Idle
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Distance (km)',
                    style: AppTextStyle.s12w4i(
                      color: const Color(0xFF374151),
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 6),
                  _buildTextField(),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Duration (min)',
                    style: AppTextStyle.s12w4i(
                      color: AppPallete.secondaryText,
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 6),
                  _buildTextField(),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Idle (min)',
                    style: AppTextStyle.s12w4i(
                      color: AppPallete.secondaryText,
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 6),
                  _buildTextField(),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),

        // Save Button
        ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppPallete.primary,
            minimumSize: const Size.fromHeight(48),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 0,
          ),
          child: Text(
            'Save',
            style: AppTextStyle.s16w4i(
              color: AppPallete.white,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  // --- Custom TextField Helper ---
  Widget _buildTextField({String? hint, IconData? icon, Color? iconColor}) {
    return Container(
      height: 44,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppPallete.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        style: AppTextStyle.s14w4i(color: AppPallete.primaryText, fontSize: 13),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: AppTextStyle.s14w4i(
            color: const Color(0xFFB0B0B0),
            fontSize: 13,
          ),
          prefixIcon: icon != null
              ? Icon(
                  icon,
                  size: 18,
                  color: iconColor ?? AppPallete.secondaryText,
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 12,
          ),
        ),
      ),
    );
  }
}
