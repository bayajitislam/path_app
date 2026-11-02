import 'package:path_app/features/play/models/match_lobby_model.dart';

abstract class MatchRepository {
  Future<List<MatchLobbyModel>> getMatches();
}

class LocalMatchRepository implements MatchRepository {
  const LocalMatchRepository();

  @override
  Future<List<MatchLobbyModel>> getMatches() async {
    return const [
      MatchLobbyModel(
        id: 'match_1',
        playerName: 'Maya Osei',
        playerRank: 'Diamond I',
        playerPoints: 250,
        mode: 'Eco Sprint',
        distanceKm: 12.0,
        locationLabel: 'Downtown',
        reward: 480,
        slotsUsed: 2,
        slotsTotal: 4,
      ),
      MatchLobbyModel(
        id: 'match_2',
        playerName: 'Liam Chen',
        playerRank: 'Gold III',
        playerPoints: 180,
        mode: 'Green Commute',
        distanceKm: 8.5,
        locationLabel: 'West Bay',
        reward: 320,
        slotsUsed: 3,
        slotsTotal: 4,
      ),
      MatchLobbyModel(
        id: 'match_2',
        playerName: 'Liam Chen',
        playerRank: 'Gold III',
        playerPoints: 180,
        mode: 'Green Commute',
        distanceKm: 8.5,
        locationLabel: 'West Bay',
        reward: 320,
        slotsUsed: 3,
        slotsTotal: 4,
      ),
      MatchLobbyModel(
        id: 'match_2',
        playerName: 'Liam Chen',
        playerRank: 'Gold III',
        playerPoints: 180,
        mode: 'Green Commute',
        distanceKm: 8.5,
        locationLabel: 'West Bay',
        reward: 320,
        slotsUsed: 3,
        slotsTotal: 4,
      ),
      MatchLobbyModel(
        id: 'match_2',
        playerName: 'Liam Chen',
        playerRank: 'Gold III',
        playerPoints: 180,
        mode: 'Green Commute',
        distanceKm: 8.5,
        locationLabel: 'West Bay',
        reward: 320,
        slotsUsed: 3,
        slotsTotal: 4,
      ),
    ];
  }
}
