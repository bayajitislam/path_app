import 'package:path_app/features/home/models/friend_model.dart';

abstract class FriendsRepository {
  Future<List<FriendModel>> getFriends();
}

class LocalFriendsRepository implements FriendsRepository {
  const LocalFriendsRepository();

  @override
  Future<List<FriendModel>> getFriends() async {
    return const [
      FriendModel(
        id: 'fr_1',
        name: 'Maya Osei',
        rank: 'Diamond I',
        isOnline: true,
      ),
      FriendModel(
        id: 'fr_2',
        name: 'Alex Rivera',
        rank: 'Platinum II',
        isOnline: true,
      ),
      FriendModel(
        id: 'fr_3',
        name: 'Liam Chen',
        rank: 'Gold III',
        isOnline: false,
      ),
      FriendModel(
        id: 'fr_4',
        name: 'Sarah Jenkins',
        rank: 'Diamond II',
        isOnline: false,
      ),
    ];
  }
}

