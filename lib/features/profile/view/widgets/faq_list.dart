import 'package:flutter/material.dart';
import 'package:path_app/core/theme/app_pallete.dart';

class FaqItem extends StatefulWidget {
  final String question;
  final String answer;
  final VoidCallback? onTap;

  const FaqItem({
    super.key,
    required this.question,
    required this.answer,
    this.onTap,
  });

  @override
  State<FaqItem> createState() => _FaqItemState();
}

class _FaqItemState extends State<FaqItem> with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late final AnimationController _animController;
  late final Animation<double> _expandAnimation;
  late final Animation<double> _rotateAnimation;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 240),
    );
    _expandAnimation = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeInOut,
    );
    _rotateAnimation = Tween<double>(begin: 0.0, end: 0.25).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _animController.forward();
      } else {
        _animController.reverse();
      }
    });
    widget.onTap?.call();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppPallete.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: _toggle,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    // Doc icon
                    Icon(
                      _isExpanded
                          ? Icons.article_rounded
                          : Icons.insert_drive_file_outlined,
                      size: 18,
                      color: _isExpanded
                          ? AppPallete.primary
                          : AppPallete.secondaryText,
                    ),
                    const SizedBox(width: 12),
                    // Question
                    Expanded(
                      child: Text(
                        widget.question,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: _isExpanded
                              ? FontWeight.w600
                              : FontWeight.w500,
                          color: AppPallete.primaryText,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    RotationTransition(
                      turns: _rotateAnimation,
                      child: const Icon(
                        Icons.chevron_right,
                        size: 18,
                        color: AppPallete.secondaryText,
                      ),
                    ),
                  ],
                ),
                SizeTransition(
                  sizeFactor: _expandAnimation,
                  alignment: Alignment.topCenter,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 12),
                      const Divider(
                        height: 1,
                        thickness: 1,
                        color: Color(0xFFF3F4F6),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        widget.answer,
                        style: const TextStyle(
                          fontSize: 12.5,
                          height: 1.5,
                          fontWeight: FontWeight.w400,
                          color: AppPallete.secondaryText,
                        ),
                      ),
                    ],
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

class FaqList extends StatelessWidget {
  final List<String>? questions;
  final List<String>? answers;
  final List<Map<String, String>>? items;
  final void Function(int index)? onItemTap;

  const FaqList({
    super.key,
    this.questions,
    this.answers,
    this.items,
    this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> data =
        items ??
        List.generate(questions?.length ?? 0, (i) {
          final q = questions![i];
          final a = (answers != null && i < answers!.length)
              ? answers![i]
              : _getDefaultAnswer(q);
          return {'question': q, 'answer': a};
        });

    return Column(
      children: List.generate(data.length, (i) {
        return Padding(
          padding: EdgeInsets.only(bottom: i < data.length - 1 ? 10 : 0),
          child: FaqItem(
            question: data[i]['question'] ?? '',
            answer: data[i]['answer'] ?? '',
            onTap: () => onItemTap?.call(i),
          ),
        );
      }),
    );
  }

  static String _getDefaultAnswer(String question) {
    final q = question.toLowerCase();
    if (q.contains('eco-score')) {
      return 'Your eco-score is calculated based on safe driving habits, fuel efficiency, smooth acceleration, minimal idle time, and green transit choices.';
    }
    if (q.contains('jackpot')) {
      return 'Jackpot payouts are processed at the close of every weekly and monthly cycle directly into your in-app wallet balance.';
    }
    if (q.contains('uber') || q.contains('account')) {
      return 'Navigate to Profile → Account → Connect Account, select your platform, and authorize sync to automatically import your delivery trips.';
    }
    if (q.contains('wager')) {
      return 'If you lose a wager match, only the wager stake points are transferred to the pot for the winner. Your account points and rank tier stay safe.';
    }
    return 'For additional details or support regarding this topic, please contact our support team using the Call Us or Live Chat buttons above.';
  }
}
