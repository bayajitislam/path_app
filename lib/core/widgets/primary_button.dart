import 'package:flutter/material.dart';
import 'package:path_app/core/common/app_loader.dart';
import 'package:path_app/core/theme/app_pallete.dart';
import 'package:path_app/core/theme/app_text_style.dart';

class PrimaryButton extends StatelessWidget {
  final String buttonName;
  final double borderRadius;
  final bool isLoading;
  final void Function()? onPressed;

  const PrimaryButton({
    super.key,
    required this.buttonName,
    required this.onPressed,
    this.isLoading = false,
    this.borderRadius = 10,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isLoading ? AppPallete.secondary : AppPallete.primary,
        minimumSize: const Size.fromHeight(45),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      child: isLoading
          ? const AppLoader(color: AppPallete.secondary)
          : Text(
              buttonName,
              style: AppTextStyle.s16w4i(
                color: AppPallete.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
    );
  }
}