import 'package:flutter/material.dart';
import 'package:path_app/core/widgets/app_bg.dart';
import 'package:path_app/core/widgets/app_searchbar.dart';
import 'package:path_app/core/widgets/primary_app_bar.dart';
import 'package:path_app/features/home/data/friends_repository.dart';
import 'package:path_app/features/home/models/friend_model.dart';
import 'package:path_app/features/home/view/widgets/challenge_card.dart';

class FriendsPage extends StatefulWidget {
  final FriendsRepository repository;
  const FriendsPage({
    super.key,
    this.repository = const LocalFriendsRepository(),
  });

  @override
  State<FriendsPage> createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  final TextEditingController _searchController = TextEditingController();
  List<FriendModel> _allFriends = [];
  String _searchQuery = '';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFriends();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadFriends() async {
    final friends = await widget.repository.getFriends();
    if (mounted) {
      setState(() {
        _allFriends = friends;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredFriends = _allFriends.where((f) {
      if (_searchQuery.isEmpty) return true;
      return f.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          f.rank.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    final onlineCount = _allFriends.where((f) => f.isOnline).length;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PrimaryAppBar(
        title: 'Friends',
        subtitle: 'Your friends · $onlineCount online',
      ),
      body: AppBg(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              children: [
                //Search
                AppSearchbar(
                  controller: _searchController,
                  onChanged: (val) {
                    setState(() => _searchQuery = val.trim());
                  },
                ),

                //All Friends
                Expanded(
                  child: _isLoading
                      ? const Center(
                          child: CircularProgressIndicator.adaptive(),
                        )
                      : filteredFriends.isEmpty
                      ? const Center(
                          child: Text(
                            'No friends found matching your search.',
                            style: TextStyle(color: Colors.grey),
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.only(top: 12),
                          itemCount: filteredFriends.length,
                          itemBuilder: (_, index) {
                            final friend = filteredFriends[index];
                            return ChallengeCard(
                              name: friend.name,
                              rank: friend.rank,
                            );
                          },
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
