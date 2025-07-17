import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:internal_core/internal_core.dart';

import '../../constants/constants.dart';
import '../../utils/app_prefs.dart';
import '../widgets/widgets.dart' hide IconButton;

class PremiumScreen extends StatefulWidget {
  const PremiumScreen({super.key});

  @override
  State<PremiumScreen> createState() => _PremiumScreenState();
}

class _PremiumScreenState extends State<PremiumScreen>
    with TickerProviderStateMixin {
  late AnimationController _mainController;
  late AnimationController _pulseController;
  late AnimationController _floatingController;
  late AnimationController _staggerController;

  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<double> _floatingAnimation;
  late Animation<double> _staggerAnimation;

  final List<Animation<double>> _featureAnimations = [];
  final List<Animation<double>> _planAnimations = [];

  int _selectedPlan = 1; // 0: Monthly, 1: Yearly, 2: Lifetime

  // Premium plans data
  final List<Map<String, dynamic>> _premiumPlans = [
    {
      'title': 'Hàng tháng',
      'price': '\$1',
      'period': '/tháng',
      'originalPrice': null,
      'savings': null,
      'popular': false,
      'icon': Icons.calendar_month,
      'description': 'Thanh toán hàng tháng',
    },
    {
      'title': 'Hàng năm',
      'price': '\$10',
      'period': '/năm',
      'originalPrice': '\$12',
      'savings': 'Tiết kiệm 20%',
      'popular': true,
      'icon': Icons.calendar_today,
      'description': 'Thanh toán hàng năm',
    },
    {
      'title': 'Trọn đời',
      'price': '\$55',
      'period': '/một lần',
      'originalPrice': '\$120',
      'savings': 'Siêu tiết kiệm',
      'popular': false,
      'icon': Icons.all_inclusive,
      'description': 'Thanh toán một lần',
    },
  ];

  // Premium features
  final List<Map<String, dynamic>> _premiumFeatures = [
    {
      'title': 'QR Code không giới hạn',
      'description': 'Tạo và quản lý vô số QR code',
      'icon': Icons.qr_code,
    },
    {
      'title': 'QR Code động',
      'description': 'Thay đổi nội dung QR code mà không cần tạo lại',
      'icon': Icons.dynamic_feed,
    },
    {
      'title': 'Thống kê chi tiết',
      'description': 'Theo dõi số lần quét và hiệu suất QR code',
      'icon': Icons.analytics,
    },
    {
      'title': 'Tùy chỉnh nâng cao',
      'description': 'Thay đổi màu sắc, logo và thiết kế QR code',
      'icon': Icons.palette,
    },
    {
      'title': 'Xuất chất lượng cao',
      'description': 'Tải QR code với độ phân giải cao',
      'icon': Icons.high_quality,
    },
    {
      'title': 'Không quảng cáo',
      'description': 'Trải nghiệm sử dụng mượt mà không bị gián đoạn',
      'icon': Icons.block,
    },
    {
      'title': 'Sao lưu đám mây',
      'description': 'Đồng bộ QR code trên tất cả thiết bị',
      'icon': Icons.cloud_sync,
    },
    {
      'title': 'Hỗ trợ ưu tiên',
      'description': 'Được hỗ trợ nhanh chóng từ đội ngũ chuyên nghiệp',
      'icon': Icons.support_agent,
    },
  ];

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startAnimations();
  }

  void _initializeAnimations() {
    _mainController = AnimationController(
      duration: const Duration(milliseconds: 1500),
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
    _staggerController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _mainController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _mainController,
      curve: const Interval(0.2, 0.8, curve: Curves.easeOutCubic),
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _mainController,
      curve: const Interval(0.4, 1.0, curve: Curves.elasticOut),
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

    _staggerAnimation = CurvedAnimation(
      parent: _staggerController,
      curve: Curves.easeOutCubic,
    );

    // Feature animations
    for (int i = 0; i < _premiumFeatures.length; i++) {
      _featureAnimations.add(
        Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(CurvedAnimation(
          parent: _staggerController,
          curve: Interval(
            0.1 + (i * 0.05),
            0.3 + (i * 0.05),
            curve: Curves.easeOutCubic,
          ),
        )),
      );
    }

    // Plan animations
    for (int i = 0; i < 3; i++) {
      _planAnimations.add(
        Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(CurvedAnimation(
          parent: _staggerController,
          curve: Interval(
            0.6 + (i * 0.1),
            0.8 + (i * 0.1),
            curve: Curves.easeOutCubic,
          ),
        )),
      );
    }
  }

  void _startAnimations() {
    _mainController.forward();
    _pulseController.repeat(reverse: true);
    _floatingController.repeat(reverse: true);
    Future.delayed(const Duration(milliseconds: 500), () {
      _staggerController.forward();
    });
  }

  @override
  void dispose() {
    _mainController.dispose();
    _pulseController.dispose();
    _floatingController.dispose();
    _staggerController.dispose();
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
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // Hero App Bar
              SliverAppBar(
                expandedHeight: 200,
                floating: false,
                pinned: true,
                automaticallyImplyLeading: false,
                backgroundColor: Colors.transparent,
                elevation: 0,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    decoration: BoxDecoration(
                      gradient: context.colors.premiumGradient,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                    child: Stack(
                      children: [
                        // Background particles
                        ...List.generate(20, (index) => _buildParticle(index)),

                        // Content
                        Center(
                          child: FadeTransition(
                            opacity: _fadeAnimation,
                            child: SlideTransition(
                              position: _slideAnimation,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).padding.top),
                                  // Premium Icon
                                  AnimatedBuilder(
                                    animation: _pulseAnimation,
                                    builder: (context, child) {
                                      return Transform.scale(
                                        scale: _pulseAnimation.value,
                                        child: Container(
                                          padding: const EdgeInsets.all(20),
                                          decoration: BoxDecoration(
                                            gradient: context
                                                .colors.premiumGradientRadial,
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            boxShadow: [
                                              BoxShadow(
                                                color: context
                                                    .colors.premiumGold
                                                    .withOpacity(0.4),
                                                blurRadius: 30,
                                                offset: const Offset(0, 15),
                                              ),
                                            ],
                                          ),
                                          child: const Icon(
                                            Icons.workspace_premium_rounded,
                                            color: Colors.white,
                                            size: 40,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  const SizedBox(height: 16),

                                  // Title
                                  Text(
                                    'Nâng cấp Premium',
                                    style:
                                        context.styles.headlineMedium.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      shadows: [
                                        Shadow(
                                          color: Colors.black.withOpacity(0.3),
                                          offset: const Offset(0, 2),
                                          blurRadius: 4,
                                        ),
                                      ],
                                    ),
                                  ),

                                  // Subtitle
                                  Text(
                                    'Mở khóa tất cả tính năng nâng cao',
                                    style: context.styles.bodyMedium.copyWith(
                                      color: Colors.white.withOpacity(0.9),
                                      shadows: [
                                        Shadow(
                                          color: Colors.black.withOpacity(0.2),
                                          offset: const Offset(0, 1),
                                          blurRadius: 2,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        Positioned(
                          left: 20,
                          top: MediaQuery.of(context).padding.top + 12,
                          child: IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 210, 138, 138)
                                    .withOpacity(0.2),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.3),
                                  width: 1,
                                ),
                              ),
                              child: const Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Content
              SliverPadding(
                padding: const EdgeInsets.all(20),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    // Features Section
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: SlideTransition(
                        position: _slideAnimation,
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 30),
                          padding: const EdgeInsets.all(25),
                          decoration: BoxDecoration(
                            gradient: context.colors.premiumGradient,
                            borderRadius: BorderRadius.circular(25),
                            boxShadow: [
                              BoxShadow(
                                color:
                                    context.colors.premiumGold.withOpacity(0.3),
                                blurRadius: 25,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.workspace_premium_rounded,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    'Tính năng Premium',
                                    style: context.styles.titleLarge.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      shadows: [
                                        Shadow(
                                          color: Colors.black.withOpacity(0.3),
                                          offset: const Offset(0, 2),
                                          blurRadius: 4,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 25),
                              ...List.generate(_premiumFeatures.length,
                                  (index) {
                                return FadeTransition(
                                  opacity: _featureAnimations[index],
                                  child: SlideTransition(
                                    position: Tween<Offset>(
                                      begin: const Offset(0, 0.2),
                                      end: Offset.zero,
                                    ).animate(_featureAnimations[index]),
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 20),
                                      child: Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors.white.withOpacity(0.2),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              border: Border.all(
                                                color: Colors.white
                                                    .withOpacity(0.3),
                                                width: 1,
                                              ),
                                            ),
                                            child: Icon(
                                              _premiumFeatures[index]['icon'],
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                          ),
                                          const SizedBox(width: 16),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  _premiumFeatures[index]
                                                      ['title'],
                                                  style: context
                                                      .styles.titleMedium
                                                      .copyWith(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    shadows: [
                                                      Shadow(
                                                        color: Colors.black
                                                            .withOpacity(0.3),
                                                        offset:
                                                            const Offset(0, 1),
                                                        blurRadius: 2,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(height: 4),
                                                Text(
                                                  _premiumFeatures[index]
                                                      ['description'],
                                                  style: context
                                                      .styles.bodyMedium
                                                      .copyWith(
                                                    color: Colors.white
                                                        .withOpacity(0.8),
                                                    shadows: [
                                                      Shadow(
                                                        color: Colors.black
                                                            .withOpacity(0.2),
                                                        offset:
                                                            const Offset(0, 1),
                                                        blurRadius: 1,
                                                      ),
                                                    ],
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
                              }),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Pricing Plans
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: SlideTransition(
                        position: _slideAnimation,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.payment,
                                  color: context.colors.premiumGold,
                                  size: 24,
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  'Chọn gói Premium',
                                  style: context.styles.titleLarge.copyWith(
                                    color: context.colors.text,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 25),
                            ...List.generate(3, (index) {
                              return FadeTransition(
                                opacity: _planAnimations[index],
                                child: SlideTransition(
                                  position: Tween<Offset>(
                                    begin: const Offset(0, 0.2),
                                    end: Offset.zero,
                                  ).animate(_planAnimations[index]),
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 16),
                                    child: _buildPricingPlan(index),
                                  ),
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Upgrade Button
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: SlideTransition(
                        position: _slideAnimation,
                        child: Container(
                          width: double.infinity,
                          height: 60,
                          decoration: BoxDecoration(
                            gradient: context.colors.premiumGradient,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color:
                                    context.colors.premiumGold.withOpacity(0.4),
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(20),
                              onTap: _upgradeToPremium,
                              child: Center(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.workspace_premium_rounded,
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                    const SizedBox(width: 12),
                                    Text(
                                      'Nâng cấp ngay',
                                      style:
                                          context.styles.titleMedium.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        shadows: [
                                          Shadow(
                                            color:
                                                Colors.black.withOpacity(0.3),
                                            offset: const Offset(0, 2),
                                            blurRadius: 4,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Terms
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: Text(
                        'Bằng việc nâng cấp, bạn đồng ý với Điều khoản sử dụng và Chính sách bảo mật của chúng tôi.',
                        style: context.styles.bodySmall.copyWith(
                          color: context.colors.textSecondary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    const SizedBox(height: 32),
                  ]),
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
      animation: _floatingAnimation,
      builder: (context, child) {
        return Positioned(
          left: (index * 37) % 400.0,
          top: (index * 73) % 200.0,
          child: Transform.translate(
            offset: Offset(0, _floatingAnimation.value * 10),
            child: Container(
              width: 4,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPricingPlan(int index) {
    final plan = _premiumPlans[index];
    final isSelected = _selectedPlan == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedPlan = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: isSelected ? context.colors.premiumGradient : null,
          color: isSelected ? null : context.colors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? context.colors.premiumGold
                : context.colors.divider,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: context.colors.premiumGold.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
        ),
        child: Row(
          children: [
            // Radio button
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? Colors.white : context.colors.premiumGold,
                  width: 2,
                ),
                color: isSelected ? Colors.white : Colors.transparent,
              ),
              child: isSelected
                  ? Icon(
                      Icons.check,
                      color: context.colors.premiumGold,
                      size: 16,
                    )
                  : null,
            ),
            const SizedBox(width: 16),

            // Plan icon
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.white.withOpacity(0.2)
                    : context.colors.premiumGold.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                plan['icon'],
                color: isSelected ? Colors.white : context.colors.premiumGold,
                size: 20,
              ),
            ),
            const SizedBox(width: 16),

            // Plan details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        plan['title'],
                        style: context.styles.titleMedium.copyWith(
                          color:
                              isSelected ? Colors.white : context.colors.text,
                          fontWeight: FontWeight.bold,
                          shadows: isSelected
                              ? [
                                  Shadow(
                                    color: Colors.black.withOpacity(0.3),
                                    offset: const Offset(0, 2),
                                    blurRadius: 4,
                                  ),
                                ]
                              : null,
                        ),
                      ),
                      if (plan['popular'] == true) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            'Phổ biến',
                            style: context.styles.labelSmall.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        plan['price'],
                        style: context.styles.headlineSmall.copyWith(
                          color:
                              isSelected ? Colors.white : context.colors.text,
                          fontWeight: FontWeight.bold,
                          shadows: isSelected
                              ? [
                                  Shadow(
                                    color: Colors.black.withOpacity(0.3),
                                    offset: const Offset(0, 2),
                                    blurRadius: 4,
                                  ),
                                ]
                              : null,
                        ),
                      ),
                      Text(
                        plan['period'],
                        style: context.styles.bodyMedium.copyWith(
                          color: isSelected
                              ? Colors.white.withOpacity(0.8)
                              : context.colors.textSecondary,
                        ),
                      ),
                      if (plan['originalPrice'] != null) ...[
                        const SizedBox(width: 8),
                        Text(
                          plan['originalPrice'],
                          style: context.styles.bodyMedium.copyWith(
                            color: context.colors.textSecondary,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    plan['description'],
                    style: context.styles.bodySmall.copyWith(
                      color: isSelected
                          ? Colors.white.withOpacity(0.8)
                          : context.colors.textSecondary,
                    ),
                  ),
                  if (plan['savings'] != null) ...[
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color:
                            (isSelected ? Colors.white : context.colors.success)
                                .withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: (isSelected
                                  ? Colors.white
                                  : context.colors.success)
                              .withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        plan['savings'],
                        style: context.styles.labelSmall.copyWith(
                          color: (isSelected
                              ? Colors.white
                              : context.colors.success),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _upgradeToPremium() {
    // TODO: Implement premium upgrade
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Đang xử lý nâng cấp Premium...'),
        backgroundColor: context.colors.premiumGold,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
