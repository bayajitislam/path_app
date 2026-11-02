class FriendModel {
  final String id;
  final String name;
  final String rank;
  final bool isOnline;

  const FriendModel({
    required this.id,
    required this.name,
    required this.rank,
    this.isOnline = false,
  });

  factory FriendModel.fromJson(Map<String, dynamic> json) {
    return FriendModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      rank: json['rank'] as String? ?? '',
      isOnline: json['isOnline'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'rank': rank, 'isOnline': isOnline};
  }
}
