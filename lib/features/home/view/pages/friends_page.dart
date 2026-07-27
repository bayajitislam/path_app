import 'package:flutter/material.dart';
import 'package:path_app/core/theme/app_pallete.dart';
import 'package:path_app/core/widgets/app_bg.dart';
import 'package:path_app/core/widgets/primary_app_bar.dart';
import 'package:path_app/features/home/view/widgets/challenge_card.dart';

class FriendsPage extends StatelessWidget {
  const FriendsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PrimaryAppBar(
        title: 'Friends',
        subtitle: 'Your friends · 2 online',
      ),
      body: AppBg(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              children: [
                //Search
                SearchBar(
                  backgroundColor: WidgetStatePropertyAll(AppPallete.white),
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  elevation: WidgetStatePropertyAll(0),
                  leading: Icon(Icons.search, color: AppPallete.primaryText),
                  hintText: 'Search by player name or @handle',
                  constraints: BoxConstraints(maxHeight: 40, minHeight: 40),
                ),

                //All Friends
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.only(top: 12),
                    itemCount: 4,
                    itemBuilder: (_, _) =>
                        ChallengeCard(name: 'Maya Osel', rank: 'Daimon I'),
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
