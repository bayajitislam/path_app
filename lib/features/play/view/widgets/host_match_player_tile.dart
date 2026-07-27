import 'package:flutter/material.dart';
import 'package:path_app/core/theme/app_pallete.dart';
import 'package:path_app/core/theme/app_text_style.dart';

enum HostMatchPlayerStatus { joined, invited }

class HostMatchPlayerTile extends StatelessWidget {
  final String name;
  final String subtitle;
  final String? avatarUrl;
  final HostMatchPlayerStatus status;
  final VoidCallback? onTap;

  const HostMatchPlayerTile({
    super.key,
    required this.name,
    required this.subtitle,
    this.avatarUrl,
    required this.status,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isJoined = status == HostMatchPlayerStatus.joined;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppPallete.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Avatar
          CircleAvatar(
            radius: 22,
            backgroundColor: const Color(0xFF1A1A2E),
            backgroundImage: avatarUrl != null
                ? NetworkImage(avatarUrl!)
                : null,
            child: avatarUrl == null
                ? Text(
                    name.isNotEmpty ? name[0] : '?',
                    style: const TextStyle(
                      color: AppPallete.white,
                      fontWeight: FontWeight.w700,
                    ),
                  )
                : null,
          ),
          const SizedBox(width: 12),
          // Name + subtitle
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: AppTextStyle.s14w7sora(color: AppPallete.primaryText),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: AppTextStyle.s14w7sora(
                    color: AppPallete.secondaryText,
                  ).copyWith(fontSize: 10, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
          // Status badge
          GestureDetector(
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                color: isJoined ? AppPallete.primary : AppPallete.primaryText,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Text(
                isJoined ? 'Joined' : 'Invited',
                style: AppTextStyle.s14w4i().copyWith(
                  color: AppPallete.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
