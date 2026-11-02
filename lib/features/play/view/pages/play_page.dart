import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_app/core/widgets/app_bg.dart';
import 'package:path_app/core/widgets/primary_app_bar.dart';
import 'package:path_app/core/widgets/primary_button.dart';
import 'package:path_app/features/play/data/match_repository.dart';
import 'package:path_app/features/play/models/match_lobby_model.dart';
import 'package:path_app/features/play/view/widgets/play_filter_chips.dart';
import 'package:path_app/features/play/view/widgets/play_jackpot_card.dart';
import 'package:path_app/features/play/view/widgets/play_wager_card.dart';
import 'package:path_app/routes/routes_name.dart';

class PlayPage extends StatefulWidget {
  final MatchRepository repository;
  const PlayPage({super.key, this.repository = const LocalMatchRepository()});

  @override
  State<PlayPage> createState() => _PlayPageState();
}

class _PlayPageState extends State<PlayPage> {
  int _filterIndex = 0;
  List<MatchLobbyModel> _matches = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadMatches();
  }

  Future<void> _loadMatches() async {
    final matches = await widget.repository.getMatches();
    if (mounted) {
      setState(() {
        _matches = matches;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const PrimaryAppBar(
        title: 'Match Lobby',
        showBackButton: false,
        subtitle: 'Wager, compete & earn green',
      ),
      body: AppBg(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              children: [
                //Filters
                PlayFilterChips(
                  selectedIndex: _filterIndex,
                  onChanged: (i) => setState(() => _filterIndex = i),
                ),
                const SizedBox(height: 16),
                const PlayJackpotCard(
                  monthlyJackpot: 250,
                  weeklyJackpot: 19,
                  currentJackpot: 5,
                ),

                const SizedBox(height: 16),
                Expanded(
                  child: _isLoading
                      ? const Center(
                          child: CircularProgressIndicator.adaptive(),
                        )
                      : _matches.isEmpty
                      ? const Center(
                          child: Text(
                            'No matches available in this lobby.',
                            style: TextStyle(color: Colors.grey),
                          ),
                        )
                      : ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: _matches.length,
                          itemBuilder: (context, index) {
                            final match = _matches[index];
                            return PlayWagerCard(
                              cardIndex: index,
                              playerName: match.playerName,
                              playerRank: match.playerRank,
                              playerPoints: match.playerPoints,
                              mode: match.mode,
                              distanceKm: match.distanceKm,
                              locationLabel: match.locationLabel,
                              reward: match.reward,
                              slotsUsed: match.slotsUsed,
                              slotsTotal: match.slotsTotal,
                              onPlay: () => Get.toNamed(RoutesName.joinLobby),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ).copyWith(bottom: 120),
        child: PrimaryButton(
          buttonName: 'Create Game',
          onPressed: () => Get.toNamed(RoutesName.hostMatch),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
