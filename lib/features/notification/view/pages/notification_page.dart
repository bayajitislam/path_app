import 'package:flutter/material.dart';
import 'package:path_app/core/widgets/app_bg.dart';
import 'package:path_app/core/widgets/primary_app_bar.dart';
import 'package:path_app/features/notification/view/widgets/notification_card.dart';
import 'package:path_app/features/notification/view/widgets/notification_tab_filter.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  int _tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PrimaryAppBar(
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

                SizedBox(height: 16),

                NotificationList(
                  items: [
                    NotificationItem(
                      title: 'Weekly Rankings Are Live!',
                      time: '1h ago',
                    ),
                    NotificationItem(
                      title: 'Jackpot Payout Received',
                      time: '2h ago',
                      isRead: false,
                    ),
                  ],
                  onItemTap: (i) {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
