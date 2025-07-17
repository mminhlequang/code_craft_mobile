import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:internal_core/internal_core.dart';

import '../../constants/constants.dart';
import '../../utils/app_go_router.dart';
import '../../utils/app_prefs.dart';
import '../widgets/widgets.dart';

class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({super.key});

  @override
  State<IntroductionScreen> createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen>
    with TickerProviderStateMixin {
  late ScrollController _scrollController;
  late AnimationController _mainController;
  late AnimationController _pulseController;
  late AnimationController _floatingController;

  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<double> _floatingAnimation;

  final List<Animation<double>> _cardAnimations = [];

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _initializeAnimations();
    _startAnimations();
  }

  void _initializeAnimations() {
    _mainController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _floatingController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _mainController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
    ));

    _slideAnimation = Tween<double>(
      begin: 100.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _mainController,
      curve: const Interval(0.2, 0.8, curve: Curves.easeOutCubic),
    ));

    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    _floatingAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _floatingController,
      curve: Curves.easeInOut,
    ));

    // Initialize card animations with staggered timing
    for (int i = 0; i < 8; i++) {
      _cardAnimations.add(
        Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(CurvedAnimation(
          parent: _mainController,
          curve: Interval(
            (i * 0.08) + 0.3,
            (i * 0.08) + 0.9,
            curve: Curves.easeOutBack,
          ),
        )),
      );
    }
  }

  void _startAnimations() async {
    try {
      await _mainController.forward();
      _pulseController.repeat(reverse: true);
      _floatingController.repeat(reverse: true);
    } catch (e) {
      // Handle animation errors gracefully
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _mainController.dispose();
    _pulseController.dispose();
    _floatingController.dispose();
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
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                context.colors.primary.withOpacity(0.1),
                context.colors.background,
                context.colors.accent.withOpacity(0.05),
              ],
            ),
          ),
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              // Hero Header
              SliverToBoxAdapter(
                child: SizedBox(
                  height: MediaQuery.of(context).padding.top,
                ),
              ),
              SliverToBoxAdapter(
                child: AnimatedBuilder(
                  animation: _mainController,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(0, _slideAnimation.value),
                      child: Opacity(
                        opacity: _fadeAnimation.value,
                        child: Container(
                          height: 280,
                          margin: const EdgeInsets.all(AppSizes.paddingLarge),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                context.colors.primary,
                                context.colors.primary.withOpacity(0.8),
                                context.colors.accent,
                              ],
                            ),
                            borderRadius:
                                BorderRadius.circular(AppSizes.radiusXLarge),
                            boxShadow: [
                              BoxShadow(
                                color: context.colors.primary.withOpacity(0.3),
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Stack(
                            children: [
                              // Background decorative elements
                              Positioned(
                                top: 20,
                                left: 20,
                                child: AnimatedBuilder(
                                  animation: _pulseAnimation,
                                  builder: (context, child) {
                                    return Transform.scale(
                                      scale: _pulseAnimation.value,
                                      child: Container(
                                        width: 60,
                                        height: 60,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white.withOpacity(0.1),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Positioned(
                                top: 60,
                                right: 30,
                                child: AnimatedBuilder(
                                  animation: _floatingAnimation,
                                  builder: (context, child) {
                                    return Transform.translate(
                                      offset: Offset(
                                          0, 10 * _floatingAnimation.value),
                                      child: Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white.withOpacity(0.1),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              // Main content
                              Padding(
                                padding: const EdgeInsets.all(
                                    AppSizes.paddingXLarge),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // App icon
                                    Container(
                                      width: 80,
                                      height: 80,
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(
                                            AppSizes.radiusLarge),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.1),
                                            blurRadius: 10,
                                            offset: const Offset(0, 5),
                                          ),
                                        ],
                                      ),
                                      child: const Icon(
                                        Icons.qr_code_scanner,
                                        size: 40,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(
                                        height: AppSizes.paddingLarge),
                                    // App name
                                    Text(
                                      appName,
                                      style:
                                          context.styles.headlineLarge.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 2.0,
                                      ),
                                    ),
                                    const SizedBox(
                                        height: AppSizes.paddingSmall),
                                    // Tagline
                                    Text(
                                      'Tạo QR Code chuyên nghiệp',
                                      style:
                                          context.styles.titleMedium.copyWith(
                                        color: Colors.white.withOpacity(0.9),
                                        fontWeight: FontWeight.w500,
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
                  },
                ),
              ),

              // Content sections
              SliverPadding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.paddingLarge),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    const SizedBox(height: AppSizes.paddingMedium),

                    // Welcome card
                    _buildAnimatedCard(0, _buildWelcomeCard()),

                    const SizedBox(height: AppSizes.paddingLarge),

                    // Features grid
                    _buildAnimatedCard(1, _buildFeaturesGrid()),

                    const SizedBox(height: AppSizes.paddingLarge),

                    // How to use
                    _buildAnimatedCard(2, _buildHowToUseCard()),

                    const SizedBox(height: AppSizes.paddingLarge),

                    // Benefits
                    _buildAnimatedCard(3, _buildBenefitsCard()),

                    const SizedBox(height: AppSizes.paddingLarge),

                    // Stats
                    _buildAnimatedCard(4, _buildStatsCard()),

                    const SizedBox(height: AppSizes.paddingLarge),

                    // Get started button
                    _buildAnimatedCard(5, _buildGetStartedButton()),

                    const SizedBox(height: AppSizes.paddingXLarge),
                  ]),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: MediaQuery.of(context).padding.bottom,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedCard(int index, Widget child) {
    return AnimatedBuilder(
      animation: _cardAnimations[index],
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, 50 * (1 - _cardAnimations[index].value)),
          child: Opacity(
            opacity: _cardAnimations[index].value>= 1 ? 1 : _cardAnimations[index].value,
            child: child,
          ),
        );
      },
      child: child,
    );
  }

  Widget _buildWelcomeCard() {
    return Container(
      padding: const EdgeInsets.all(AppSizes.paddingXLarge),
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(AppSizes.radiusXLarge),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppSizes.paddingMedium),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [context.colors.primary, context.colors.accent],
                  ),
                  borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
                ),
                child: const Icon(
                  Icons.auto_awesome,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: AppSizes.paddingMedium),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Chào mừng bạn!',
                      style: context.styles.headlineSmall.copyWith(
                        color: context.colors.text,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Khám phá thế giới QR Code',
                      style: context.styles.bodyMedium.copyWith(
                        color: context.colors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.paddingLarge),
          Text(
            'CodeCraft là nền tảng tạo QR Code hàng đầu với giao diện hiện đại, tính năng mạnh mẽ và trải nghiệm người dùng tuyệt vời. Tạo QR Code chuyên nghiệp chỉ trong vài giây!',
            style: context.styles.bodyMedium.copyWith(
              color: context.colors.textSecondary,
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturesGrid() {
    final features = [
      {
        'icon': Icons.qr_code,
        'title': 'Tạo QR Code',
        'desc': 'Nhiều loại QR Code'
      },
      {
        'icon': Icons.palette,
        'title': 'Tùy chỉnh',
        'desc': 'Màu sắc & thiết kế'
      },
      {
        'icon': Icons.analytics,
        'title': 'Phân tích',
        'desc': 'Thống kê chi tiết'
      },
      {'icon': Icons.share, 'title': 'Chia sẻ', 'desc': 'Dễ dàng chia sẻ'},
      {
        'icon': Icons.security,
        'title': 'Bảo mật',
        'desc': 'An toàn & riêng tư'
      },
      {
        'icon': Icons.speed,
        'title': 'Nhanh chóng',
        'desc': 'Tạo trong giây lát'
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tính năng nổi bật',
          style: context.styles.headlineSmall.copyWith(
            color: context.colors.text,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppSizes.paddingLarge),
        // Sử dụng Wrap thay cho GridView để hiển thị các tính năng, đảm bảo responsive và tối ưu UX/UI
        Wrap(
          spacing: AppSizes.paddingMedium,
          runSpacing: AppSizes.paddingMedium,
          children: features.map((feature) {
            return SizedBox(
              width: (MediaQuery.of(context).size.width -
                      (AppSizes.paddingLarge *
                          2) - // Padding ngoài của SliverPadding
                      AppSizes.paddingMedium) /
                  2, // Chia 2 cột, trừ spacing
              child: Container(
                padding: const EdgeInsets.all(AppSizes.paddingMedium),
                decoration: BoxDecoration(
                  color: context.colors.surface,
                  borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(AppSizes.paddingMedium),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            context.colors.primary.withOpacity(0.1),
                            context.colors.accent.withOpacity(0.1),
                          ],
                        ),
                        borderRadius:
                            BorderRadius.circular(AppSizes.radiusMedium),
                      ),
                      child: Icon(
                        feature['icon'] as IconData,
                        color: context.colors.primary,
                        size: 28,
                      ),
                    ),
                    const SizedBox(height: AppSizes.paddingMedium),
                    Text(
                      feature['title'] as String,
                      style: context.styles.titleSmall.copyWith(
                        color: context.colors.text,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    // const SizedBox(height: AppSizes.paddingTiny),
                    Text(
                      feature['desc'] as String,
                      style: context.styles.bodySmall.copyWith(
                        color: context.colors.textSecondary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildHowToUseCard() {
    final steps = [
      {
        'step': '1',
        'title': 'Chọn loại QR Code',
        'desc': 'URL, văn bản, liên hệ...'
      },
      {'step': '2', 'title': 'Nhập thông tin', 'desc': 'Nội dung cần mã hóa'},
      {'step': '3', 'title': 'Tùy chỉnh', 'desc': 'Màu sắc và thiết kế'},
      {'step': '4', 'title': 'Tạo & lưu', 'desc': 'Hoàn thành trong giây lát'},
    ];

    return Container(
      padding: const EdgeInsets.all(AppSizes.paddingXLarge),
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(AppSizes.radiusXLarge),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppSizes.paddingMedium),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [context.colors.accent, context.colors.primary],
                  ),
                  borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
                ),
                child: const Icon(
                  Icons.play_circle_outline,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: AppSizes.paddingMedium),
              Text(
                'Cách sử dụng',
                style: context.styles.headlineSmall.copyWith(
                  color: context.colors.text,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.paddingLarge),
          ...steps.map((step) => Padding(
                padding: const EdgeInsets.only(bottom: AppSizes.paddingLarge),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            context.colors.primary,
                            context.colors.accent
                          ],
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: context.colors.primary.withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          step['step'] as String,
                          style: context.styles.titleSmall.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSizes.paddingMedium),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            step['title'] as String,
                            style: context.styles.titleMedium.copyWith(
                              color: context.colors.text,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            step['desc'] as String,
                            style: context.styles.bodyMedium.copyWith(
                              color: context.colors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildBenefitsCard() {
    final benefits = [
      {
        'icon': Icons.bolt,
        'title': 'Nhanh chóng',
        'desc': 'Tạo QR Code trong 3 giây'
      },
      {
        'icon': Icons.design_services,
        'title': 'Chuyên nghiệp',
        'desc': 'Thiết kế đẹp mắt'
      },
      {
        'icon': Icons.mobile_friendly,
        'title': 'Dễ sử dụng',
        'desc': 'Giao diện thân thiện'
      },
      {'icon': Icons.cloud_done, 'title': 'Đồng bộ', 'desc': 'Lưu trữ đám mây'},
    ];

    return Container(
      padding: const EdgeInsets.all(AppSizes.paddingXLarge),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            context.colors.primary.withOpacity(0.1),
            context.colors.accent.withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(AppSizes.radiusXLarge),
        border: Border.all(
          color: context.colors.primary.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tại sao chọn CodeCraft?',
            style: context.styles.headlineSmall.copyWith(
              color: context.colors.text,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppSizes.paddingLarge),
          ...benefits.map((benefit) => Padding(
                padding: const EdgeInsets.only(bottom: AppSizes.paddingMedium),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(AppSizes.paddingSmall),
                      decoration: BoxDecoration(
                        color: context.colors.primary.withOpacity(0.1),
                        borderRadius:
                            BorderRadius.circular(AppSizes.radiusMedium),
                      ),
                      child: Icon(
                        benefit['icon'] as IconData,
                        color: context.colors.primary,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: AppSizes.paddingMedium),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            benefit['title'] as String,
                            style: context.styles.titleSmall.copyWith(
                              color: context.colors.text,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            benefit['desc'] as String,
                            style: context.styles.bodySmall.copyWith(
                              color: context.colors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildStatsCard() {
    return Container(
      padding: const EdgeInsets.all(AppSizes.paddingXLarge),
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(AppSizes.radiusXLarge),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'Thống kê ấn tượng',
            style: context.styles.headlineSmall.copyWith(
              color: context.colors.text,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppSizes.paddingLarge),
          Row(
            children: [
              Expanded(
                child: _buildStatItem('1M+', 'QR Code đã tạo', Icons.qr_code),
              ),
              Expanded(
                child: _buildStatItem('50K+', 'Người dùng', Icons.people),
              ),
              Expanded(
                child: _buildStatItem('99%', 'Độ chính xác', Icons.verified),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label, IconData icon) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(AppSizes.paddingMedium),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                context.colors.primary.withOpacity(0.1),
                context.colors.accent.withOpacity(0.1)
              ],
            ),
            borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
          ),
          child: Icon(
            icon,
            color: context.colors.primary,
            size: 24,
          ),
        ),
        const SizedBox(height: AppSizes.paddingSmall),
        Text(
          value,
          style: context.styles.headlineSmall.copyWith(
            color: context.colors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: context.styles.bodySmall.copyWith(
            color: context.colors.textSecondary,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildGetStartedButton() {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [context.colors.primary, context.colors.accent],
        ),
        borderRadius: BorderRadius.circular(AppSizes.radiusXLarge),
        boxShadow: [
          BoxShadow(
            color: context.colors.primary.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppSizes.radiusXLarge),
          onTap: () {
            AppGoRouter.instance.goToHome();
          },
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.rocket_launch,
                    color: Colors.white,
                    size: 24,
                  ),
                  const SizedBox(width: AppSizes.paddingMedium),
                  Text(
                    'Bắt đầu ngay',
                    style: context.styles.titleLarge.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
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
