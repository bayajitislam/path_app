import 'package:flutter/material.dart';
import 'package:path_app/core/theme/app_pallete.dart';
import 'package:path_app/core/theme/app_text_style.dart';
import 'package:path_app/features/profile/view/widgets/social_link_row.dart';
import 'package:path_app/core/widgets/app_bg.dart';
import 'package:path_app/core/widgets/secondary_app_bar.dart';

// Component Import
// import 'package:path_app/features/connect_account/widgets/social_link_row.dart';

class SocialAccountItem {
  String platform;
  bool isConnected;

  SocialAccountItem({required this.platform, this.isConnected = false});
}

class ConnectAccountPage extends StatefulWidget {
  const ConnectAccountPage({super.key});

  @override
  State<ConnectAccountPage> createState() => _ConnectAccountPageState();
}

class _ConnectAccountPageState extends State<ConnectAccountPage> {
  final List<String> _platforms = ['Uber', 'Lyft', 'DoorDash', 'Deliveroo'];

  // Initial State Data matching screenshot (Row #2 is 'Connected')
  late List<SocialAccountItem> _accounts;

  @override
  void initState() {
    super.initState();
    _accounts = [
      SocialAccountItem(platform: 'Uber', isConnected: false),
      SocialAccountItem(platform: 'Uber', isConnected: true),
      SocialAccountItem(platform: 'Uber', isConnected: false),
      SocialAccountItem(platform: 'Uber', isConnected: false),
    ];
  }

  void _addSection() {
    setState(() {
      _accounts.add(SocialAccountItem(platform: 'Uber', isConnected: false));
    });
  }

  void _deleteSection(int index) {
    setState(() {
      _accounts.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const SecondaryAppBar(title: 'Connect Account'),
      body: AppBg(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),

                // Section Label
                Text(
                  'Social Media link',
                  style: AppTextStyle.s14w4i(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppPallete.primaryText,
                  ),
                ),

                const SizedBox(height: 16),

                // Dynamic List of Social Link Rows
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _accounts.length,
                  itemBuilder: (context, index) {
                    final item = _accounts[index];
                    return SocialLinkRow(
                      selectedPlatform: item.platform,
                      platforms: _platforms,
                      isConnected: item.isConnected,
                      onPlatformChanged: (newVal) {
                        if (newVal != null) {
                          setState(() {
                            item.platform = newVal;
                          });
                        }
                      },
                      onToggleConnect: () {
                        setState(() {
                          item.isConnected = !item.isConnected;
                        });
                      },
                      onDelete: () => _deleteSection(index),
                    );
                  },
                ),

                const SizedBox(height: 4),

                // "Add a Section" Action Button
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: _addSection,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(
                        0xFF2C4A32,
                      ), // Dark forest green
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Add a Section',
                      style: AppTextStyle.s14w4i(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: AppPallete.white,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
