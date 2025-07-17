import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:internal_core/internal_core.dart';

import '../../constants/constants.dart';
import '../../utils/app_prefs.dart';
import 'widgets/profile_header.dart';
import 'widgets/settings_item.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              // App Bar
              SliverAppBar(
                expandedHeight: 120,
                floating: false,
                pinned: true,
                backgroundColor: context.colors.background,
                elevation: 0,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    'Cá nhân',
                    style: context.styles.headlineMedium.copyWith(
                      color: context.colors.text,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  centerTitle: true,
                ),
                actions: [
                  IconButton(
                    onPressed: _showNotifications,
                    icon: Icon(
                      Icons.notifications_outlined,
                      color: context.colors.text,
                    ),
                  ),
                ],
              ),

              // Content
              SliverPadding(
                padding: const EdgeInsets.all(AppSizes.paddingLarge),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    // Profile Header
                    ProfileHeader(
                      username: 'Nguyễn Văn A',
                      email: 'nguyenvana@email.com',
                      avatarUrl: null,
                      isPremium: false,
                      onEditProfile: _editProfile,
                      onUpgradePremium: _upgradePremium,
                    ),

                    const SizedBox(height: AppSizes.paddingXLarge),

                    // Quick Stats
                    Container(
                      padding: const EdgeInsets.all(AppSizes.paddingLarge),
                      decoration: context.styles.cardDecoration,
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
                          Expanded(
                            child: _buildStatItem(
                              'Lượt quét',
                              '156',
                              Icons.qr_code_scanner,
                              context.colors.secondary,
                            ),
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

                    const SizedBox(height: AppSizes.paddingLarge),

                    // Settings Section
                    Text(
                      'Cài đặt',
                      style: context.styles.titleLarge.copyWith(
                        color: context.colors.text,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: AppSizes.paddingMedium),

                    // Appearance
                    SettingsItem(
                      icon: Icons.palette,
                      title: 'Giao diện',
                      subtitle: AppPrefs.instance.isDarkTheme ? 'Tối' : 'Sáng',
                      onTap: _toggleTheme,
                      trailing: Switch(
                        value: AppPrefs.instance.isDarkTheme,
                        onChanged: (value) => _toggleTheme(),
                        activeColor: context.colors.primary,
                      ),
                    ),

                    // Color Palette
                    SettingsItem(
                      icon: Icons.color_lens,
                      title: 'Bảng màu',
                      subtitle: 'Thay đổi màu sắc chủ đạo',
                      onTap: _changeColorPalette,
                    ),

                    // Language
                    SettingsItem(
                      icon: Icons.language,
                      title: 'Ngôn ngữ',
                      subtitle: 'Tiếng Việt',
                      onTap: _changeLanguage,
                    ),

                    // Notifications
                    SettingsItem(
                      icon: Icons.notifications,
                      title: 'Thông báo',
                      subtitle: 'Cài đặt thông báo',
                      onTap: _notificationSettings,
                    ),

                    const SizedBox(height: AppSizes.paddingLarge),

                    // Features Section
                    Text(
                      'Tính năng',
                      style: context.styles.titleLarge.copyWith(
                        color: context.colors.text,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: AppSizes.paddingMedium),

                    // Premium Features
                    SettingsItem(
                      icon: Icons.star,
                      title: 'Premium',
                      subtitle: 'Mở khóa tất cả tính năng',
                      onTap: _upgradePremium,
                      trailing: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSizes.paddingSmall,
                          vertical: AppSizes.paddingTiny,
                        ),
                        decoration: BoxDecoration(
                          color: context.colors.primary,
                          borderRadius:
                              BorderRadius.circular(AppSizes.radiusSmall),
                        ),
                        child: Text(
                          'Nâng cấp',
                          style: context.styles.labelSmall.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    // Export Data
                    SettingsItem(
                      icon: Icons.download,
                      title: 'Xuất dữ liệu',
                      subtitle: 'Sao lưu QR Codes',
                      onTap: _exportData,
                    ),

                    // Import Data
                    SettingsItem(
                      icon: Icons.upload,
                      title: 'Nhập dữ liệu',
                      subtitle: 'Khôi phục từ sao lưu',
                      onTap: _importData,
                    ),

                    const SizedBox(height: AppSizes.paddingLarge),

                    // Support Section
                    Text(
                      'Hỗ trợ',
                      style: context.styles.titleLarge.copyWith(
                        color: context.colors.text,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: AppSizes.paddingMedium),

                    // Help & FAQ
                    SettingsItem(
                      icon: Icons.help,
                      title: 'Trợ giúp & FAQ',
                      subtitle: 'Câu hỏi thường gặp',
                      onTap: _showHelp,
                    ),

                    // Feedback
                    SettingsItem(
                      icon: Icons.feedback,
                      title: 'Gửi phản hồi',
                      subtitle: 'Đánh giá ứng dụng',
                      onTap: _sendFeedback,
                    ),

                    // About
                    SettingsItem(
                      icon: Icons.info,
                      title: 'Về ứng dụng',
                      subtitle: 'Phiên bản 1.0.0',
                      onTap: _showAbout,
                    ),

                    const SizedBox(height: AppSizes.paddingLarge),

                    // Account Section
                    Text(
                      'Tài khoản',
                      style: context.styles.titleLarge.copyWith(
                        color: context.colors.text,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: AppSizes.paddingMedium),

                    // Privacy Policy
                    SettingsItem(
                      icon: Icons.privacy_tip,
                      title: 'Chính sách bảo mật',
                      subtitle: 'Thông tin bảo mật',
                      onTap: _showPrivacyPolicy,
                    ),

                    // Terms of Service
                    SettingsItem(
                      icon: Icons.description,
                      title: 'Điều khoản sử dụng',
                      subtitle: 'Điều khoản và điều kiện',
                      onTap: _showTerms,
                    ),

                    // Logout
                    SettingsItem(
                      icon: Icons.logout,
                      title: 'Đăng xuất',
                      subtitle: 'Thoát khỏi tài khoản',
                      onTap: _logout,
                      textColor: context.colors.error,
                    ),

                    const SizedBox(height: AppSizes.paddingXLarge),
                  ]),
                ),
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
          padding: const EdgeInsets.all(AppSizes.paddingMedium),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
          ),
          child: Icon(
            icon,
            color: color,
            size: AppSizes.iconMedium,
          ),
        ),
        const SizedBox(height: AppSizes.paddingSmall),
        Text(
          value,
          style: context.styles.titleLarge.copyWith(
            color: color,
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
    // TODO: Navigate to premium upgrade
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
