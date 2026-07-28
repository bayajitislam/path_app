import 'package:flutter/material.dart';
import 'package:path_app/core/theme/app_pallete.dart';

class InMatchTimerWidget extends StatelessWidget {
  final Duration elapsed;
  final bool isRunning;
  final VoidCallback? onToggle;

  const InMatchTimerWidget({
    super.key,
    required this.elapsed,
    this.isRunning = false,
    this.onToggle,
  });

  String get _formatted {
    final m = elapsed.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = elapsed.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          _formatted,
          style: const TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w300,
            color: AppPallete.primaryText,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 12),
        GestureDetector(
          onTap: onToggle,
          child: Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: AppPallete.primary,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppPallete.primary.withValues(alpha: 0.35),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: Icon(
                isRunning ? Icons.pause : Icons.play_arrow_rounded,
                color: AppPallete.white,
                size: 28,
              ),
            ),
          ),
        ),
      ],
    );
  }
}