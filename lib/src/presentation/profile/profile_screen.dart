import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:internal_core/internal_core.dart';

import '../../constants/constants.dart';
import '../../utils/app_prefs.dart';
import '../widgets/widgets.dart' hide IconButton;
import '../premium/premium_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _pulseController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.2, 0.8, curve: Curves.easeOutCubic),
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.4, 1.0, curve: Curves.elasticOut),
    ));

    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    _animationController.forward();
    _pulseController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
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
          child: SafeArea(
            top: false,
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                // Hero App Bar
                SliverAppBar(
                  expandedHeight: 200,
                  floating: false,
                  pinned: true,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                      decoration: BoxDecoration(
                        gradient: context.colors.primaryGradient,
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                      child: Stack(
                        children: [
                          // Background particles
                          ...List.generate(
                              15, (index) => _buildParticle(index)),

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
                                    // Avatar with gradient border
                                    AnimatedBuilder(
                                      animation: _pulseAnimation,
                                      builder: (context, child) {
                                        return Transform.scale(
                                          scale: _pulseAnimation.value,
                                          child: Container(
                                            padding: const EdgeInsets.all(4),
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: [
                                                  Colors.white.withOpacity(0.3),
                                                  Colors.white.withOpacity(0.1),
                                                ],
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.2),
                                                  blurRadius: 20,
                                                  offset: const Offset(0, 10),
                                                ),
                                              ],
                                            ),
                                            child: CircleAvatar(
                                              radius: 40,
                                              backgroundColor:
                                                  Colors.white.withOpacity(0.2),
                                              child: Icon(
                                                Icons.person,
                                                size: 40,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    const SizedBox(height: 16),

                                    // Username
                                    Text(
                                      'Nguyễn Văn A',
                                      style: context.styles.headlineMedium
                                          .copyWith(
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

                                    // Email
                                    Text(
                                      'nguyenvana@email.com',
                                      style: context.styles.bodyMedium.copyWith(
                                        color: Colors.white.withOpacity(0.8),
                                        shadows: [
                                          Shadow(
                                            color:
                                                Colors.black.withOpacity(0.2),
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
                        ],
                      ),
                    ),
                    centerTitle: true,
                  ),
                ),

                // Content
                SliverPadding(
                  padding: const EdgeInsets.all(AppSizes.paddingLarge),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      // Premium Banner
                      FadeTransition(
                        opacity: _fadeAnimation,
                        child: SlideTransition(
                          position: _slideAnimation,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 24),
                            child: PremiumBannerHoriz(
                              title: 'Nâng cấp Premium',
                              subtitle: 'Mở khóa tất cả tính năng nâng cao',
                              buttonText: 'Nâng cấp ngay',
                            ),
                          ),
                        ),
                      ),

                      // Stats Section
                      FadeTransition(
                        opacity: _fadeAnimation,
                        child: SlideTransition(
                          position: _slideAnimation,
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 24),
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.08),
                                  blurRadius: 20,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: _buildStatItem(
                                    'QR Codes',
                                    '12',
                                    Icons.qr_code,
                                    context.colors.primary,
                                  ),
                                ),
                                Container(
                                  width: 1,
                                  height: 60,
                                  color: context.colors.textSecondary
                                      .withOpacity(0.2),
                                ),
                                Expanded(
                                  child: _buildStatItem(
                                    'Lượt quét',
                                    '156',
                                    Icons.qr_code_scanner,
                                    context.colors.secondary,
                                  ),
                                ),
                                Container(
                                  width: 1,
                                  height: 60,
                                  color: context.colors.textSecondary
                                      .withOpacity(0.2),
                                ),
                                Expanded(
                                  child: _buildStatItem(
                                    'Yêu thích',
                                    '8',
                                    Icons.favorite,
                                    context.colors.error,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      // Settings Section
                      _buildSectionTitle('Cài đặt', 0.6),
                      const SizedBox(height: 16),

                      _buildSettingsCard([
                        _buildSettingsItem(
                          Icons.palette,
                          'Giao diện',
                          AppPrefs.instance.isDarkTheme ? 'Tối' : 'Sáng',
                          trailing: Switch(
                            value: AppPrefs.instance.isDarkTheme,
                            onChanged: (value) => _toggleTheme(),
                            activeColor: context.colors.primary,
                          ),
                          onTap: _toggleTheme,
                        ),
                        _buildSettingsItem(
                          Icons.color_lens,
                          'Bảng màu',
                          'Thay đổi màu sắc chủ đạo',
                          onTap: _changeColorPalette,
                        ),
                        _buildSettingsItem(
                          Icons.language,
                          'Ngôn ngữ',
                          'Tiếng Việt',
                          onTap: _changeLanguage,
                        ),
                        _buildSettingsItem(
                          Icons.notifications,
                          'Thông báo',
                          'Cài đặt thông báo',
                          onTap: _notificationSettings,
                        ),
                      ]),

                      const SizedBox(height: 24),

                      // Features Section
                      _buildSectionTitle('Tính năng', 0.7),
                      const SizedBox(height: 16),

                      _buildSettingsCard([
                        _buildSettingsItem(
                          Icons.download,
                          'Xuất dữ liệu',
                          'Sao lưu QR Codes',
                          onTap: _exportData,
                        ),
                        _buildSettingsItem(
                          Icons.upload,
                          'Nhập dữ liệu',
                          'Khôi phục từ sao lưu',
                          onTap: _importData,
                        ),
                        _buildSettingsItem(
                          Icons.share,
                          'Chia sẻ ứng dụng',
                          'Giới thiệu cho bạn bè',
                          onTap: _shareApp,
                        ),
                      ]),

                      const SizedBox(height: 24),

                      // Support Section
                      _buildSectionTitle('Hỗ trợ', 0.8),
                      const SizedBox(height: 16),

                      _buildSettingsCard([
                        _buildSettingsItem(
                          Icons.help,
                          'Trợ giúp & FAQ',
                          'Câu hỏi thường gặp',
                          onTap: _showHelp,
                        ),
                        _buildSettingsItem(
                          Icons.feedback,
                          'Gửi phản hồi',
                          'Đánh giá ứng dụng',
                          onTap: _sendFeedback,
                        ),
                        _buildSettingsItem(
                          Icons.info,
                          'Về ứng dụng',
                          'Phiên bản 1.0.0',
                          onTap: _showAbout,
                        ),
                      ]),

                      const SizedBox(height: 24),

                      // Account Section
                      _buildSectionTitle('Tài khoản', 0.9),
                      const SizedBox(height: 16),

                      _buildSettingsCard([
                        _buildSettingsItem(
                          Icons.privacy_tip,
                          'Chính sách bảo mật',
                          'Thông tin bảo mật',
                          onTap: _showPrivacyPolicy,
                        ),
                        _buildSettingsItem(
                          Icons.description,
                          'Điều khoản sử dụng',
                          'Điều khoản và điều kiện',
                          onTap: _showTerms,
                        ),
                        _buildSettingsItem(
                          Icons.logout,
                          'Đăng xuất',
                          'Thoát khỏi tài khoản',
                          onTap: _logout,
                          textColor: context.colors.error,
                        ),
                      ]),

                      const SizedBox(height: 32),
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildParticle(int index) {
    return AnimatedBuilder(
      animation: _pulseController,
      builder: (context, child) {
        return Positioned(
          left: (index * 37) % 400.0,
          top: (index * 73) % 200.0,
          child: Transform.scale(
            scale: _pulseAnimation.value,
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

  Widget _buildSectionTitle(String title, double interval) {
    return FadeTransition(
      opacity: Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(CurvedAnimation(
        parent: _animationController,
        curve: Interval(interval, interval + 0.2, curve: Curves.easeOut),
      )),
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.3),
          end: Offset.zero,
        ).animate(CurvedAnimation(
          parent: _animationController,
          curve: Interval(interval, interval + 0.2, curve: Curves.easeOutCubic),
        )),
        child: Text(
          title,
          style: context.styles.titleLarge.copyWith(
            color: context.colors.text,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsCard(List<Widget> children) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            children: children.asMap().entries.map((entry) {
              final index = entry.key;
              final child = entry.value;
              return Column(
                children: [
                  child,
                  if (index < children.length - 1)
                    Container(
                      height: 1,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      color: context.colors.textSecondary.withOpacity(0.1),
                    ),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsItem(
    IconData icon,
    String title,
    String subtitle, {
    Widget? trailing,
    VoidCallback? onTap,
    Color? textColor,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: context.colors.primaryGradient,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: context.styles.titleMedium.copyWith(
                        color: textColor ?? context.colors.text,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: context.styles.bodySmall.copyWith(
                        color: textColor?.withOpacity(0.7) ??
                            context.colors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              if (trailing != null) trailing,
              if (trailing == null && onTap != null)
                Icon(
                  Icons.chevron_right,
                  color: context.colors.textSecondary,
                  size: 20,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(
      String label, String value, IconData icon, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                color.withOpacity(0.1),
                color.withOpacity(0.05),
              ],
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: color.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Icon(
            icon,
            color: color,
            size: 24,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          value,
          style: context.styles.titleLarge.copyWith(
            color: context.colors.text,
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

  void _showNotifications() {
    // TODO: Show notifications
  }

  void _editProfile() {
    // TODO: Edit profile
  }

  void _upgradePremium() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const PremiumScreen(),
      ),
    );
  }

  void _toggleTheme() {
    // AppPrefs.instance.toggleTheme();
    setState(() {});
  }

  void _changeColorPalette() {
    // TODO: Show color palette picker
  }

  void _changeLanguage() {
    // TODO: Show language picker
  }

  void _notificationSettings() {
    // TODO: Show notification settings
  }

  void _exportData() {
    // TODO: Export data
  }

  void _importData() {
    // TODO: Import data
  }

  void _shareApp() {
    // TODO: Share app
  }

  void _showHelp() {
    // TODO: Show help & FAQ
  }

  void _sendFeedback() {
    // TODO: Send feedback
  }

  void _showAbout() {
    // TODO: Show about dialog
  }

  void _showPrivacyPolicy() {
    // TODO: Show privacy policy
  }

  void _showTerms() {
    // TODO: Show terms of service
  }

  void _logout() {
    // TODO: Logout user
  }
}
