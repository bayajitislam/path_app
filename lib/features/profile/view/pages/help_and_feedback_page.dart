import 'package:flutter/material.dart';
import 'package:path_app/core/widgets/app_bg.dart';
import 'package:path_app/core/widgets/primary_app_bar.dart';
import 'package:path_app/features/home/view/widgets/section_header.dart';
import 'package:path_app/features/profile/view/widgets/contact_action_row.dart';
import 'package:path_app/features/profile/view/widgets/faq_list.dart';
import 'package:path_app/features/profile/view/widgets/send_feedback_card.dart';

class HelpAndFeedbackPage extends StatelessWidget {
  HelpAndFeedbackPage({super.key});

  final TextEditingController _feedbackController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PrimaryAppBar(
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
                  questions: [
                    'How is my eco-score calculated?',
                    'When are jackpot payouts processed?',
                    'How do I link my Uber Eats account?',
                    'What happens if I lose a wager?',
                  ],
                  onItemTap: (i) {},
                ),
                const SizedBox(height: 16),
                SendFeedbackCard(
                  controller: _feedbackController,
                  onSubmit: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
