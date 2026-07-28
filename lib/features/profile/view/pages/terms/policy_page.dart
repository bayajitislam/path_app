import 'package:flutter/material.dart';
import 'package:path_app/core/theme/app_pallete.dart';
import 'package:path_app/core/theme/app_text_style.dart';
import 'package:path_app/core/widgets/app_bg.dart';
import 'package:path_app/core/widgets/secondary_app_bar.dart';

// ── Shared Model ──
class PolicySection {
  final String title;
  final String? paragraph;
  final List<String> bullets;

  const PolicySection({
    required this.title,
    this.paragraph,
    this.bullets = const [],
  });
}

// ── Shared Policy Page ──
class PolicyPage extends StatelessWidget {
  final String pageTitle;
  final String intro;
  final List<PolicySection> sections;

  const PolicyPage({
    super.key,
    required this.pageTitle,
    required this.intro,
    required this.sections,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBg(
        child: Column(
          children: [
            // ── Page Title ──
            SecondaryAppBar(title: pageTitle),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Intro ──
                    Text(
                      intro,
                      style: AppTextStyle.s14w4i(color: AppPallete.primaryText),
                    ),
                    const SizedBox(height: 16),

                    // ── Sections ──
                    ...sections.map(
                      (section) => Padding(
                        padding: const EdgeInsets.only(bottom: 14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Section Title
                            Text(
                              section.title,
                              style: AppTextStyle.s16w4i(
                                fontWeight: FontWeight.w800,
                                color: AppPallete.primaryText,
                              ),
                            ),
                            const SizedBox(height: 6),

                            // Paragraph
                            if (section.paragraph != null)
                              Text(
                                section.paragraph!,
                                style: AppTextStyle.s16w4i(
                                  color: AppPallete.primaryText,
                                ),
                              ),

                            // Bullets
                            if (section.bullets.isNotEmpty)
                              ...section.bullets.map(
                                (b) => Padding(
                                  padding: const EdgeInsets.only(bottom: 4),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '• ',
                                        style: AppTextStyle.s14w4i(
                                          color: AppPallete.primaryText,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          b,
                                          style: AppTextStyle.s14w4i(
                                            color: AppPallete.primaryText,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
