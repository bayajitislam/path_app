class MatchLobbyModel {
  final String id;
  final String playerName;
  final String playerRank;
  final int playerPoints;
  final String mode;
  final double distanceKm;
  final String locationLabel;
  final int reward;
  final int slotsUsed;
  final int slotsTotal;

  const MatchLobbyModel({
    required this.id,
    required this.playerName,
    required this.playerRank,
    required this.playerPoints,
    required this.mode,
    required this.distanceKm,
    required this.locationLabel,
    required this.reward,
    required this.slotsUsed,
    required this.slotsTotal,
  });

  factory MatchLobbyModel.fromJson(Map<String, dynamic> json) {
    return MatchLobbyModel(
      id: json['id'] as String? ?? '',
      playerName: json['playerName'] as String? ?? '',
      playerRank: json['playerRank'] as String? ?? '',
      playerPoints: (json['playerPoints'] as num?)?.toInt() ?? 0,
      mode: json['mode'] as String? ?? '',
      distanceKm: (json['distanceKm'] as num?)?.toDouble() ?? 0.0,
      locationLabel: json['locationLabel'] as String? ?? '',
      reward: (json['reward'] as num?)?.toInt() ?? 0,
      slotsUsed: (json['slotsUsed'] as num?)?.toInt() ?? 0,
      slotsTotal: (json['slotsTotal'] as num?)?.toInt() ?? 4,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'playerName': playerName,
      'playerRank': playerRank,
      'playerPoints': playerPoints,
      'mode': mode,
      'distanceKm': distanceKm,
      'locationLabel': locationLabel,
      'reward': reward,
      'slotsUsed': slotsUsed,
      'slotsTotal': slotsTotal,
    };
  }
}

