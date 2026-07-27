import 'package:flutter/material.dart';
import 'package:path_app/core/widgets/app_bg.dart';
import 'package:path_app/core/widgets/primary_app_bar.dart';

class PlayPage extends StatelessWidget {
  const PlayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PrimaryAppBar(
        title: 'Match Lobby',
        showBackButton: false,
        subtitle: 'Wager, compete & earn green',
      ),
      body: AppBg(child: Center(child: Text('Play Page'))),
    );
  }
}
