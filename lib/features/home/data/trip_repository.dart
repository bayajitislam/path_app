import 'package:path_app/features/home/models/delivery_trip_model.dart';

abstract class TripRepository {
  Future<List<DeliveryTripModel>> getRecentTrips();
}

class LocalTripRepository implements TripRepository {
  const LocalTripRepository();

  @override
  Future<List<DeliveryTripModel>> getRecentTrips() async {
    return const [
      DeliveryTripModel(
        id: 'trip_1',
        dateTime: 'Today, 2:30 PM',
        ecoPoints: 12,
        startLabel: 'Burger King, High St',
        dropoffLabel: '142 Riverside Apts',
        distanceKm: 4.2,
        durationMin: 18,
        co2Saved: 0.8,
      ),
      DeliveryTripModel(
        id: 'trip_2',
        dateTime: 'Today, 11:15 AM',
        ecoPoints: 16,
        startLabel: 'Green Grocer, Main Ave',
        dropoffLabel: '78 Oakwood Terrace',
        distanceKm: 5.6,
        durationMin: 22,
        co2Saved: 1.2,
      ),
      DeliveryTripModel(
        id: 'trip_3',
        dateTime: 'Yesterday, 6:45 PM',
        ecoPoints: 9,
        startLabel: 'Chai Point, Central Plaza',
        dropoffLabel: '21 Beacon Hill',
        distanceKm: 3.1,
        durationMin: 14,
        co2Saved: 0.6,
      ),
    ];
  }
}

