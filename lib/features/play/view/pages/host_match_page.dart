import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_app/core/widgets/app_bg.dart';
import 'package:path_app/core/widgets/app_searchbar.dart';
import 'package:path_app/core/widgets/primary_app_bar.dart';
import 'package:path_app/core/widgets/primary_button.dart';
import 'package:path_app/features/play/view/widgets/host_match_game_mode_selector.dart';
import 'package:path_app/features/play/view/widgets/host_match_max_players_card.dart';
import 'package:path_app/features/play/view/widgets/host_match_mode_toggle.dart';
import 'package:path_app/features/play/view/widgets/host_match_player_tile.dart';
import 'package:path_app/features/play/view/widgets/host_match_route_card.dart';
import 'package:path_app/features/play/view/widgets/host_match_wager_selector.dart';
import 'package:path_app/routes/routes_name.dart';

class HostMatchPage extends StatefulWidget {
  const HostMatchPage({super.key});

  @override
  State<HostMatchPage> createState() => _HostMatchPageState();
}

class _HostMatchPageState extends State<HostMatchPage> {
  int _modeIndex = 0;
  int _wager = 100;
  int _toggleIndex = 0;
  double _distance = 10;
  int _players = 4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PrimaryAppBar(
        title: 'Host Match',
        subtitle: 'Create a public challenge',
      ),
      body: AppBg(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Game Mode ──────────────────────────────────────
                HostMatchGameModeSelector(
                  selectedIndex: _modeIndex,
                  onChanged: (i) => setState(() => _modeIndex = i),
                ),
                const SizedBox(height: 20),

                // ── Wager ──────────────────────────────────────────
                HostMatchWagerSelector(
                  selectedAmount: _wager,
                  onChanged: (v) => setState(() => _wager = v),
                ),
                const SizedBox(height: 20),

                // ── Distance / Duration Toggle ─────────────────────
                HostMatchModeToggle(
                  selectedIndex: _toggleIndex,
                  onChanged: (i) => setState(() => _toggleIndex = i),
                ),
                const SizedBox(height: 10),

                // ── Distance Slider Card ───────────────────────────
                HostMatchDistanceCard(
                  value: _distance,
                  onChanged: (v) => setState(() => _distance = v),
                ),
                const SizedBox(height: 10),

                // ── Max Players ────────────────────────────────────
                HostMatchMaxPlayersCard(
                  value: _players,
                  onChanged: (v) => setState(() => _players = v),
                ),
                const SizedBox(height: 20),

                // ── Player Search ──────────────────────────────────
                AppSearchbar(),
                const SizedBox(height: 10),

                // ── Player Tiles ───────────────────────────────────
                HostMatchPlayerTile(
                  name: 'Maya Osei',
                  subtitle: 'Gold I · Offline',
                  status: HostMatchPlayerStatus.joined,
                ),
                const SizedBox(height: 10),
                HostMatchPlayerTile(
                  name: 'Maya Osei',
                  subtitle: 'Gold I · Offline',
                  status: HostMatchPlayerStatus.invited,
                ),
                const SizedBox(height: 20),

                // ── Route ──────────────────────────────────────────
                HostMatchRouteCard(
                  routeName: 'Riverside Loop',
                  tag: 'Suggested',
                ),
                const SizedBox(height: 12),

                PrimaryButton(
                  buttonName: 'Start Now',
                  onPressed: () => Get.toNamed(RoutesName.inMatch),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
