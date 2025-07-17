import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:internal_core/internal_core.dart';

import '../../constants/constants.dart';
import '../../utils/app_prefs.dart';
import '../qr_create/qr_create_screen.dart';
import '../qr_scan/qr_scan_screen.dart';
import '../qr_manage/qr_manage_screen.dart';
import '../profile/profile_screen.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_card.dart';
import '../widgets/custom_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  int _currentIndex = 0;
  late PageController _pageController;
  late AnimationController _bottomNavController;
  late Animation<double> _bottomNavAnimation;

  final List<Widget> _pages = [
    const HomeTab(),
    const QrCreateScreen(),
    const QrScanScreen(),
    const QrManageScreen(),
    const ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
    _bottomNavController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _bottomNavAnimation = CurvedAnimation(
      parent: _bottomNavController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _bottomNavController.dispose();
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
        backgroundColor: context.colors.background,
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          children: _pages,
        ),
        bottomNavigationBar: AnimatedBuilder(
          animation: _bottomNavAnimation,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(0, 0),
              child: Container(
                decoration: BoxDecoration(
                  color: context.colors.surface,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSizes.paddingMedium,
                      vertical: AppSizes.paddingSmall,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildNavItem(0, Icons.home, 'Trang chủ'),
                        _buildNavItem(1, Icons.qr_code, 'Tạo QR'),
                        _buildNavItem(2, Icons.qr_code_scanner, 'Quét'),
                        _buildNavItem(3, Icons.folder, 'Quản lý'),
                        _buildNavItem(4, Icons.person, 'Cá nhân'),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isSelected = _currentIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
        _pageController.animateToPage(
          index,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.paddingMedium,
          vertical: AppSizes.paddingSmall,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? context.colors.primary.withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              child: Icon(
                icon,
                color: isSelected
                    ? context.colors.primary
                    : context.colors.textSecondary,
                size: AppSizes.iconMedium,
              ),
            ),
            const SizedBox(height: AppSizes.paddingTiny),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: context.styles.labelSmall.copyWith(
                color: isSelected
                    ? context.colors.primary
                    : context.colors.textSecondary,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
              child: Text(label),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> with TickerProviderStateMixin {
  late AnimationController _welcomeController;
  late Animation<double> _welcomeAnimation;
  late AnimationController _contentController;
  late Animation<double> _contentAnimation;

  @override
  void initState() {
    super.initState();
    _welcomeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _welcomeAnimation = CurvedAnimation(
      parent: _welcomeController,
      curve: Curves.easeOutBack,
    );

    _contentController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _contentAnimation = CurvedAnimation(
      parent: _contentController,
      curve: Curves.easeOut,
    );

    _welcomeController.forward();
    Future.delayed(const Duration(milliseconds: 200), () {
      _contentController.forward();
    });
  }

  @override
  void dispose() {
    _welcomeController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // App Bar
        CustomSliverAppBar(
          title: 'CodeCraft',
          useGradient: true,
          actions: [
            AnimatedContainer(
              duration: AppStyles.instance.animationFast,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
                  onTap: () {
                    // TODO: Show notifications
                  },
                  child: Container(
                    padding: const EdgeInsets.all(AppSizes.paddingSmall),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius:
                          BorderRadius.circular(AppSizes.radiusMedium),
                    ),
                    child: Icon(
                      Icons.notifications_outlined,
                      color: Colors.white,
                      size: AppSizes.iconMedium,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),

        // Content
        SliverPadding(
          padding: const EdgeInsets.all(AppSizes.paddingLarge),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              // Welcome Section
              FadeTransition(
                opacity: _welcomeAnimation,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 0.3),
                    end: Offset.zero,
                  ).animate(_welcomeAnimation),
                  child: GradientCard(
                    gradient: context.colors.primaryGradient,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Chào mừng bạn! 👋',
                          style: context.styles.headlineSmall.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: AppSizes.paddingSmall),
                        Text(
                          'Tạo và quét QR Code một cách dễ dàng',
                          style: context.styles.bodyMedium.copyWith(
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: AppSizes.paddingLarge),

              // Quick Actions
              FadeTransition(
                opacity: _contentAnimation,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 0.2),
                    end: Offset.zero,
                  ).animate(_contentAnimation),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Thao tác nhanh',
                        style: context.styles.titleLarge.copyWith(
                          color: context.colors.text,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: AppSizes.paddingMedium),
                      Row(
                        children: [
                          Expanded(
                            child: AnimatedCard(
                              onTap: () {
                                // Navigate to QR Create
                              },
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(
                                        AppSizes.paddingMedium),
                                    decoration: BoxDecoration(
                                      color: context.colors.primary
                                          .withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(
                                          AppSizes.radiusMedium),
                                    ),
                                    child: Icon(
                                      Icons.qr_code,
                                      color: context.colors.primary,
                                      size: AppSizes.iconLarge,
                                    ),
                                  ),
                                  const SizedBox(
                                      height: AppSizes.paddingMedium),
                                  Text(
                                    'Tạo QR',
                                    style: context.styles.titleMedium.copyWith(
                                      color: context.colors.text,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: AppSizes.paddingSmall),
                                  Text(
                                    'Tạo QR Code mới',
                                    style: context.styles.bodySmall.copyWith(
                                      color: context.colors.textSecondary,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: AppSizes.paddingMedium),
                          Expanded(
                            child: AnimatedCard(
                              onTap: () {
                                // Navigate to QR Scan
                              },
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(
                                        AppSizes.paddingMedium),
                                    decoration: BoxDecoration(
                                      color: context.colors.secondary
                                          .withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(
                                          AppSizes.radiusMedium),
                                    ),
                                    child: Icon(
                                      Icons.qr_code_scanner,
                                      color: context.colors.secondary,
                                      size: AppSizes.iconLarge,
                                    ),
                                  ),
                                  const SizedBox(
                                      height: AppSizes.paddingMedium),
                                  Text(
                                    'Quét QR',
                                    style: context.styles.titleMedium.copyWith(
                                      color: context.colors.text,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: AppSizes.paddingSmall),
                                  Text(
                                    'Quét QR Code',
                                    style: context.styles.bodySmall.copyWith(
                                      color: context.colors.textSecondary,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: AppSizes.paddingLarge),

              // Recent QR Codes
              FadeTransition(
                opacity: _contentAnimation,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 0.2),
                    end: Offset.zero,
                  ).animate(_contentAnimation),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'QR Code gần đây',
                        style: context.styles.titleLarge.copyWith(
                          color: context.colors.text,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: AppSizes.paddingMedium),

                      // Mock recent QR codes
                      _buildRecentQrItem(
                        context,
                        'Website chính',
                        'https://codecraft.com',
                        'URL',
                        Icons.link,
                        context.colors.primary,
                      ),
                      _buildRecentQrItem(
                        context,
                        'WiFi nhà',
                        'SSID: HomeWiFi',
                        'WiFi',
                        Icons.wifi,
                        context.colors.accent,
                      ),
                      _buildRecentQrItem(
                        context,
                        'Ghi chú',
                        'Đây là ghi chú quan trọng...',
                        'Text',
                        Icons.text_fields,
                        context.colors.success,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: AppSizes.paddingLarge),

              // Premium Banner
              FadeTransition(
                opacity: _contentAnimation,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 0.2),
                    end: Offset.zero,
                  ).animate(_contentAnimation),
                  child: GradientCard(
                    gradient: context.colors.accentGradient,
                    child: Column(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.white,
                          size: AppSizes.iconLarge,
                        ),
                        const SizedBox(height: AppSizes.paddingMedium),
                        Text(
                          'Nâng cấp Premium',
                          style: context.styles.headlineSmall.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: AppSizes.paddingSmall),
                        Text(
                          'Mở khóa tất cả tính năng nâng cao',
                          style: context.styles.bodyMedium.copyWith(
                            color: Colors.white.withOpacity(0.9),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: AppSizes.paddingLarge),
                        CustomButton(
                          text: 'Nâng cấp ngay',
                          onPressed: () {
                            // TODO: Navigate to premium upgrade
                          },
                          backgroundColor: Colors.white,
                          textColor: context.colors.primary,
                          useGradient: false,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ],
    );
  }

  Widget _buildRecentQrItem(
    BuildContext context,
    String title,
    String content,
    String type,
    IconData icon,
    Color color,
  ) {
    return AnimatedCard(
      margin: const EdgeInsets.only(bottom: AppSizes.paddingMedium),
      onTap: () {
        // TODO: Open QR code details
      },
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(AppSizes.paddingSmall),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
          ),
          child: Icon(
            icon,
            color: color,
            size: AppSizes.iconSmall,
          ),
        ),
        title: Text(
          title,
          style: context.styles.titleSmall.copyWith(
            color: context.colors.text,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          content,
          style: context.styles.bodySmall.copyWith(
            color: context.colors.textSecondary,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: context.colors.textSecondary,
          size: AppSizes.iconTiny,
        ),
      ),
    );
  }
}
