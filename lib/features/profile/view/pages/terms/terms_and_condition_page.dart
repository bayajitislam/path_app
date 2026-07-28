import 'package:flutter/material.dart';
import 'package:path_app/features/profile/view/pages/terms/policy_page.dart';

class TermsAndConditionsPage extends StatelessWidget {
  static Route route() =>
      MaterialPageRoute(builder: (_) => const TermsAndConditionsPage());
  const TermsAndConditionsPage({super.key});

  static const String _intro =
      'This Privacy Policy describes how we collect, use, and protect your information when you use our Money Management App ("we," "our," or "us"). By using the app, you agree to this policy.';

  static const List<PolicySection> _sections = [
    PolicySection(
      title: 'Information We Collect',
      bullets: [
        'Personal details such as your name, email, and phone number.',
        'Financial data you enter manually, such as income, expenses, and savings goals.',
        'Device information (for performance and analytics).',
      ],
    ),
    PolicySection(
      title: 'How We Use Your Data',
      bullets: [
        'To track and visualize your spending and income.',
        'To personalize insights, reminders, and budgeting tips.',
        'To improve app performance and user experience.',
      ],
    ),
    PolicySection(
      title: 'Data Security',
      paragraph:
          'We use encryption and secure storage to keep your information safe. Your data is never sold to third parties.',
    ),
    PolicySection(
      title: 'Third-Party Services',
      paragraph:
          'Some app features may integrate with secure third-party services (like Google or Apple Sign-In). We never share your financial data without your consent.',
    ),
    PolicySection(
      title: 'Your Control',
      paragraph:
          'You can delete your account and all data anytime from Settings → Delete Account.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return PolicyPage(
      pageTitle: 'Terms & Conditions',
      intro: _intro,
      sections: _sections,
    );
  }
}