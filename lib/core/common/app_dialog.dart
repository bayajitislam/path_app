import 'package:flutter/material.dart';
import 'package:path_app/core/theme/app_pallete.dart';
import 'package:path_app/core/theme/app_text_style.dart';
import 'package:path_app/core/widgets/primary_button.dart';

enum DialogType { info, warning }

class AppDialog extends StatelessWidget {
  final String? title;
  final String message;
  final DialogType type;
  final VoidCallback? onCancel;
  final VoidCallback? onConfirm;
  final String confirmText;
  final String cancelText;

  const AppDialog({
    super.key,
    this.title,
    required this.message,
    this.type = DialogType.info,
    this.onCancel,
    this.onConfirm,
    this.confirmText = "OK",
    this.cancelText = "Cancel",
  });

  @override
  Widget build(BuildContext context) {
    // Get colors based on type
    final Color iconColor = type == DialogType.warning
        ? AppPallete.danger
        : AppPallete.primary;

    return Dialog(
      backgroundColor: AppPallete.primary, // Uses your theme bg
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 1. Icon
            Icon(
              type == DialogType.warning
                  ? Icons.warning_amber_rounded
                  : Icons.info_outline_rounded,
              color: iconColor,
              size: 48,
            ),
            const SizedBox(height: 16),

            // 2. Title
            Text(
              title ?? (type == DialogType.warning ? "Warning" : "Coming Soon"),
              style: AppTextStyle.s24w7i(),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),

            // 3. Message
            Text(
              message,
              style: AppTextStyle.s14w4i(
                color: AppPallete.secondaryText,
              ).copyWith(height: 1.5),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),

            // 4. Buttons
            Row(
              children: [
                // Cancel Button (Only if onConfirm exists)
                if (onConfirm != null)
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: AppPallete.primary.withValues(
                          alpha: 0.1,)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(33),
                        ),
                      ),
                      onPressed: onCancel ?? () => Navigator.pop(context),
                      child: Text(
                        cancelText,
                        style: AppTextStyle.s16w4i(color: AppPallete.primary),
                      ),
                    ),
                  ),

                if (onConfirm != null) const SizedBox(width: 12),

                // Confirm / OK Button
                Expanded(
                  child: PrimaryButton(
                    buttonName: confirmText,
                    borderRadius: 33,
                    onPressed: onConfirm ?? () => Navigator.pop(context),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}