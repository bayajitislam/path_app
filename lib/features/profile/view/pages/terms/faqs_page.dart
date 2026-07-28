import 'package:flutter/material.dart';
import 'package:path_app/core/theme/app_pallete.dart';
import 'package:path_app/core/theme/app_text_style.dart';
import 'package:path_app/core/widgets/app_bg.dart';
import 'package:path_app/core/widgets/secondary_app_bar.dart';

class FaqsPage extends StatelessWidget {
  static Route route() => MaterialPageRoute(builder: (_) => const FaqsPage());
  const FaqsPage({super.key});

  static const List<Map<String, String>> _faqData = [
    {
      'question': 'What does this app do?',
      'answer':
          'CraftClimb helps you find jobs, courses, and career opportunities in the construction and trade industry. Connect with employers, trainers, and grow your career.',
    },
    {
      'question': 'How do I apply for a job?',
      'answer':
          'Browse jobs from the Jobs tab, tap on a job to view details, then tap "Apply Now". You can upload your resume and submit your application directly.',
    },
    {
      'question': 'How do I enroll in a course?',
      'answer':
          'Go to Career Hub, browse available courses, tap on a course to view details, and tap "Purchase" to enroll. Your courses will appear in My Courses.',
    },
    {
      'question': 'Is my data secure?',
      'answer':
          'Yes! We use encryption to protect your data. Your information is stored securely and never shared with third parties without your consent.',
    },
    {
      'question': 'How do I cancel my subscription?',
      'answer':
          'Go to Account → Subscription → Manage Subscription → Cancel Subscription. Your access will continue until the end of your billing period.',
    },
    {
      'question': 'How do I reset my password?',
      'answer':
          'On the login screen, tap "Forgot Password", enter your registered email, and we\'ll send you a reset link.',
    },
    {
      'question': 'Can I use this app offline?',
      'answer':
          'Some features are available offline. All changes will sync automatically when you reconnect to the internet.',
    },
    {
      'question': 'How do I become a trainer?',
      'answer':
          'Go to Account → Apply as a Trainer. Fill in the subject and application form and submit. Our team will review your application.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBg(
        child: Column(
          children: [
            const SecondaryAppBar(title: 'FAQs'),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                itemCount: _faqData.length,
                itemBuilder: (_, index) => FaqItem(
                  question: _faqData[index]['question']!,
                  answer: _faqData[index]['answer']!,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── FAQ Item Widget ──
class FaqItem extends StatefulWidget {
  final String question;
  final String answer;

  const FaqItem({super.key, required this.question, required this.answer});

  @override
  State<FaqItem> createState() => _FaqItemState();
}

class _FaqItemState extends State<FaqItem> with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _controller;
  late Animation<double> _expandAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() => _isExpanded = !_isExpanded);
    if (_isExpanded) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppPallete.border),
        boxShadow: [
          BoxShadow(
            color: Color(0xFFCFCFCF),
            blurRadius: 15,
            spreadRadius: 1,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          // ── Question Row ──
          GestureDetector(
            onTap: _toggle,
            child: Container(
              color: Colors.transparent,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.question,
                      style: AppTextStyle.s16w4i(color: AppPallete.primaryText),
                    ),
                  ),
                  const SizedBox(width: 8),

                  //  Animated + / x icon
                  AnimatedRotation(
                    turns: _isExpanded ? 0.125 : 0,
                    duration: const Duration(milliseconds: 250),
                    child: Icon(Icons.add, color: AppPallete.primary, size: 22),
                  ),
                ],
              ),
            ),
          ),

          // ── Answer ──
          SizeTransition(
            sizeFactor: _expandAnimation,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(height: 1, color: Colors.grey.shade100),
                  const SizedBox(height: 10),
                  Text(
                    widget.answer,
                    style: AppTextStyle.s14w4i(
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
