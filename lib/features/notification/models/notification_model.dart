class NotificationModel {
  final String id;
  final String emoji;
  final String title;
  final String time;
  final bool isRead;
  final String category; // 'All', 'Rankings', 'Rewards'

  const NotificationModel({
    required this.id,
    this.emoji = '🏆',
    required this.title,
    required this.time,
    this.isRead = true,
    this.category = 'All',
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] as String? ?? '',
      emoji: json['emoji'] as String? ?? '🏆',
      title: json['title'] as String? ?? '',
      time: json['time'] as String? ?? '',
      isRead: json['isRead'] as bool? ?? true,
      category: json['category'] as String? ?? 'All',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'emoji': emoji,
      'title': title,
      'time': time,
      'isRead': isRead,
      'category': category,
    };
  }

  NotificationModel copyWith({
    String? id,
    String? emoji,
    String? title,
    String? time,
    bool? isRead,
    String? category,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      emoji: emoji ?? this.emoji,
      title: title ?? this.title,
      time: time ?? this.time,
      isRead: isRead ?? this.isRead,
      category: category ?? this.category,
    );
  }
}

