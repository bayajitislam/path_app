import 'package:flutter/material.dart';
import 'package:path_app/core/theme/app_pallete.dart';
import 'package:path_app/core/theme/app_text_style.dart';

class SocialLinkRow extends StatelessWidget {
  final String selectedPlatform;
  final List<String> platforms;
  final bool isConnected;
  final ValueChanged<String?> onPlatformChanged;
  final VoidCallback onToggleConnect;
  final VoidCallback? onDelete;

  const SocialLinkRow({
    super.key,
    required this.selectedPlatform,
    required this.platforms,
    required this.isConnected,
    required this.onPlatformChanged,
    required this.onToggleConnect,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          // Platform Dropdown Selector
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F1F1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedPlatform,
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: AppPallete.secondaryText,
                  size: 20,
                ),
                style: AppTextStyle.s14w4i(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppPallete.primaryText,
                ),
                onChanged: onPlatformChanged,
                items: platforms.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ),

          const SizedBox(width: 10),

          // Connect / Connected Button
          Expanded(
            child: SizedBox(
              height: 44,
              child: ElevatedButton(
                onPressed: onToggleConnect,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isConnected
                      ? const Color(0xFF6B6B6B) // Dark gray when connected
                      : const Color(
                          0xFF2C4A32,
                        ), // Dark forest green when connect
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  isConnected ? 'Connected' : 'Connect',
                  style: AppTextStyle.s14w4i(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppPallete.white,
                  ),
                ),
              ),
            ),
          ),

          // Delete/Remove Action Button (Visible when connected or on dynamic rows)
          if (isConnected && onDelete != null) ...[
            const SizedBox(width: 8),
            InkWell(
              onTap: onDelete,
              borderRadius: BorderRadius.circular(10),
              child: Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFEAEB), // Light pink fill
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.delete_outline_rounded,
                  color: Color(0xFFE52C2C),
                  size: 20,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
