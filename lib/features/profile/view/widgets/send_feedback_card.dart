import 'package:flutter/material.dart';
import 'package:path_app/core/theme/app_pallete.dart';

class SendFeedbackCard extends StatelessWidget {
  final TextEditingController? controller;
  final VoidCallback? onSubmit;

  const SendFeedbackCard({super.key, this.controller, this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppPallete.primaryText,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Send Feedback',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppPallete.white,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Help us improve the Path driver experience.',
            style: TextStyle(fontSize: 14, color: Color(0xFF9CA3AF)),
          ),
          const SizedBox(height: 16),
          // Text field
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF2A2A3A),
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextField(
              controller: controller,
              maxLines: 4,
              style: const TextStyle(fontSize: 13, color: AppPallete.white),
              decoration: const InputDecoration(
                hintText: 'Tell us what you think...',
                hintStyle: TextStyle(fontSize: 13, color: Colors.white38),
                contentPadding: EdgeInsets.all(14),
                border: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Submit button
          SizedBox(
            width: double.infinity,
            child: GestureDetector(
              onTap: onSubmit,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: const Color(0xFF059669),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Text(
                    'Submit Feedback',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppPallete.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
