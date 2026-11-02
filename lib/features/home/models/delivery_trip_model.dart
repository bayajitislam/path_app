class DeliveryTripModel {
  final String id;
  final String dateTime;
  final int ecoPoints;
  final String startLabel;
  final String dropoffLabel;
  final double distanceKm;
  final int durationMin;
  final double co2Saved;

  const DeliveryTripModel({
    required this.id,
    required this.dateTime,
    required this.ecoPoints,
    required this.startLabel,
    required this.dropoffLabel,
    required this.distanceKm,
    required this.durationMin,
    required this.co2Saved,
  });

  factory DeliveryTripModel.fromJson(Map<String, dynamic> json) {
    return DeliveryTripModel(
      id: json['id'] as String? ?? '',
      dateTime: json['dateTime'] as String? ?? '',
      ecoPoints: (json['ecoPoints'] as num?)?.toInt() ?? 0,
      startLabel: json['startLabel'] as String? ?? '',
      dropoffLabel: json['dropoffLabel'] as String? ?? '',
      distanceKm: (json['distanceKm'] as num?)?.toDouble() ?? 0.0,
      durationMin: (json['durationMin'] as num?)?.toInt() ?? 0,
      co2Saved: (json['co2Saved'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'dateTime': dateTime,
      'ecoPoints': ecoPoints,
      'startLabel': startLabel,
      'dropoffLabel': dropoffLabel,
      'distanceKm': distanceKm,
      'durationMin': durationMin,
      'co2Saved': co2Saved,
    };
  }
}

