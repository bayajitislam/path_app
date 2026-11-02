import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_app/core/theme/app_pallete.dart';
import 'package:path_app/core/theme/app_text_style.dart';

class ImportRouteDropdown extends StatelessWidget {
  final VoidCallback? onTap;

  const ImportRouteDropdown({super.key, this.onTap});

  void _showImportOptions(BuildContext context) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: AppPallete.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Import Routes from Delivery Apps',
              style: AppTextStyle.s16w4i(
                color: AppPallete.primaryText,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),
            ...['Uber Eats', 'Deliveroo', 'DoorDash', 'Just Eat'].map((app) {
              return ListTile(
                leading: const Icon(
                  Icons.sync_rounded,
                  color: AppPallete.primary,
                ),
                title: Text(
                  app,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                subtitle: const Text('Connect to auto-sync daily shifts'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Get.back();
                  Get.snackbar(
                    'App Integration',
                    '$app integration will sync upon shift completion.',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: AppPallete.white,
                    colorText: AppPallete.primaryText,
                  );
                },
              );
            }),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap ?? () => _showImportOptions(context),
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: AppPallete.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Color(0xFFE8F8EE),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.location_on_outlined,
                  color: AppPallete.primary,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Import from Delivery App',
                      style: AppTextStyle.s14w4i(
                        color: AppPallete.primaryText,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Uber Eats, Deliveroo, DoorDash, Just Eat',
                      style: AppTextStyle.s12w4i(
                        color: AppPallete.secondaryText,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: AppPallete.secondaryText,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
