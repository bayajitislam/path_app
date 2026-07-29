import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:path_app/core/widgets/app_bg.dart';
import 'package:path_app/core/widgets/secondary_app_bar.dart';
import 'package:path_app/features/profile/view/widgets/delete_account_dailog.dart';
import 'package:path_app/features/profile/view/widgets/profile_hero_card.dart';
import 'package:path_app/features/profile/view/widgets/profile_menu_section.dart';
import 'package:path_app/routes/routes_name.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: SecondaryAppBar(title: 'Profile', showBackButton: false),
      body: AppBg(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                ProfileHeroCard(
                  name: 'Kieran Tait',
                  rank: '🌌 Galaxy Rank',
                  winStreak: 6,
                  topPercent: '12%',
                  ecoScore: 94,
                ),

                //Profile
                SizedBox(height: 16),
                ProfileMenuSection(
                  sectionTitle: 'Profile',
                  items: [
                    ProfileMenuItem(
                      title: 'Profile Update',
                      onTap: () => Get.toNamed(RoutesName.profileUpdate),
                    ),
                    ProfileMenuItem(
                      title: 'Wallet',
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
                SizedBox(height: 16),
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
                        // Delete account
                        //Open Dialog
                        DeleteAccountDialog.show(context);
                      },
                    ),
                  ],
                ),

                //More
                SizedBox(height: 16),
                ProfileMenuSection(
                  sectionTitle: 'More',
                  items: [
                    ProfileMenuItem(
                      title: 'Notification Preferences',
                      isNotification: true,
                      switchValue: false,
                      onSwitchChanged: (val) {
                        // Update state
                      },
                    ),
                    ProfileMenuItem(
                      title: 'Terms & Conditionss',
                      onTap: () => Get.toNamed(RoutesName.termsAndConditions),
                    ),
                    ProfileMenuItem(
                      title: 'Privacy Policy',
                      onTap: () => Get.toNamed(RoutesName.privacyPolicy),
                    ),
                    ProfileMenuItem(
                      title: 'Faq’s',
                      onTap: () => Get.toNamed(RoutesName.faqs),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
