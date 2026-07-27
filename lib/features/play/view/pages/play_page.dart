import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_app/core/widgets/app_bg.dart';
import 'package:path_app/core/widgets/primary_app_bar.dart';
import 'package:path_app/core/widgets/primary_button.dart';
import 'package:path_app/features/play/view/widgets/play_filter_chips.dart';
import 'package:path_app/features/play/view/widgets/play_jackpot_card.dart';
import 'package:path_app/features/play/view/widgets/play_wager_card.dart';
import 'package:path_app/routes/routes_name.dart';

class PlayPage extends StatefulWidget {
  const PlayPage({super.key});

  @override
  State<PlayPage> createState() => _PlayPageState();
}

int _filterIndex = 0;

class _PlayPageState extends State<PlayPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PrimaryAppBar(
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
                SizedBox(height: 16),
                PlayJackpotCard(
                  monthlyJackpot: 250,
                  weeklyJackpot: 19,
                  currentJackpot: 5,
                ),

                SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => PlayWagerCard(
                      playerName: 'Maya Osei',
                      playerRank: 'Diamond I',
                      playerPoints: 250,
                      mode: 'Eco Sprint',
                      distanceKm: 12,
                      locationLabel: 'Downtown',
                      reward: 480,
                      slotsUsed: 2,
                      slotsTotal: 4,
                      onPlay: () {},
                    ),
                    itemCount: 2,
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
        ).copyWith(bottom: 16),
        child: PrimaryButton(
          buttonName: 'Create Game',
          onPressed: () => Get.toNamed(RoutesName.hostMatch),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
