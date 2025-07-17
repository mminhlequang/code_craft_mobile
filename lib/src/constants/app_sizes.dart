import '../utils/utils.dart';

double get appPaddingHori => 20.sw;

extension ScaleExt on num {
  double get s => this * scaleW(appContext);
  double get sw2 => this * (scaleW(appContext) < .2 ? .2 : scaleW(appContext));
  double get sw3 => this * (scaleW(appContext) < .3 ? .3 : scaleW(appContext));
  double get sw4 => this * (scaleW(appContext) < .4 ? .4 : scaleW(appContext));
  double get sw5 => this * (scaleW(appContext) < .5 ? .5 : scaleW(appContext));
  double get sw6 => this * (scaleW(appContext) < .6 ? .6 : scaleW(appContext));
  double get sw7 => this * (scaleW(appContext) < .7 ? .7 : scaleW(appContext));
  double get sw8 => this * (scaleW(appContext) < .8 ? .8 : scaleW(appContext));
  double get sw9 => this * (scaleW(appContext) < .9 ? .9 : scaleW(appContext));

  double get sw => this * 1.0;
}

double scaleW(context, [double v = 1]) {
  if (context == null) return 1.0;
  // if (MediaQuery.sizeOf(context).width >= 1280) return 1;
  // return MediaQuery.sizeOf(context).width / 1280 * v;
  return 1.0;
}

// Font Sizes
double fs44([context]) => 44.sw;
double fs36([context]) => 36.sw;
double fs32([context]) => 32.sw;
double fs28([context]) => 28.sw;
double fs24([context]) => 24.sw;
double fs20([context]) => 20.sw;
double fs18([context]) => 18.sw;
double fs16([context]) => 16.sw;
double fs14([context]) => 14.sw;
double fs12([context]) => 12.sw;
double fs10([context]) => 10.sw;
double fs8([context]) => 8.sw;

// Spacing
class AppSizes {
  AppSizes._();

  // Padding & Margins
  static const double paddingTiny = 4.0;
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;
  static const double paddingXLarge = 32.0;
  static const double paddingXXLarge = 48.0;

  // Border Radius
  static const double radiusTiny = 4.0;
  static const double radiusSmall = 8.0;
  static const double radiusMedium = 12.0;
  static const double radiusLarge = 16.0;
  static const double radiusXLarge = 24.0;
  static const double radiusXXLarge = 32.0;

  // Icon Sizes
  static const double iconTiny = 12.0;
  static const double iconSmall = 16.0;
  static const double iconMedium = 24.0;
  static const double iconLarge = 32.0;
  static const double iconXLarge = 48.0;

  // Button Heights
  static const double buttonHeightSmall = 36.0;
  static const double buttonHeightMedium = 48.0;
  static const double buttonHeightLarge = 56.0;

  // Input Heights
  static const double inputHeightSmall = 40.0;
  static const double inputHeightMedium = 48.0;
  static const double inputHeightLarge = 56.0;

  // Card Elevations
  static const double elevationNone = 0.0;
  static const double elevationSmall = 2.0;
  static const double elevationMedium = 4.0;
  static const double elevationLarge = 8.0;
  static const double elevationXLarge = 16.0;

  // QR Code Sizes
  static const double qrCodeSizeSmall = 200.0;
  static const double qrCodeSizeMedium = 300.0;
  static const double qrCodeSizeLarge = 400.0;

  // Animation Durations
  static const Duration animationFast = Duration(milliseconds: 200);
  static const Duration animationNormal = Duration(milliseconds: 300);
  static const Duration animationSlow = Duration(milliseconds: 500);
  static const Duration animationVerySlow = Duration(milliseconds: 800);

  // Screen Breakpoints
  static const double mobileBreakpoint = 600.0;
  static const double tabletBreakpoint = 900.0;
  static const double desktopBreakpoint = 1200.0;
}
