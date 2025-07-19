import 'package:app/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internal_core/internal_core.dart';

import '../../constants/constants.dart';
import '../../utils/app_prefs.dart';
import '../qr_create/qr_create_screen.dart';
import '../qr_scan/qr_scan_screen.dart';
import '../qr_manage/qr_manage_screen.dart';
import '../profile/profile_screen.dart';
import '../premium/premium_screen.dart';
import '../widgets/widget_popup_login.dart';
import '../widgets/widgets.dart';
import 'cubit/home_cubit.dart';
import 'cubit/home_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final List<Widget> _pages = [
    const HomeTab(),
    const QrCreateScreen(),
    const QrScanScreen(),
    const QrManageScreen(),
    const ProfileScreen(),
  ];

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
      child: BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
        return Scaffold(
          backgroundColor: context.colors.background,
          body: _pages[state.currentIndex],
          bottomNavigationBar: CustomBottomBar(
            currentIndex: state.currentIndex,
            onTap: (index) {
              context.read<HomeCubit>().updateCurrentIndex(index);
            },
            items: [
              BottomBarItems.home,
              BottomBarItems.qr,
              BottomBarItems.scan,
              const BottomBarItem(
                icon: Icons.folder_outlined,
                selectedIcon: Icons.folder_rounded,
                label: 'Quản lý',
              ),
              BottomBarItems.profile,
            ],
          ),
        );
      }),
    );
  }
}

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> with TickerProviderStateMixin {
  late AnimationController _mainController;
  late AnimationController _staggerController;
  late Animation<double> _mainAnimation;
  late Animation<double> _staggerAnimation;

  @override
  void initState() {
    super.initState();
    _mainController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _staggerController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _mainAnimation = CurvedAnimation(
      parent: _mainController,
      curve: Curves.easeOutBack,
    );

    _staggerAnimation = CurvedAnimation(
      parent: _staggerController,
      curve: Curves.easeOutCubic,
    );

    _mainController.forward();
    Future.delayed(const Duration(milliseconds: 300), () {
      _staggerController.forward();
    });
  }

  @override
  void dispose() {
    _mainController.dispose();
    _staggerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            context.colors.primary.withOpacity(0.05),
            context.colors.background,
            context.colors.background,
          ],
          stops: const [0.0, 0.3, 1.0],
        ),
      ),
      child: Column(
        children: [
          // Hero App Bar
          _buildHeroAppBar(),

          // Content
          Expanded(
            child: CustomScrollView(
              slivers: [
                // Welcome Section
                SliverToBoxAdapter(
                  child: _buildWelcomeSection(),
                ),

                // Quick Actions Grid
                SliverToBoxAdapter(
                  child: _buildQuickActionsGrid(),
                ),

                // Statistics Section
                SliverToBoxAdapter(
                  child: _buildStatisticsSection(),
                ),

                // Recent QR Codes
                SliverToBoxAdapter(
                  child: _buildRecentQrSection(),
                ),

                // Features Section
                SliverToBoxAdapter(
                  child: _buildFeaturesSection(),
                ),

                // Premium Banner
                SliverToBoxAdapter(
                  child: _buildPremiumBanner(),
                ),

                // Bottom spacing
                const SliverToBoxAdapter(
                  child: SizedBox(height: 100),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroAppBar() {
    return FadeTransition(
      opacity: _mainAnimation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, -0.5),
          end: Offset.zero,
        ).animate(_mainAnimation),
        child: Container(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + 20,
            left: 20,
            right: 20,
            bottom: 20,
          ),
          child: Row(
            children: [
              // Profile Avatar
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  gradient: context.colors.primaryGradient,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: context.colors.primary.withOpacity(0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 24,
                ),
              ),

              const SizedBox(width: 15),

              // Welcome Text
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Chào mừng trở lại!',
                      style: context.styles.titleMedium.copyWith(
                        color: context.colors.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'Nguyễn Văn A',
                      style: context.styles.headlineSmall.copyWith(
                        color: context.colors.text,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              // Action Buttons
              Row(
                children: [
                  _buildActionButton(
                    icon: Icons.notifications_outlined,
                    badgeCount: 3,
                    onTap: () {
                      // TODO: Show notifications
                    },
                  ),
                  const SizedBox(width: 10),
                  _buildActionButton(
                    icon: Icons.settings_outlined,
                    onTap: () {
                      // TODO: Show settings
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    int? badgeCount,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Stack(
          children: [
            Center(
              child: Icon(
                icon,
                color: context.colors.text,
                size: 22,
              ),
            ),
            if (badgeCount != null)
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    badgeCount.toString(),
                    style: context.styles.bodySmall.copyWith(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeSection() {
    return FadeTransition(
      opacity: _mainAnimation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.3),
          end: Offset.zero,
        ).animate(_mainAnimation),
        child: Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
            gradient: context.colors.primaryGradient,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: context.colors.primary.withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tạo QR Code',
                      style: context.styles.headlineSmall.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Nhanh chóng và dễ dàng',
                      style: context.styles.bodyMedium.copyWith(
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  Icons.qr_code,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickActionsGrid() {
    return FadeTransition(
      opacity: _staggerAnimation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.2),
          end: Offset.zero,
        ).animate(_staggerAnimation),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
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
              const SizedBox(height: 20),
              // Sử dụng Wrap thay cho GridView để hiển thị các quick action card, giúp responsive tốt hơn
              Wrap(
                spacing: 15,
                runSpacing: 15,
                children: [
                  _buildQuickActionCard(
                    title: 'Tạo QR',
                    subtitle: 'Tạo QR Code mới',
                    icon: Icons.qr_code,
                    color: context.colors.primary,
                    onTap: () {
                      context.read<HomeCubit>().updateCurrentIndex(1);
                    },
                  ),
                  _buildQuickActionCard(
                    title: 'Quét QR',
                    subtitle: 'Quét QR Code',
                    icon: Icons.qr_code_scanner,
                    color: context.colors.secondary,
                    onTap: () {
                      context.read<HomeCubit>().updateCurrentIndex(2);
                    },
                  ),
                  _buildQuickActionCard(
                    title: 'Quản lý',
                    subtitle: 'Quản lý QR Code',
                    icon: Icons.folder,
                    color: context.colors.accent,
                    onTap: () {
                      // context.read<HomeCubit>().updateCurrentIndex(3);
                      appOpenDialog(PopupLoginRequired());
                    },
                  ),
                  _buildQuickActionCard(
                    title: 'Lịch sử',
                    subtitle: 'Xem lịch sử',
                    icon: Icons.history,
                    color: context.colors.success,
                    onTap: () {
                      context.read<HomeCubit>().updateCurrentIndex(3);
                    },
                  ),
                ]
                    .map((widget) => SizedBox(
                          width: (MediaQuery.of(context).size.width - 55) /
                              2, // 20 + 20 padding + 15 spacing
                          child: widget,
                        ))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickActionCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          gradient: context.colors.lightPrimaryGradient,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 25,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                title,
                style: context.styles.titleMedium.copyWith(
                  color: context.colors.text,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 5),
              Text(
                subtitle,
                style: context.styles.bodySmall.copyWith(
                  color: context.colors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatisticsSection() {
    return FadeTransition(
      opacity: _staggerAnimation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.2),
          end: Offset.zero,
        ).animate(_staggerAnimation),
        child: Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Thống kê',
                style: context.styles.titleLarge.copyWith(
                  color: context.colors.text,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: _buildStatItem(
                      title: 'Đã tạo',
                      value: '24',
                      icon: Icons.qr_code,
                      color: context.colors.primary,
                    ),
                  ),
                  Expanded(
                    child: _buildStatItem(
                      title: 'Đã quét',
                      value: '156',
                      icon: Icons.qr_code_scanner,
                      color: context.colors.secondary,
                    ),
                  ),
                  Expanded(
                    child: _buildStatItem(
                      title: 'Lưu trữ',
                      value: '8.5MB',
                      icon: Icons.storage,
                      color: context.colors.accent,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Icon(
            icon,
            color: color,
            size: 24,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          value,
          style: context.styles.headlineSmall.copyWith(
            color: context.colors.text,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          title,
          style: context.styles.bodySmall.copyWith(
            color: context.colors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildRecentQrSection() {
    return FadeTransition(
      opacity: _staggerAnimation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.2),
          end: Offset.zero,
        ).animate(_staggerAnimation),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'QR Code gần đây',
                    style: context.styles.titleLarge.copyWith(
                      color: context.colors.text,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // TODO: Navigate to all QR codes
                    },
                    child: Text(
                      'Xem tất cả',
                      style: context.styles.bodyMedium.copyWith(
                        color: context.colors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              _buildRecentQrItem(
                'Website chính',
                'https://codecraft.com',
                'URL',
                Icons.link,
                context.colors.primary,
              ),
              _buildRecentQrItem(
                'WiFi nhà',
                'SSID: HomeWiFi',
                'WiFi',
                Icons.wifi,
                context.colors.accent,
              ),
              _buildRecentQrItem(
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
    );
  }

  Widget _buildRecentQrItem(
    String title,
    String content,
    String type,
    IconData icon,
    Color color,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        leading: Container(
          width: 45,
          height: 45,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: color,
            size: 20,
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
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            type,
            style: context.styles.bodySmall.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
              fontSize: 10,
            ),
          ),
        ),
        onTap: () {
          // TODO: Open QR code details
        },
      ),
    );
  }

  Widget _buildFeaturesSection() {
    return FadeTransition(
      opacity: _staggerAnimation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.2),
          end: Offset.zero,
        ).animate(_staggerAnimation),
        child: Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tính năng nổi bật',
                style: context.styles.titleLarge.copyWith(
                  color: context.colors.text,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              _buildFeatureItem(
                'Tạo QR Code đa dạng',
                'URL, WiFi, Text, Email, Phone...',
                Icons.qr_code_2,
                context.colors.primary,
              ),
              _buildFeatureItem(
                'Quét QR nhanh chóng',
                'Camera chất lượng cao, nhận diện chính xác',
                Icons.qr_code_scanner,
                context.colors.secondary,
              ),
              _buildFeatureItem(
                'Quản lý dễ dàng',
                'Lưu trữ, phân loại, tìm kiếm QR Code',
                Icons.folder,
                context.colors.accent,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureItem(
    String title,
    String description,
    IconData icon,
    Color color,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: color,
              size: 20,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.styles.titleSmall.copyWith(
                    color: context.colors.text,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  description,
                  style: context.styles.bodySmall.copyWith(
                    color: context.colors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPremiumBanner() {
    return FadeTransition(
      opacity: _staggerAnimation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.2),
          end: Offset.zero,
        ).animate(_staggerAnimation),
        child: PremiumBanner(
          title: 'Nâng cấp Premium',
          subtitle: 'Mở khóa tất cả tính năng nâng cao',
          buttonText: 'Nâng cấp ngay',
        ),
      ),
    );
  }
}
