import 'package:flutter/material.dart';
import 'package:path_app/core/theme/app_pallete.dart';
import 'package:path_app/core/theme/app_text_style.dart';

class DeleteAccountDialog extends StatelessWidget {
  final VoidCallback? onCancel;
  final VoidCallback? onDelete;

  const DeleteAccountDialog({
    super.key,
    this.onCancel,
    this.onDelete,
  });

  /// Static helper to trigger the dialog directly from any Scaffold context
  static Future<bool?> show(BuildContext context) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (context) => DeleteAccountDialog(
        onCancel: () => Navigator.of(context).pop(false),
        onDelete: () => Navigator.of(context).pop(true),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppPallete.white,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              'Delete Account?',
              style: AppTextStyle.s16w4i(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AppPallete.primaryText,
              ),
            ),
            const SizedBox(height: 8),

            // Subtitle
            Text(
              'This action is permanent and cannot be undone.',
              style: AppTextStyle.s12w4i(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppPallete.secondaryText,
              ),
            ),
            const SizedBox(height: 24),

            // Buttons Row
            Row(
              children: [
                // Green "No, Cancel" Button
                Expanded(
                  child: SizedBox(
                    height: 48,
                    child: ElevatedButton(
                      onPressed: onCancel ?? () => Navigator.of(context).pop(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppPallete.primary, // App primary green
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: Text(
                        'No, Cancel',
                        style: AppTextStyle.s14w4i(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: AppPallete.white,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                // Red "Yes, Delete" Button
                Expanded(
                  child: SizedBox(
                    height: 48,
                    child: ElevatedButton(
                      onPressed: onDelete ?? () => Navigator.of(context).pop(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE52C2C), // Action red
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: Text(
                        'Yes, Delete',
                        style: AppTextStyle.s14w4i(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: AppPallete.white,
                        ),
                      ),
                    ),
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