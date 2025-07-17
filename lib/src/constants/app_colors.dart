import 'package:internal_core/internal_core.dart';
import 'package:flutter/material.dart';

import '../utils/utils.dart';
import '../utils/app_prefs.dart';
import 'app_constants.dart';

// Color palette definitions
class ColorPalette {
  final Color primary;
  final Color secondary;
  final Color accent;
  final Color success;
  final Color warning;
  final Color error;
  final String name;

  const ColorPalette({
    required this.primary,
    required this.secondary,
    required this.accent,
    required this.success,
    required this.warning,
    required this.error,
    required this.name,
  });
}

// Keep original getters for backward compatibility
Color get appColorBackground => AppColors.instance.background;
Color get appColorElement => AppColors.instance.element;
Color get appColorPrimary => AppColors.instance.primary;
Color get appColorText => AppColors.instance.text;

class AppColors {
  AppColors._();

  static final AppColors _instance = AppColors._();

  static AppColors get instance => _instance;

  // Available color palettes
  static const List<ColorPalette> availablePalettes = [
    ColorPalette(
      name: 'Ocean Blue',
      primary: Color(0xFF00BDF9),
      secondary: Color(0xFF0066CC),
      accent: Color(0xFF00E5FF),
      success: Color(0xFF4CAF50),
      warning: Color(0xFFFF9800),
      error: Color(0xFFF44336),
    ),
    ColorPalette(
      name: 'Forest Green',
      primary: Color(0xFF4CAF50),
      secondary: Color(0xFF2E7D32),
      accent: Color(0xFF66BB6A),
      success: Color(0xFF4CAF50),
      warning: Color(0xFFFF9800),
      error: Color(0xFFF44336),
    ),
    ColorPalette(
      name: 'Sunset Orange',
      primary: Color(0xFFFF5722),
      secondary: Color(0xFFD84315),
      accent: Color(0xFFFF7043),
      success: Color(0xFF4CAF50),
      warning: Color(0xFFFF9800),
      error: Color(0xFFF44336),
    ),
    ColorPalette(
      name: 'Royal Purple',
      primary: Color(0xFF9C27B0),
      secondary: Color(0xFF7B1FA2),
      accent: Color(0xFFBA68C8),
      success: Color(0xFF4CAF50),
      warning: Color(0xFFFF9800),
      error: Color(0xFFF44336),
    ),
    ColorPalette(
      name: 'Golden Yellow',
      primary: Color(0xFFFFC107),
      secondary: Color(0xFFFF8F00),
      accent: Color(0xFFFFD54F),
      success: Color(0xFF4CAF50),
      warning: Color(0xFFFF9800),
      error: Color(0xFFF44336),
    ),
    ColorPalette(
      name: 'Rose Pink',
      primary: Color(0xFFE91E63),
      secondary: Color(0xFFC2185B),
      accent: Color(0xFFF06292),
      success: Color(0xFF4CAF50),
      warning: Color(0xFFFF9800),
      error: Color(0xFFF44336),
    ),
  ];

  // Get current palette
  ColorPalette get currentPalette {
    final index = AppPrefs.instance.colorPaletteIndex;
    return availablePalettes[index.clamp(0, availablePalettes.length - 1)];
  }

  // Original getters (keep for backward compatibility)
  Color get text => appValueByTheme(
        const Color(0xFF1A1A1A),
        kdark: const Color(0xFFF5F5F5),
      );

  Color get background => appValueByTheme(
        const Color(0xFFFFFFFF),
        kdark: const Color(0xFF121212),
      );

  Color get element => appValueByTheme(
        const Color(0xFFE0E0E0),
        kdark: const Color(0xFF3A3A3A),
      );

  Color get primary => currentPalette.primary;

  // New color getters
  Color get textSecondary => appValueByTheme(
        const Color(0xFF666666),
        kdark: const Color(0xFFB0B0B0),
      );

  Color get surface => appValueByTheme(
        const Color(0xFFF8F9FA),
        kdark: const Color(0xFF1E1E1E),
      );

  Color get surfaceVariant => appValueByTheme(
        const Color(0xFFF0F0F0),
        kdark: const Color(0xFF2A2A2A),
      );

  Color get divider => appValueByTheme(
        const Color(0xFFE0E0E0),
        kdark: const Color(0xFF3A3A3A),
      );

  // Primary colors from current palette
  Color get secondary => currentPalette.secondary;
  Color get accent => currentPalette.accent;
  Color get success => currentPalette.success;
  Color get warning => currentPalette.warning;
  Color get error => currentPalette.error;

  // Gradient colors
  LinearGradient get primaryGradient => LinearGradient(
        colors: [
          currentPalette.primary,
          currentPalette.secondary,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );

  // Gradient colors
  LinearGradient get lightPrimaryGradient => LinearGradient(
        colors: [
          AppColors.instance.premiumGoldLight,
          Colors.white,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );

  LinearGradient get accentGradient => LinearGradient(
        colors: [
          currentPalette.accent,
          currentPalette.primary,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );

  LinearGradient get backgroundGradient => LinearGradient(
        colors: [
          background,
          surface,
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );

  // Original shimmer colors (keep for backward compatibility)
  Color get shimmerHighlightColor => appValueByTheme(
        const Color(0xFFE0E0E0),
        kdark: const Color(0xFF3A3A3A),
      );

  Color get shimmerBaseColor => appValueByTheme(
        const Color(0xFFF5F5F5),
        kdark: const Color(0xFF2A2A2A),
      );

  // Original hover color (keep for backward compatibility)
  Color get hoverColor => appValueByTheme(
        const Color(0xFFF0F0F0),
        kdark: const Color(0xFF2A2A2A),
      );

  // QR Code specific colors
  Color get qrCodeBackground => appValueByTheme(
        const Color(0xFFFFFFFF),
        kdark: const Color(0xFF1A1A1A),
      );

  Color get qrCodeForeground => appValueByTheme(
        const Color(0xFF000000),
        kdark: const Color(0xFFFFFFFF),
      );

  // Premium colors
  /// Premium colors (tông màu mới: xanh lam kết hợp vàng đồng, phù hợp với chủ đề hiện đại)
  Color get premiumGold =>
      const Color(0xFF3BA3F2); // Xanh lam sáng (primary blue)
  Color get premiumGoldLight =>
      const Color(0xFF81D4FA); // Xanh lam nhạt (light blue, đã giảm độ sáng)
  Color get premiumGoldDark =>
      const Color(0xFF1976D2); // Xanh lam đậm (dark blue)
  Color get premiumAmber =>
      const Color(0xFF64B5F6); // Xanh lam trung tính (blue accent)
  Color get premiumYellow =>
      const Color(0xFF90CAF9); // Xanh lam pastel (pastel blue)
  Color get premiumOrange =>
      const Color(0xFF1565C0); // Xanh lam navy (navy blue)

  // Premium gradients
  LinearGradient get premiumGradient => LinearGradient(
        colors: [
          premiumGold,
          premiumGoldLight,
          premiumAmber,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );

  LinearGradient get premiumGradientVertical => LinearGradient(
        colors: [
          premiumGold,
          premiumAmber,
          premiumOrange,
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );

  RadialGradient get premiumGradientRadial => RadialGradient(
        colors: [
          premiumGoldLight,
          premiumGold,
          premiumGoldDark,
        ],
        center: Alignment.center,
        radius: 0.8,
      );

  // Premium shimmer colors
  Color get premiumShimmerBase => const Color(0xFFFFF8E1);
  Color get premiumShimmerHighlight => const Color(0xFFFFFDE7);
}

// Keep original helper function for backward compatibility
Color appValueByTheme(Color klight, {Color? kdark}) {
  if (AppPrefs.instance.isDarkTheme) {
    return kdark ?? klight;
  }
  return klight;
}

// Extension for easy color access
extension AppColorsExtension on BuildContext {
  AppColors get colors => AppColors.instance;
}
