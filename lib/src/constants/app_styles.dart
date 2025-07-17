import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_sizes.dart';

class AppStyles {
  AppStyles._();

  static final AppStyles _instance = AppStyles._();

  static AppStyles get instance => _instance;

  // Text Styles
  TextStyle get displayLarge => TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        letterSpacing: -0.5,
        height: 1.2,
      );

  TextStyle get displayMedium => TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        letterSpacing: -0.25,
        height: 1.3,
      );

  TextStyle get displaySmall => TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
        height: 1.4,
      );

  TextStyle get headlineLarge => TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
        height: 1.4,
      );

  TextStyle get headlineMedium => TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.15,
        height: 1.5,
      );

  TextStyle get headlineSmall => TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.15,
        height: 1.5,
      );

  TextStyle get titleLarge => TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.15,
        height: 1.5,
      );

  TextStyle get titleMedium => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
        height: 1.6,
      );

  TextStyle get titleSmall => TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
        height: 1.6,
      );

  TextStyle get bodyLarge => TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        letterSpacing: 0.5,
        height: 1.6,
      );

  TextStyle get bodyMedium => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        letterSpacing: 0.25,
        height: 1.6,
      );

  TextStyle get bodySmall => TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        letterSpacing: 0.4,
        height: 1.6,
      );

  TextStyle get labelLarge => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
        height: 1.6,
      );

  TextStyle get labelMedium => TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        height: 1.6,
      );

  TextStyle get labelSmall => TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        height: 1.6,
      );

  // Button Styles
  ButtonStyle get primaryButtonStyle => ButtonStyle(
        backgroundColor: MaterialStateProperty.all(AppColors.instance.primary),
        foregroundColor: MaterialStateProperty.all(Colors.white),
        elevation: MaterialStateProperty.all(0),
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
          ),
        ),
        textStyle: MaterialStateProperty.all(labelLarge),
      );

  ButtonStyle get secondaryButtonStyle => ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.transparent),
        foregroundColor: MaterialStateProperty.all(AppColors.instance.primary),
        elevation: MaterialStateProperty.all(0),
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
            side: BorderSide(color: AppColors.instance.primary),
          ),
        ),
        textStyle: MaterialStateProperty.all(labelLarge),
      );

  ButtonStyle get outlineButtonStyle => ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.transparent),
        foregroundColor: MaterialStateProperty.all(AppColors.instance.text),
        elevation: MaterialStateProperty.all(0),
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
            side: BorderSide(color: AppColors.instance.divider),
          ),
        ),
        textStyle: MaterialStateProperty.all(labelLarge),
      );

  // Card Styles
  BoxDecoration get cardDecoration => BoxDecoration(
        color: AppColors.instance.surface,
        borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      );

  BoxDecoration get elevatedCardDecoration => BoxDecoration(
        color: AppColors.instance.surface,
        borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      );

  // Input Styles
  InputDecoration get inputDecoration => InputDecoration(
        filled: true,
        fillColor: AppColors.instance.surfaceVariant,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
          borderSide: BorderSide(color: AppColors.instance.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
          borderSide: BorderSide(color: AppColors.instance.error, width: 2),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      );

  // Gradient Styles
  BoxDecoration get primaryGradientDecoration => BoxDecoration(
        gradient: AppColors.instance.primaryGradient,
        borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
      );

  BoxDecoration get accentGradientDecoration => BoxDecoration(
        gradient: AppColors.instance.accentGradient,
        borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
      );

  // Animation Durations
  Duration get animationFast => const Duration(milliseconds: 200);
  Duration get animationNormal => const Duration(milliseconds: 300);
  Duration get animationSlow => const Duration(milliseconds: 500);

  // Animation Curves
  Curve get animationCurve => Curves.easeInOut;
  Curve get animationCurveFast => Curves.easeOut;
  Curve get animationCurveSlow => Curves.easeInOutCubic;
}

// Extension for easy style access
extension AppStylesExtension on BuildContext {
  AppStyles get styles => AppStyles.instance;
}
