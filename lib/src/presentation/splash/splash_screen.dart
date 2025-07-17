import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:internal_core/internal_core.dart';

import '../../constants/constants.dart';
import '../../utils/app_go_router.dart';
import '../../utils/app_prefs.dart';
import '../widgets/widgets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _mainController;
  late AnimationController _particleController;
  late AnimationController _textController;
  late AnimationController _pulseController;

  late Animation<double> _logoScaleAnimation;
  late Animation<double> _logoRotationAnimation;
  late Animation<double> _logoOpacityAnimation;
  late Animation<double> _particleAnimation;
  late Animation<double> _textSlideAnimation;
  late Animation<double> _textOpacityAnimation;
  late Animation<double> _pulseAnimation;

  final List<Animation<double>> _particleAnimations = [];
  final List<Animation<Offset>> _particleSlideAnimations = [];

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startAnimations();
  }

  void _initializeAnimations() {
    // Main animation controller
    _mainController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    // Particle animation controller
    _particleController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );

    // Text animation controller
    _textController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    // Pulse animation controller
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    // Logo animations
    _logoScaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _mainController,
      curve: const Interval(0.0, 0.6, curve: Curves.elasticOut),
    ));

    _logoRotationAnimation = Tween<double>(
      begin: -0.5,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _mainController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOutBack),
    ));

    _logoOpacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _mainController,
      curve: const Interval(0.0, 0.4, curve: Curves.easeIn),
    ));

    // Particle animations
    _particleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _particleController,
      curve: Curves.easeInOut,
    ));

    // Text animations
    _textSlideAnimation = Tween<double>(
      begin: 100.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _textController,
      curve: const Interval(0.0, 0.8, curve: Curves.easeOutCubic),
    ));

    _textOpacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _textController,
      curve: const Interval(0.2, 1.0, curve: Curves.easeIn),
    ));

    // Pulse animation
    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    // Initialize particle animations
    for (int i = 0; i < 5; i++) {
      final startTime = i * 0.2;
      final endTime = startTime + 0.3;
      final slideEndTime = startTime + 0.5;

      // Ensure all values are within [0, 1] range
      final safeStartTime = startTime.clamp(0.0, 1.0);
      final safeEndTime = endTime.clamp(0.0, 1.0);
      final safeSlideEndTime = slideEndTime.clamp(0.0, 1.0);

      _particleAnimations.add(
        Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(CurvedAnimation(
          parent: _particleController,
          curve: Interval(
            safeStartTime,
            safeEndTime,
            curve: Curves.easeOut,
          ),
        )),
      );

      _particleSlideAnimations.add(
        Tween<Offset>(
          begin: const Offset(0, 0),
          end: Offset(
            (i % 2 == 0 ? 1 : -1) * 2.0,
            (i % 3 == 0 ? 1 : -1) * 2.0,
          ),
        ).animate(CurvedAnimation(
          parent: _particleController,
          curve: Interval(
            safeStartTime,
            safeSlideEndTime,
            curve: Curves.easeOut,
          ),
        )),
      );
    }
  }

  void _startAnimations() async {
    try {
      // Start main animation
      await _mainController.forward();

      // Start particle animation
      _particleController.forward();

      // Start text animation
      await _textController.forward();

      // Start pulse animation
      _pulseController.repeat(reverse: true);
    } catch (e) {
      //
    }

    // Wait then navigate
    await Future.delayed(const Duration(milliseconds: 1000));

    if (mounted) {
      AppGoRouter.instance.goToIntroduction();
    }
  }

  @override
  void dispose() {
    _mainController.dispose();
    _particleController.dispose();
    _textController.dispose();
    _pulseController.dispose();
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
          child: Stack(
            children: [
              // Animated background particles
              ...List.generate(5, (index) => _buildParticle(index)),

              // Main content
              SafeArea(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Logo Section with particles
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          // Pulse ring
                          AnimatedBuilder(
                            animation: _pulseAnimation,
                            builder: (context, child) {
                              return Transform.scale(
                                scale: _pulseAnimation.value,
                                child: Container(
                                  width: 200,
                                  height: 200,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: RadialGradient(
                                      colors: [
                                        context.colors.primary.withOpacity(0.1),
                                        Colors.transparent,
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),

                          // Main logo
                          AnimatedBuilder(
                            animation: _mainController,
                            builder: (context, child) {
                              return Transform.scale(
                                scale: _logoScaleAnimation.value,
                                child: Transform.rotate(
                                  angle: _logoRotationAnimation.value,
                                  child: Opacity(
                                    opacity: _logoOpacityAnimation.value,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          AppSizes.radiusSmall),
                                      child: Image.asset(
                                        'assets/images/logo.png',
                                        width: 140,
                                        height: 140,
                                      ),
                                    ), 
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),

                      const SizedBox(height: AppSizes.paddingXXLarge),

                      // App Name Section
                      AnimatedBuilder(
                        animation: _textController,
                        builder: (context, child) {
                          return Transform.translate(
                            offset: Offset(0, _textSlideAnimation.value),
                            child: Opacity(
                              opacity: _textOpacityAnimation.value,
                              child: Column(
                                children: [
                                  Text(
                                    appName,
                                    style: context.styles.displayLarge.copyWith(
                                      color: context.colors.text,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 2.0,
                                    ),
                                  ),
                                  const SizedBox(
                                      height: AppSizes.paddingMedium),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: AppSizes.paddingLarge,
                                      vertical: AppSizes.paddingSmall,
                                    ),
                                    decoration: BoxDecoration(
                                      gradient: context.colors.accentGradient,
                                      borderRadius: BorderRadius.circular(
                                          AppSizes.radiusLarge),
                                      boxShadow: [
                                        BoxShadow(
                                          color: context.colors.accent
                                              .withOpacity(0.3),
                                          blurRadius: 10,
                                          offset: const Offset(0, 5),
                                        ),
                                      ],
                                    ),
                                    child: Text(
                                      'Create • Scan • Connect',
                                      style:
                                          context.styles.titleMedium.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 1.5,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: AppSizes.paddingXXLarge),

                      // Loading indicator with custom design
                      AnimatedBuilder(
                        animation: _textOpacityAnimation,
                        builder: (context, child) {
                          return Opacity(
                            opacity: _textOpacityAnimation.value,
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 60,
                                  height: 60,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 4,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      context.colors.primary,
                                    ),
                                    backgroundColor:
                                        context.colors.primary.withOpacity(0.2),
                                  ),
                                ),
                                const SizedBox(height: AppSizes.paddingMedium),
                                Text(
                                  'Đang khởi tạo...',
                                  style: context.styles.bodyMedium.copyWith(
                                    color: context.colors.textSecondary,
                                    letterSpacing: 1.0,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildParticle(int index) {
    return AnimatedBuilder(
      animation: _particleController,
      builder: (context, child) {
        return Positioned(
          left: MediaQuery.of(context).size.width * (0.1 + (index * 0.2)),
          top: MediaQuery.of(context).size.height * (0.2 + (index * 0.15)),
          child: Transform.translate(
            offset: _particleSlideAnimations[index].value * 50,
            child: Opacity(
              opacity: _particleAnimations[index].value * 0.6,
              child: Container(
                width: 8 + (index * 2),
                height: 8 + (index * 2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      context.colors.primary.withOpacity(0.8),
                      context.colors.accent.withOpacity(0.6),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
