import 'dart:async';
import 'package:flutter/material.dart';
import 'package:path_app/core/widgets/app_bg.dart';
import 'package:path_app/core/widgets/primary_app_bar.dart';
import 'package:path_app/features/play/view/widgets/host_match_route_card.dart';
import 'package:path_app/features/play/view/widgets/in_match_distance_card.dart';
import 'package:path_app/features/play/view/widgets/in_match_standings_card.dart';
import 'package:path_app/features/play/view/widgets/in_match_timer_widget.dart';

class InMatchPage extends StatefulWidget {
  const InMatchPage({super.key});

  @override
  State<InMatchPage> createState() => _InMatchPageState();
}

class _InMatchPageState extends State<InMatchPage> {
  Timer? _timer;
  Duration _elapsed = Duration.zero;
  bool _isRunning = false;
  final double _currentKm = 3;

  void _toggleTimer() {
    if (_isRunning) {
      _timer?.cancel();
    } else {
      _timer = Timer.periodic(const Duration(seconds: 1), (_) {
        setState(() => _elapsed += const Duration(seconds: 1));
      });
    }
    setState(() => _isRunning = !_isRunning);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PrimaryAppBar(
        title: 'In Match',
        subtitle: 'Riverside Loop · Eco Sprint',
      ),
      body: AppBg(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Timer ─────────────────────────────────────────
                Center(
                  child: InMatchTimerWidget(
                    elapsed: _elapsed,
                    isRunning: _isRunning,
                    onToggle: _toggleTimer,
                  ),
                ),
                const SizedBox(height: 20),

                // ── Distance progress ─────────────────────────────
                InMatchDistanceCard(targetKm: 10, currentKm: _currentKm),
                const SizedBox(height: 20),

                // ── Route map ─────────────────────────────────────
                HostMatchRouteCard(
                  routeName: 'Riverside Loop',
                  tag: 'Suggested',
                ),
                const SizedBox(height: 20),

                // ── Standings ─────────────────────────────────────
                InMatchStandingsCard(
                  players: const [
                    InMatchPlayer(
                      name: 'Sofia Ansarui',
                      badge: 'Garden',
                      points: '480 pts',
                    ),
                    InMatchPlayer(
                      name: 'Sofia Ansarui',
                      badge: 'Phytoplankton',
                      points: '480 pts',
                    ),
                    InMatchPlayer(
                      name: 'Sofia Ansarui',
                      badge: 'Small Fish',
                      points: '480 pts',
                    ),
                    InMatchPlayer(
                      name: 'You',
                      badge: 'Small Fish',
                      points: '480 pts',
                      isYou: true,
                    ),
                  ],
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
