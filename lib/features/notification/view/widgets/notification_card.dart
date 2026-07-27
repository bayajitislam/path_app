import 'package:flutter/material.dart';
import 'package:path_app/core/theme/app_pallete.dart';

class NotificationCard extends StatelessWidget {
  final String emoji;
  final String title;
  final String time;
  final bool isRead;
  final VoidCallback? onTap;

  const NotificationCard({
    super.key,
    this.emoji = '🏆',
    required this.title,
    required this.time,
    this.isRead = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$emoji $title',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppPallete.primaryText,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    time,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppPallete.secondaryText,
                    ),
                  ),
                ],
              ),
            ),
            // Unread dot
            if (!isRead)
              Padding(
                padding: const EdgeInsets.only(top: 5, right: 8),
                child: Container(
                  width: 7,
                  height: 7,
                  decoration: const BoxDecoration(
                    color: AppPallete.primary,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// ─── Notification List ────────────────────────────────────────────────────────

class NotificationItem {
  final String emoji;
  final String title;
  final String time;
  final bool isRead;

  const NotificationItem({
    this.emoji = '🏆',
    required this.title,
    required this.time,
    this.isRead = true,
  });
}

class NotificationList extends StatelessWidget {
  final List<NotificationItem> items;
  final void Function(int index)? onItemTap;

  const NotificationList({super.key, required this.items, this.onItemTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(items.length, (i) {
        return Padding(
          padding: EdgeInsets.only(bottom: i < items.length - 1 ? 10 : 0),
          child: NotificationCard(
            emoji: items[i].emoji,
            title: items[i].title,
            time: items[i].time,
            isRead: items[i].isRead,
            onTap: () => onItemTap?.call(i),
          ),
        );
      }),
    );
  }
}
