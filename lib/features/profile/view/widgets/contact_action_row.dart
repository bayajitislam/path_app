import 'package:flutter/material.dart';
import 'package:path_app/core/theme/app_pallete.dart';

class ContactActionRow extends StatelessWidget {
  final VoidCallback? onCallUs;
  final VoidCallback? onLiveChat;

  const ContactActionRow({super.key, this.onCallUs, this.onLiveChat});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _ContactButton(
            icon: Icons.phone_outlined,
            label: 'Call Us',
            onTap: onCallUs,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _ContactButton(
            icon: Icons.chat_bubble_outline_outlined,
            label: 'Live Chat',
            iconColor: const Color(0xFF0A7F5B),
            iconBgColor: const Color(0xFFECFDF5),
            onTap: onLiveChat,
          ),
        ),
      ],
    );
  }
}

class _ContactButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color iconColor;
  final Color iconBgColor;
  final VoidCallback? onTap;

  const _ContactButton({
    required this.icon,
    required this.label,
    this.onTap,
    this.iconColor = const Color(0xFF255FDE),
    this.iconBgColor = const Color(0xFFEFF6FF),
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          color: AppPallete.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon badge
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: iconBgColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(child: Icon(icon, size: 20, color: iconColor)),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppPallete.primaryText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
