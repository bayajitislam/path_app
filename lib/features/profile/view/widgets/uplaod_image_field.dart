import 'package:flutter/material.dart';
import 'package:path_app/core/theme/app_pallete.dart';
import 'package:path_app/core/theme/app_text_style.dart';

class UploadImageField extends StatelessWidget {
  final String label;
  final String buttonText;
  final VoidCallback? onPickImage;

  const UploadImageField({
    super.key,
    this.label = 'Upload Image',
    this.buttonText = 'Choose your image',
    this.onPickImage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyle.s14w4i(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppPallete.primaryText,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          width: double.infinity,
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 6),
          decoration: BoxDecoration(
            color: AppPallete.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: InkWell(
              onTap: onPickImage,
              borderRadius: BorderRadius.circular(6),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F1F1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  buttonText,
                  style: AppTextStyle.s12w4i(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppPallete.secondaryText,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
