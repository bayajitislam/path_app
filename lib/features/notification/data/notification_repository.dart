import 'package:path_app/features/notification/models/notification_model.dart';

abstract class NotificationRepository {
  Future<List<NotificationModel>> getNotifications();
}

class LocalNotificationRepository implements NotificationRepository {
  const LocalNotificationRepository();

  @override
  Future<List<NotificationModel>> getNotifications() async {
    return const [
      NotificationModel(
        id: 'notif_1',
        title: 'Weekly Rankings Are Live!',
        time: '1h ago',
        category: 'Rankings',
        isRead: true,
      ),
      NotificationModel(
        id: 'notif_2',
        title: 'Jackpot Payout Received',
        time: '2h ago',
        category: 'Rewards',
        isRead: false,
      ),
      NotificationModel(
        id: 'notif_3',
        title: 'Maya challenged you to an Eco Sprint',
        time: '5h ago',
        category: 'All',
        isRead: true,
      ),
    ];
  }
}

