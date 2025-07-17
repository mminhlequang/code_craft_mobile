import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:internal_core/internal_core.dart';

import '../../constants/constants.dart';
import '../../utils/app_go_router.dart';
import '../../utils/app_prefs.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _textController;
  late AnimationController _fadeController;

  late Animation<double> _logoScaleAnimation;
  late Animation<double> _logoRotationAnimation;
  late Animation<double> _textSlideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startAnimations();
  }

  void _initializeAnimations() {
    // Logo animation controller
    _logoController = AnimationController(
      duration: AppStyles.instance.animationSlow,
      vsync: this,
    );

    // Text animation controller
    _textController = AnimationController(
      duration: AppStyles.instance.animationNormal,
      vsync: this,
    );

    // Fade animation controller
    _fadeController = AnimationController(
      duration: AppStyles.instance.animationFast,
      vsync: this,
    );

    // Logo scale animation
    _logoScaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoController,
      curve: Curves.elasticOut,
    ));

    // Logo rotation animation
    _logoRotationAnimation = Tween<double>(
      begin: -0.5,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _logoController,
      curve: Curves.easeOutBack,
    ));

    // Text slide animation
    _textSlideAnimation = Tween<double>(
      begin: 50.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _textController,
      curve: Curves.easeOutCubic,
    ));

    // Fade animation
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    ));
  }

  void _startAnimations() async {
    // Start logo animation
    await _logoController.forward();

    // Start text animation
    await _textController.forward();

    // Start fade animation
    await _fadeController.forward();

    // Wait a bit then navigate
    await Future.delayed(const Duration(milliseconds: 500));

    if (mounted) {
      AppGoRouter.instance.goToIntroduction();
    }
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness:
            AppPrefs.instance.isDarkTheme ? Brightness.light : Brightness.dark,
        systemNavigationBarColor: context.colors.background,
        systemNavigationBarIconBrightness:
            AppPrefs.instance.isDarkTheme ? Brightness.light : Brightness.dark,
      ),
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: context.colors.backgroundGradient,
          ),
          child: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo Section
                  AnimatedBuilder(
                    animation: _logoController,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _logoScaleAnimation.value,
                        child: Transform.rotate(
                          angle: _logoRotationAnimation.value,
                          child: Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              gradient: context.colors.primaryGradient,
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      context.colors.primary.withOpacity(0.3),
                                  blurRadius: 20,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.qr_code_scanner,
                              size: 60,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: AppSizes.paddingXLarge),

                  // App Name Section
                  AnimatedBuilder(
                    animation: _textController,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(0, _textSlideAnimation.value),
                        child: FadeTransition(
                          opacity: _fadeAnimation,
                          child: Column(
                            children: [
                              Text(
                                appName,
                                style: context.styles.displayMedium.copyWith(
                                  color: context.colors.text,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: AppSizes.paddingSmall),
                              Text(
                                'Create. Scan. Connect.',
                                style: context.styles.bodyLarge.copyWith(
                                  color: context.colors.textSecondary,
                                  letterSpacing: 1.2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: AppSizes.paddingXXLarge),

                  // Loading Indicator
                  AnimatedBuilder(
                    animation: _fadeController,
                    builder: (context, child) {
                      return FadeTransition(
                        opacity: _fadeAnimation,
                        child: SizedBox(
                          width: 40,
                          height: 40,
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              context.colors.primary,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
