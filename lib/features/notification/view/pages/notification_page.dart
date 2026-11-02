import 'package:flutter/material.dart';
import 'package:path_app/core/widgets/app_bg.dart';
import 'package:path_app/core/widgets/primary_app_bar.dart';
import 'package:path_app/features/notification/data/notification_repository.dart';
import 'package:path_app/features/notification/models/notification_model.dart';
import 'package:path_app/features/notification/view/widgets/notification_card.dart';
import 'package:path_app/features/notification/view/widgets/notification_tab_filter.dart';

class NotificationPage extends StatefulWidget {
  final NotificationRepository repository;
  const NotificationPage({
    super.key,
    this.repository = const LocalNotificationRepository(),
  });

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  int _tabIndex = 0;
  List<NotificationModel> _notifications = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadNotifications();
  }

  Future<void> _loadNotifications() async {
    final list = await widget.repository.getNotifications();
    if (mounted) {
      setState(() {
        _notifications = list;
        _isLoading = false;
      });
    }
  }

  void _markAsRead(int index) {
    setState(() {
      _notifications[index] = _notifications[index].copyWith(isRead: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    // 0 = All, 1 = Rankings, 2 = Rewards
    final filtered = _notifications.where((n) {
      if (_tabIndex == 1) return n.category == 'Rankings';
      if (_tabIndex == 2) return n.category == 'Rewards';
      return true;
    }).toList();

    final items = filtered
        .map(
          (n) => NotificationItem(
            emoji: n.emoji,
            title: n.title,
            time: n.time,
            isRead: n.isRead,
          ),
        )
        .toList();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const PrimaryAppBar(
        title: 'Notifications',
        subtitle: 'Keep up with your rewards and rankings.',
      ),
      body: AppBg(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                NotificationTabFilter(
                  selectedIndex: _tabIndex,
                  onChanged: (i) => setState(() => _tabIndex = i),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: _isLoading
                      ? const Center(
                          child: CircularProgressIndicator.adaptive(),
                        )
                      : items.isEmpty
                      ? const Center(
                          child: Text(
                            'No notifications in this category.',
                            style: TextStyle(color: Colors.grey),
                          ),
                        )
                      : SingleChildScrollView(
                          child: NotificationList(
                            items: items,
                            onItemTap: (i) => _markAsRead(i),
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
