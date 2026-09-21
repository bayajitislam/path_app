import 'package:flutter/material.dart';
import 'package:path_app/core/common/app_loader.dart';
import 'package:path_app/core/theme/app_pallete.dart';
import 'package:path_app/core/theme/app_text_style.dart';

/// A primary action button that supports both gradient and solid color modes.
///
/// **Gradient mode** (default):
/// ```dart
/// PrimaryButton(buttonName: 'Login', onPressed: () {})
/// ```
///
/// **Custom gradient:**
/// ```dart
/// PrimaryButton(
///   buttonName: 'Login',
///   onPressed: () {},
///   gradientColors: [Color(0xFF...), Color(0xFF...)],
/// )
/// ```
///
/// **Solid color mode:**
/// ```dart
/// PrimaryButton(
///   buttonName: 'Login',
///   onPressed: () {},
///   useGradient: false,
///   solidColor: AppPallete.primary,
/// )
/// ```
class PrimaryButton extends StatelessWidget {
  final String buttonName;
  final double borderRadius;
  final bool isLoading;
  final void Function()? onPressed;

  /// When `true` (default), the button renders a left-to-right gradient.
  final bool useGradient;

  /// Gradient colors used when [useGradient] is `true`.
  /// Defaults to `[#4AB9E6, #34C759]` (teal → green).
  final List<Color>? gradientColors;

  /// Solid background color used when [useGradient] is `false`.
  /// Defaults to [AppPallete.primary].
  final Color? solidColor;

  static const List<Color> _defaultGradient = [
    Color(0xFF4AB9E6), // teal
    Color(0xFF34C759), // green
  ];

  const PrimaryButton({
    super.key,
    required this.buttonName,
    required this.onPressed,
    this.isLoading = false,
    this.borderRadius = 10,
    this.useGradient = true,
    this.gradientColors,
    this.solidColor,
  });

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(borderRadius);

    if (!useGradient) {
      // ── Solid colour button ──────────────────────────────────────────────
      return ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor:
              isLoading ? AppPallete.secondary : (solidColor ?? AppPallete.primary),
          minimumSize: const Size.fromHeight(45),
          shape: RoundedRectangleBorder(borderRadius: radius),
          elevation: 0,
        ),
        child: _child,
      );
    }

    // ── Gradient button ────────────────────────────────────────────────────
    final colors = isLoading
        ? [AppPallete.secondary, AppPallete.secondary]
        : (gradientColors ?? _defaultGradient);

    return Material(
      color: Colors.transparent,
      borderRadius: radius,
      child: Ink(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: colors,
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: radius,
        ),
        child: InkWell(
          onTap: isLoading ? null : onPressed,
          borderRadius: radius,
          splashColor: Colors.white.withAlpha(40),
          highlightColor: Colors.white.withAlpha(20),
          child: SizedBox(
            height: 45,
            width: double.infinity,
            child: Center(child: _child),
          ),
        ),
      ),
    );
  }

  Widget get _child => isLoading
      ? const AppLoader(color: AppPallete.secondary)
      : Text(
          buttonName,
          style: AppTextStyle.s16w4i(
            color: AppPallete.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        );
}