import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:path_app/core/widgets/app_bg.dart';
import 'package:path_app/core/widgets/secondary_app_bar.dart';
import 'package:path_app/features/profile/view/widgets/delete_account_dialog.dart';
import 'package:path_app/features/profile/view/widgets/profile_hero_card.dart';
import 'package:path_app/features/profile/view/widgets/profile_menu_section.dart';
import 'package:path_app/routes/routes_name.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const SecondaryAppBar(title: 'Profile', showBackButton: false),
      body: AppBg(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const ProfileHeroCard(
                  name: 'Kieran Tait',
                  rank: '🌌 Galaxy Rank',
                  winStreak: 6,
                  topPercent: '12%',
                  ecoScore: 94,
                ),

                //Profile
                const SizedBox(height: 16),
                ProfileMenuSection(
                  sectionTitle: 'Profile',
                  items: [
                    ProfileMenuItem(
                      title: 'Profile Update',
                      onTap: () => Get.toNamed(RoutesName.profileUpdate),
                    ),
                    ProfileMenuItem(
                      title: 'Insights',
                      onTap: () => Get.toNamed(RoutesName.insight),
                    ),
                    ProfileMenuItem(
                      title: 'Earnings',
                      onTap: () => Get.toNamed(RoutesName.earnings),
                    ),
                    ProfileMenuItem(
                      title: 'Achievement',
                      onTap: () => Get.toNamed(RoutesName.achievement),
                    ),
                    ProfileMenuItem(
                      title: 'Rank',
                      onTap: () => Get.toNamed(RoutesName.careerRank),
                    ),
                  ],
                ),

                //Account
                const SizedBox(height: 16),
                ProfileMenuSection(
                  sectionTitle: 'Account',
                  items: [
                    ProfileMenuItem(
                      title: 'Subscription',
                      onTap: () => Get.toNamed(
                        RoutesName.subscription,
                        arguments: {'isFromProfile': true},
                      ),
                    ),
                    ProfileMenuItem(
                      title: 'Change Password',
                      onTap: () => Get.toNamed(RoutesName.changePassword),
                    ),
                    ProfileMenuItem(
                      title: 'Connect Account',
                      onTap: () => Get.toNamed(RoutesName.connectAccount),
                    ),
                    ProfileMenuItem(
                      title: 'Delete Account',
                      onTap: () {
                        DeleteAccountDialog.show(context);
                      },
                    ),
                  ],
                ),

                //More
                const SizedBox(height: 16),
                ProfileMenuSection(
                  sectionTitle: 'More',
                  items: [
                    ProfileMenuItem(
                      title: 'Notification Preferences',
                      isNotification: true,
                      switchValue: _notificationsEnabled,
                      onSwitchChanged: (val) {
                        setState(() => _notificationsEnabled = val);
                      },
                    ),
                    ProfileMenuItem(
                      title: 'Help & Feedback',
                      onTap: () => Get.toNamed(RoutesName.helpAndFeedback),
                    ),
                    ProfileMenuItem(
                      title: 'FAQs',
                      onTap: () => Get.toNamed(RoutesName.faqs),
                    ),
                    ProfileMenuItem(
                      title: 'Terms & Conditions',
                      onTap: () => Get.toNamed(RoutesName.termsAndConditions),
                    ),
                    ProfileMenuItem(
                      title: 'Privacy Policy',
                      onTap: () => Get.toNamed(RoutesName.privacyPolicy),
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
