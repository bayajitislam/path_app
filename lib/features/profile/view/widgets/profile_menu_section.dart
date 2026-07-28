import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_app/core/theme/app_pallete.dart';
import 'package:path_app/core/theme/app_text_style.dart';

class ProfileMenuItem {
  final String title;
  final VoidCallback? onTap;
  final bool isNotification;
  final bool switchValue;
  final ValueChanged<bool>? onSwitchChanged;

  const ProfileMenuItem({
    required this.title,
    this.onTap,
    this.isNotification = false,
    this.switchValue = false,
    this.onSwitchChanged,
  });
}

class ProfileMenuSection extends StatelessWidget {
  final String sectionTitle;
  final List<ProfileMenuItem> items;

  const ProfileMenuSection({
    super.key,
    required this.sectionTitle,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color(0xFFCCCCCC),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title
          Container(
            padding: const EdgeInsets.only(
              top: 16,
              left: 16,
              right: 16,
              bottom: 4,
            ),
            child: Text(
              sectionTitle,
              textAlign: TextAlign.start,
              style: AppTextStyle.s14w4i(
                fontWeight: FontWeight.w700,
                color: AppPallete.primaryText,
              ),
            ),
          ),

          // Items List (Renders either Switch Tile or Navigation Tile)
          Column(
            children: items.map((item) {
              if (item.isNotification) {
                return ProfileMenuNotificationTile(
                  title: item.title,
                  value: item.switchValue,
                  onChanged: item.onSwitchChanged,
                );
              }
              return ProfileMenuTile(item: item);
            }).toList(),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

class ProfileMenuTile extends StatelessWidget {
  final ProfileMenuItem item;

  const ProfileMenuTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: item.onTap,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xCCF1F1F1),
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        child: Row(
          children: [
            Expanded(
              child: Text(
                item.title,
                style: AppTextStyle.s14w4i(
                  fontWeight: FontWeight.w600,
                  color: AppPallete.primaryText,
                ),
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_outlined,
              color: AppPallete.secondaryText,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileMenuNotificationTile extends StatelessWidget {
  final String title;
  final bool value;
  final ValueChanged<bool>? onChanged;

  const ProfileMenuNotificationTile({
    super.key,
    required this.title,
    this.value = false,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xCCF1F1F1),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              title,
              style: AppTextStyle.s14w4i(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppPallete.primaryText,
              ),
            ),
          ),
          Transform.scale(
            scale: 0.8,
            child: CupertinoSwitch(
              value: value,
              activeTrackColor: AppPallete.primary,
              inactiveTrackColor: const Color(0xFF6E6E6E),
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}
