import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:internal_core/internal_core.dart';

import '../../constants/constants.dart';
import '../../utils/app_go_router.dart';
import '../../utils/app_prefs.dart';

class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({super.key});

  @override
  State<IntroductionScreen> createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen>
    with TickerProviderStateMixin {
  late ScrollController _scrollController;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _fadeController = AnimationController(
      duration: AppStyles.instance.animationNormal,
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    ));

    _fadeController.forward();
  }

  @override
  void dispose() {
    _scrollController.dispose();
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
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: CustomScrollView(
                controller: _scrollController,
                slivers: [
                  // App Bar
                  SliverAppBar(
                    expandedHeight: 120,
                    floating: false,
                    pinned: true,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    flexibleSpace: FlexibleSpaceBar(
                      title: Text(
                        appName,
                        style: context.styles.headlineMedium.copyWith(
                          color: context.colors.text,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      centerTitle: true,
                      background: Container(
                        decoration: BoxDecoration(
                          gradient: context.colors.primaryGradient,
                        ),
                      ),
                    ),
                  ),

                  // Content
                  SliverPadding(
                    padding: const EdgeInsets.all(AppSizes.paddingLarge),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        // Welcome Section
                        _buildSection(
                          title: 'Chào mừng đến với CodeCraft',
                          subtitle: 'Nền tảng tạo và quản lý QR Code hàng đầu',
                          icon: Icons.qr_code_scanner,
                          content:
                              'CodeCraft giúp bạn tạo ra những QR Code chuyên nghiệp với nhiều tính năng độc đáo. Từ QR Code cơ bản đến QR Code động với phân tích chi tiết.',
                        ),

                        const SizedBox(height: AppSizes.paddingXLarge),

                        // Features Section
                        _buildFeaturesSection(),

                        const SizedBox(height: AppSizes.paddingXLarge),

                        // How to Use Section
                        _buildHowToUseSection(),

                        const SizedBox(height: AppSizes.paddingXLarge),

                        // FAQ Section
                        _buildFAQSection(),

                        const SizedBox(height: AppSizes.paddingXLarge),

                        // Support Section
                        _buildSupportSection(),

                        const SizedBox(height: AppSizes.paddingXXLarge),

                        // Get Started Button
                        _buildGetStartedButton(),

                        const SizedBox(height: AppSizes.paddingLarge),
                      ]),
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

  Widget _buildSection({
    required String title,
    required String subtitle,
    required IconData icon,
    required String content,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.paddingLarge),
      decoration: context.styles.cardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppSizes.paddingMedium),
                decoration: BoxDecoration(
                  gradient: context.colors.primaryGradient,
                  borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: AppSizes.iconMedium,
                ),
              ),
              const SizedBox(width: AppSizes.paddingMedium),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: context.styles.headlineSmall.copyWith(
                        color: context.colors.text,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: context.styles.bodyMedium.copyWith(
                        color: context.colors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.paddingMedium),
          Text(
            content,
            style: context.styles.bodyMedium.copyWith(
              color: context.colors.text,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturesSection() {
    return Container(
      padding: const EdgeInsets.all(AppSizes.paddingLarge),
      decoration: context.styles.cardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppSizes.paddingMedium),
                decoration: BoxDecoration(
                  gradient: context.colors.accentGradient,
                  borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
                ),
                child: const Icon(
                  Icons.star,
                  color: Colors.white,
                  size: AppSizes.iconMedium,
                ),
              ),
              const SizedBox(width: AppSizes.paddingMedium),
              Text(
                'Tính năng nổi bật',
                style: context.styles.headlineSmall.copyWith(
                  color: context.colors.text,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.paddingLarge),
          ...qrCodeTypes.take(6).map((type) => Padding(
                padding: const EdgeInsets.only(bottom: AppSizes.paddingMedium),
                child: Row(
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: context.colors.success,
                      size: AppSizes.iconSmall,
                    ),
                    const SizedBox(width: AppSizes.paddingMedium),
                    Expanded(
                      child: Text(
                        'Tạo QR Code $type',
                        style: context.styles.bodyMedium.copyWith(
                          color: context.colors.text,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildHowToUseSection() {
    return Container(
      padding: const EdgeInsets.all(AppSizes.paddingLarge),
      decoration: context.styles.cardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppSizes.paddingMedium),
                decoration: BoxDecoration(
                  gradient: context.colors.primaryGradient,
                  borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
                ),
                child: const Icon(
                  Icons.help_outline,
                  color: Colors.white,
                  size: AppSizes.iconMedium,
                ),
              ),
              const SizedBox(width: AppSizes.paddingMedium),
              Text(
                'Hướng dẫn sử dụng',
                style: context.styles.headlineSmall.copyWith(
                  color: context.colors.text,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.paddingLarge),
          _buildStepItem('1', 'Chọn loại QR Code bạn muốn tạo'),
          _buildStepItem('2', 'Nhập thông tin cần thiết'),
          _buildStepItem('3', 'Tùy chỉnh giao diện và màu sắc'),
          _buildStepItem('4', 'Tạo và lưu QR Code'),
          _buildStepItem('5', 'Quét QR Code để sử dụng'),
        ],
      ),
    );
  }

  Widget _buildStepItem(String step, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSizes.paddingMedium),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: context.colors.primary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                step,
                style: context.styles.labelSmall.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: AppSizes.paddingMedium),
          Expanded(
            child: Text(
              description,
              style: context.styles.bodyMedium.copyWith(
                color: context.colors.text,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFAQSection() {
    return Container(
      padding: const EdgeInsets.all(AppSizes.paddingLarge),
      decoration: context.styles.cardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppSizes.paddingMedium),
                decoration: BoxDecoration(
                  gradient: context.colors.accentGradient,
                  borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
                ),
                child: const Icon(
                  Icons.question_answer,
                  color: Colors.white,
                  size: AppSizes.iconMedium,
                ),
              ),
              const SizedBox(width: AppSizes.paddingMedium),
              Text(
                'Câu hỏi thường gặp',
                style: context.styles.headlineSmall.copyWith(
                  color: context.colors.text,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.paddingLarge),
          _buildFAQItem(
            'QR Code động là gì?',
            'QR Code động cho phép bạn thay đổi nội dung mà không cần tạo lại mã. Khi người dùng quét, họ sẽ được chuyển đến trang web với nội dung bạn đã cập nhật.',
          ),
          _buildFAQItem(
            'Có thể tùy chỉnh màu sắc QR Code không?',
            'Có! CodeCraft cung cấp nhiều palette màu đẹp mắt. Bạn có thể chọn từ 6 bộ màu khác nhau hoặc tùy chỉnh theo ý thích.',
          ),
          _buildFAQItem(
            'Làm thế nào để xem thống kê QR Code?',
            'Với tài khoản Premium, bạn có thể theo dõi số lượt quét, vị trí địa lý, thiết bị sử dụng và nhiều thông tin chi tiết khác.',
          ),
        ],
      ),
    );
  }

  Widget _buildFAQItem(String question, String answer) {
    return ExpansionTile(
      title: Text(
        question,
        style: context.styles.titleMedium.copyWith(
          color: context.colors.text,
          fontWeight: FontWeight.w600,
        ),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSizes.paddingLarge,
            0,
            AppSizes.paddingLarge,
            AppSizes.paddingMedium,
          ),
          child: Text(
            answer,
            style: context.styles.bodyMedium.copyWith(
              color: context.colors.textSecondary,
              height: 1.6,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSupportSection() {
    return Container(
      padding: const EdgeInsets.all(AppSizes.paddingLarge),
      decoration: context.styles.cardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppSizes.paddingMedium),
                decoration: BoxDecoration(
                  gradient: context.colors.primaryGradient,
                  borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
                ),
                child: const Icon(
                  Icons.support_agent,
                  color: Colors.white,
                  size: AppSizes.iconMedium,
                ),
              ),
              const SizedBox(width: AppSizes.paddingMedium),
              Text(
                'Hỗ trợ & Liên hệ',
                style: context.styles.headlineSmall.copyWith(
                  color: context.colors.text,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.paddingLarge),
          _buildSupportItem(
            Icons.email,
            'Email',
            'support@codecraft.com',
          ),
          _buildSupportItem(
            Icons.web,
            'Website',
            'www.codecraft.com',
          ),
          _buildSupportItem(
            Icons.chat,
            'Live Chat',
            'Có sẵn 24/7',
          ),
        ],
      ),
    );
  }

  Widget _buildSupportItem(IconData icon, String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSizes.paddingMedium),
      child: Row(
        children: [
          Icon(
            icon,
            color: context.colors.primary,
            size: AppSizes.iconSmall,
          ),
          const SizedBox(width: AppSizes.paddingMedium),
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
                  subtitle,
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

  Widget _buildGetStartedButton() {
    return Container(
      width: double.infinity,
      height: AppSizes.buttonHeightLarge,
      decoration: context.styles.primaryGradientDecoration,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
          onTap: () {
            AppGoRouter.instance.goToHome();
          },
          child: Center(
            child: Text(
              'Bắt đầu ngay',
              style: context.styles.labelLarge.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
