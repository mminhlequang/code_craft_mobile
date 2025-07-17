import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:sign_in_with_apple/sign_in_with_apple.dart';
// import 'package:firebase_auth/firebase_auth.dart';

import '../../constants/constants.dart';
import '../../utils/app_go_router.dart';
import '../../utils/app_prefs.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  late AnimationController _bubbleController;
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late AnimationController _pulseController;

  late Animation<double> _bubbleAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;
  late Animation<double> _pulseAnimation;

  final List<Animation<double>> _bubbleAnimations = [];
  final List<Animation<Offset>> _bubbleSlideAnimations = [];

  bool _isLoading = false;
  String _loadingText = '';

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startAnimations();
  }

  void _initializeAnimations() {
    // Bubble animation controller
    _bubbleController = AnimationController(
      duration: const Duration(milliseconds: 4000),
      vsync: this,
    );

    // Fade animation controller
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    // Slide animation controller
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    // Pulse animation controller
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    // Bubble animations
    _bubbleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _bubbleController,
      curve: Curves.easeInOut,
    ));

    // Fade animation
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    ));

    // Slide animation
    _slideAnimation = Tween<double>(
      begin: 100.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));

    // Pulse animation
    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    // Initialize bubble animations
    for (int i = 0; i < 8; i++) {
      final startTime = i * 0.1;
      final endTime = startTime + 0.4;
      final slideEndTime = startTime + 0.6;

      final safeStartTime = startTime.clamp(0.0, 1.0);
      final safeEndTime = endTime.clamp(0.0, 1.0);
      final safeSlideEndTime = slideEndTime.clamp(0.0, 1.0);

      _bubbleAnimations.add(
        Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(CurvedAnimation(
          parent: _bubbleController,
          curve: Interval(
            safeStartTime,
            safeEndTime,
            curve: Curves.easeOut,
          ),
        )),
      );

      _bubbleSlideAnimations.add(
        Tween<Offset>(
          begin: const Offset(0, 0),
          end: Offset(
            (i % 2 == 0 ? 1 : -1) * 1.5,
            (i % 3 == 0 ? 1 : -1) * 1.5,
          ),
        ).animate(CurvedAnimation(
          parent: _bubbleController,
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
      // Start bubble animation
      _bubbleController.repeat();

      // Start fade animation
      await _fadeController.forward();

      // Start slide animation
      await _slideController.forward();

      // Start pulse animation
      _pulseController.repeat(reverse: true);
    } catch (e) {
      //
    }
  }

  @override
  void dispose() {
    _bubbleController.dispose();
    _fadeController.dispose();
    _slideController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  // TODO: Implement Google Sign In
  Future<void> _signInWithGoogle() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
      _loadingText = 'Đang đăng nhập với Google...';
    });

    // Simulate loading
    await Future.delayed(const Duration(seconds: 2));

    // Simulate success
    await AppPrefs.instance.setUserLoggedIn(true);
    await AppPrefs.instance.setUserEmail('user@gmail.com');
    await AppPrefs.instance.setUserName('Google User');

    if (mounted) {
      setState(() {
        _isLoading = false;
        _loadingText = '';
      });
      AppGoRouter.instance.goToHome();
    }
  }

  // TODO: Implement Facebook Sign In
  Future<void> _signInWithFacebook() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
      _loadingText = 'Đang đăng nhập với Facebook...';
    });

    // Simulate loading
    await Future.delayed(const Duration(seconds: 2));

    // Simulate success
    await AppPrefs.instance.setUserLoggedIn(true);
    await AppPrefs.instance.setUserEmail('user@facebook.com');
    await AppPrefs.instance.setUserName('Facebook User');

    if (mounted) {
      setState(() {
        _isLoading = false;
        _loadingText = '';
      });
      AppGoRouter.instance.goToHome();
    }
  }

  // TODO: Implement Apple Sign In
  Future<void> _signInWithApple() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
      _loadingText = 'Đang đăng nhập với Apple...';
    });

    // Simulate loading
    await Future.delayed(const Duration(seconds: 2));

    // Simulate success
    await AppPrefs.instance.setUserLoggedIn(true);
    await AppPrefs.instance.setUserEmail('user@icloud.com');
    await AppPrefs.instance.setUserName('Apple User');

    if (mounted) {
      setState(() {
        _isLoading = false;
        _loadingText = '';
      });
      AppGoRouter.instance.goToHome();
    }
  }

  Future<void> _continueAsGuest() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
      _loadingText = 'Đang tiếp tục với vai trò khách...';
    });

    try {
      // Lưu thông tin guest
      await AppPrefs.instance.setUserLoggedIn(false);
      await AppPrefs.instance.setUserEmail('');
      await AppPrefs.instance.setUserName('Khách');

      if (mounted) {
        AppGoRouter.instance.goToHome();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text('Không thể tiếp tục với vai trò khách: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _loadingText = '';
        });
      }
    }
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
              // Animated background bubbles
              ...List.generate(8, (index) => _buildBubble(index)),

              // Main content
              SafeArea(
                child: Column(
                  children: [
                    // Header section
                    Expanded(
                      flex: 2,
                      child: AnimatedBuilder(
                        animation: _fadeController,
                        builder: (context, child) {
                          return Opacity(
                            opacity: _fadeAnimation.value,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Logo with pulse effect
                                  AnimatedBuilder(
                                    animation: _pulseAnimation,
                                    builder: (context, child) {
                                      return Transform.scale(
                                        scale: _pulseAnimation.value,
                                        child: Container(
                                          width: 120,
                                          height: 120,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            gradient: RadialGradient(
                                              colors: [
                                                context.colors.primary
                                                    .withOpacity(0.2),
                                                Colors.transparent,
                                              ],
                                            ),
                                          ),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                                AppSizes.radiusSmall),
                                            child: Image.asset(
                                              'assets/images/logo.png',
                                              width: 100,
                                              height: 100,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),

                                  const SizedBox(height: AppSizes.paddingLarge),

                                  // App name
                                  Text(
                                    appName,
                                    style:
                                        context.styles.displayMedium.copyWith(
                                      color: context.colors.text,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 2.0,
                                    ),
                                  ),

                                  const SizedBox(
                                      height: AppSizes.paddingMedium),

                                  // Subtitle
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
                                      'Đăng nhập để tiếp tục',
                                      style:
                                          context.styles.titleMedium.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 1.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    // Login buttons section
                    Expanded(
                      flex: 3,
                      child: AnimatedBuilder(
                        animation: _slideController,
                        builder: (context, child) {
                          return Transform.translate(
                            offset: Offset(0, _slideAnimation.value),
                            child: Opacity(
                              opacity: (100 - _slideAnimation.value) / 100,
                              child: Padding(
                                padding:
                                    const EdgeInsets.all(AppSizes.paddingLarge),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // Social login buttons
                                    _buildSocialLoginButton(
                                      icon: Icons.g_mobiledata,
                                      label: 'Tiếp tục với Google',
                                      color: const Color(0xFF4285F4),
                                      onPressed: _signInWithGoogle,
                                    ),

                                    const SizedBox(
                                        height: AppSizes.paddingMedium),

                                    _buildSocialLoginButton(
                                      icon: Icons.facebook,
                                      label: 'Tiếp tục với Facebook',
                                      color: const Color(0xFF1877F2),
                                      onPressed: _signInWithFacebook,
                                    ),

                                    const SizedBox(
                                        height: AppSizes.paddingMedium),

                                    _buildSocialLoginButton(
                                      icon: Icons.apple,
                                      label: 'Tiếp tục với Apple',
                                      color: Colors.black,
                                      onPressed: _signInWithApple,
                                    ),

                                    const SizedBox(
                                        height: AppSizes.paddingLarge),

                                    // Divider
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            height: 1,
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: [
                                                  Colors.transparent,
                                                  context.colors.textSecondary
                                                      .withOpacity(0.3),
                                                  Colors.transparent,
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal:
                                                  AppSizes.paddingMedium),
                                          child: Text(
                                            'hoặc',
                                            style: context.styles.bodyMedium
                                                .copyWith(
                                              color:
                                                  context.colors.textSecondary,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            height: 1,
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: [
                                                  Colors.transparent,
                                                  context.colors.textSecondary
                                                      .withOpacity(0.3),
                                                  Colors.transparent,
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                    const SizedBox(
                                        height: AppSizes.paddingLarge),

                                    // Guest button
                                    _buildGuestButton(),

                                    // Loading indicator
                                    if (_isLoading) ...[
                                      const SizedBox(
                                          height: AppSizes.paddingLarge),
                                      Column(
                                        children: [
                                          SizedBox(
                                            width: 40,
                                            height: 40,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 3,
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                context.colors.primary,
                                              ),
                                              backgroundColor: context
                                                  .colors.primary
                                                  .withOpacity(0.2),
                                            ),
                                          ),
                                          const SizedBox(
                                              height: AppSizes.paddingMedium),
                                          Text(
                                            _loadingText,
                                            style: context.styles.bodyMedium
                                                .copyWith(
                                              color:
                                                  context.colors.textSecondary,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSocialLoginButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color.withOpacity(0.1),
            color.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: AppSizes.paddingLarge),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: color,
                  size: 24,
                ),
                const SizedBox(width: AppSizes.paddingMedium),
                Text(
                  label,
                  style: context.styles.titleMedium.copyWith(
                    color: color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.arrow_forward_ios,
                  color: color.withOpacity(0.7),
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGuestButton() {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        gradient: context.colors.primaryGradient,
        borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
        boxShadow: [
          BoxShadow(
            color: context.colors.primary.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _continueAsGuest,
          borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: AppSizes.paddingLarge),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.person_outline,
                  color: Colors.white,
                  size: 24,
                ),
                const SizedBox(width: AppSizes.paddingMedium),
                Text(
                  'Tiếp tục với vai trò khách',
                  style: context.styles.titleMedium.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBubble(int index) {
    return AnimatedBuilder(
      animation: _bubbleController,
      builder: (context, child) {
        return Positioned(
          left: MediaQuery.of(context).size.width * (0.05 + (index * 0.12)),
          top: MediaQuery.of(context).size.height * (0.1 + (index * 0.1)),
          child: Transform.translate(
            offset: _bubbleSlideAnimations[index].value * 30,
            child: Opacity(
              opacity: _bubbleAnimations[index].value * 0.4,
              child: Container(
                width: 12 + (index * 3),
                height: 12 + (index * 3),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      context.colors.primary.withOpacity(0.6),
                      context.colors.accent.withOpacity(0.4),
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
