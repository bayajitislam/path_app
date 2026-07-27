import 'package:flutter/material.dart';
import 'package:path_app/core/theme/app_pallete.dart';

class FaqItem extends StatelessWidget {
  final String question;
  final VoidCallback? onTap;

  const FaqItem({super.key, required this.question, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
        child: Row(
          children: [
            // Doc icon
            const Icon(
              Icons.insert_drive_file_outlined,
              size: 18,
              color: AppPallete.secondaryText,
            ),
            const SizedBox(width: 12),
            // Question
            Expanded(
              child: Text(
                question,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: AppPallete.primaryText,
                ),
              ),
            ),
            const SizedBox(width: 8),
            const Icon(
              Icons.chevron_right,
              size: 18,
              color: AppPallete.secondaryText,
            ),
          ],
        ),
      ),
    );
  }
}

class FaqList extends StatelessWidget {
  final List<String> questions;
  final void Function(int index)? onItemTap;

  const FaqList({super.key, required this.questions, this.onItemTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(questions.length, (i) {
        return Padding(
          padding: EdgeInsets.only(bottom: i < questions.length - 1 ? 10 : 0),
          child: FaqItem(
            question: questions[i],
            onTap: () => onItemTap?.call(i),
          ),
        );
      }),
    );
  }
}
