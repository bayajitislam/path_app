import 'package:flutter/material.dart';
import 'package:path_app/core/common/app_dialog.dart';
import 'package:path_app/core/widgets/app_bg.dart';
import 'package:path_app/core/widgets/primary_app_bar.dart';
import 'package:path_app/features/home/view/widgets/section_header.dart';
import 'package:path_app/features/profile/view/widgets/contact_action_row.dart';
import 'package:path_app/features/profile/view/widgets/faq_list.dart';
import 'package:path_app/features/profile/view/widgets/send_feedback_card.dart';

class HelpAndFeedbackPage extends StatefulWidget {
  const HelpAndFeedbackPage({super.key});

  @override
  State<HelpAndFeedbackPage> createState() => _HelpAndFeedbackPageState();
}

class _HelpAndFeedbackPageState extends State<HelpAndFeedbackPage> {
  final TextEditingController _feedbackController = TextEditingController();

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const PrimaryAppBar(
        title: 'Support & Feedback',
        subtitle: 'How can we help you today?',
      ),
      body: AppBg(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              children: [
                ContactActionRow(onCallUs: () {}, onLiveChat: () {}),
                const SizedBox(height: 16),

                SectionHeader(title: 'Frequently Asked Questions'),
                const SizedBox(height: 16),

                FaqList(
                  items: const [
                    {
                      'question': 'How is my eco-score calculated?',
                      'answer':
                          'Your eco-score is calculated by analyzing your driving smoothness, engine idle time, fuel efficiency, and speed consistency compared to benchmark delivery routes.',
                    },
                    {
                      'question': 'When are jackpot payouts processed?',
                      'answer':
                          'Weekly jackpot pools are finalized every Sunday at 11:59 PM UTC, while monthly mega-pots are processed on the 1st of each month directly to your in-app wallet balance.',
                    },
                    {
                      'question': 'How do I link my Uber Eats account?',
                      'answer':
                          'Go to Profile → Account → Connect Account. Select Uber Eats, enter your driver credentials, and grant sync permissions to enable automatic trip logging.',
                    },
                    {
                      'question': 'What happens if I lose a wager?',
                      'answer':
                          'If you lose a wager match, only the wager stake points entered into that match are forfeited to the prize pot. Your base career rank, tier points, and wallet earnings remain intact.',
                    },
                  ],
                ),
                const SizedBox(height: 16),
                SendFeedbackCard(
                  controller: _feedbackController,
                  onSubmit: () {
                    //OPNE DIALOG
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AppDialog(
                          message: 'We are working on this feature',
                          type: DialogType.info,
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
