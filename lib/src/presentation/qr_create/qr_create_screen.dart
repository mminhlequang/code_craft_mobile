import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:internal_core/internal_core.dart';

import '../../constants/constants.dart';
import '../../utils/app_prefs.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_card.dart';
import '../widgets/custom_button.dart';
import 'widgets/qr_type_card.dart';
import 'widgets/qr_form_container.dart';

class QrCreateScreen extends StatefulWidget {
  const QrCreateScreen({super.key});

  @override
  State<QrCreateScreen> createState() => _QrCreateScreenState();
}

class _QrCreateScreenState extends State<QrCreateScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  String? _selectedQrType;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
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
        body: SafeArea(
          child: Column(
            children: [
              // App Bar
              CustomAppBar(
                title: 'Tạo QR Code',
                useGradient: true,
                showBackButton: true,
              ),

              // Tab Bar
              Container(
                margin: const EdgeInsets.all(AppSizes.paddingLarge),
                decoration: BoxDecoration(
                  color: context.colors.surface,
                  borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: TabBar(
                  controller: _tabController,
                  indicator: BoxDecoration(
                    gradient: context.colors.primaryGradient,
                    borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelColor: Colors.white,
                  unselectedLabelColor: context.colors.textSecondary,
                  labelStyle: context.styles.labelLarge.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  unselectedLabelStyle: context.styles.labelLarge,
                  tabs: const [
                    Tab(text: 'QR Thường'),
                    Tab(text: 'QR Động'),
                  ],
                ),
              ),

              // Tab Content
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildNormalQrTab(),
                    _buildDynamicQrTab(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNormalQrTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSizes.paddingLarge),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Chọn loại QR Code',
            style: context.styles.headlineSmall.copyWith(
              color: context.colors.text,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppSizes.paddingMedium),
          Text(
            'Tạo QR Code theo chuẩn quốc tế',
            style: context.styles.bodyMedium.copyWith(
              color: context.colors.textSecondary,
            ),
          ),
          const SizedBox(height: AppSizes.paddingLarge),

          // QR Type Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: AppSizes.paddingMedium,
              mainAxisSpacing: AppSizes.paddingMedium,
              childAspectRatio: 1.2,
            ),
            itemCount: qrCodeTypes.length - 1, // Exclude Custom Content
            itemBuilder: (context, index) {
              final qrType = qrCodeTypes[index];
              return QrTypeCard(
                title: qrType,
                icon: _getQrTypeIcon(qrType),
                color: _getQrTypeColor(qrType),
                isSelected: _selectedQrType == qrType,
                onTap: () {
                  setState(() {
                    _selectedQrType = qrType;
                  });
                  _showQrForm(qrType);
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDynamicQrTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSizes.paddingLarge),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Premium Banner
          GradientCard(
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
                  'QR Code Động',
                  style: context.styles.headlineSmall.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: AppSizes.paddingSmall),
                Text(
                  'Tạo QR Code với nội dung có thể thay đổi và theo dõi thống kê',
                  style: context.styles.bodyMedium.copyWith(
                    color: Colors.white.withOpacity(0.9),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          const SizedBox(height: AppSizes.paddingLarge),

          Text(
            'Tính năng Premium',
            style: context.styles.headlineSmall.copyWith(
              color: context.colors.text,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppSizes.paddingMedium),

          // Premium Features
          ...premiumFeatures.map((feature) => AnimatedCard(
                margin: const EdgeInsets.only(bottom: AppSizes.paddingMedium),
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
                        feature,
                        style: context.styles.bodyMedium.copyWith(
                          color: context.colors.text,
                        ),
                      ),
                    ),
                  ],
                ),
              )),

          const SizedBox(height: AppSizes.paddingXLarge),

          // Upgrade Button
          CustomButton(
            text: 'Nâng cấp Premium',
            onPressed: () {
              // TODO: Navigate to premium upgrade
            },
            useGradient: true,
            gradient: context.colors.primaryGradient,
          ),
        ],
      ),
    );
  }

  IconData _getQrTypeIcon(String qrType) {
    switch (qrType) {
      case 'URL':
        return Icons.link;
      case 'Text':
        return Icons.text_fields;
      case 'WiFi':
        return Icons.wifi;
      case 'Email':
        return Icons.email;
      case 'Phone':
        return Icons.phone;
      case 'SMS':
        return Icons.sms;
      case 'VCard':
        return Icons.contact_phone;
      case 'GeoLocation':
        return Icons.location_on;
      case 'Calendar':
        return Icons.calendar_today;
      case 'Social Media':
        return Icons.share;
      case 'Payment':
        return Icons.payment;
      case 'App Store':
        return Icons.shop;
      default:
        return Icons.qr_code;
    }
  }

  Color _getQrTypeColor(String qrType) {
    switch (qrType) {
      case 'URL':
        return context.colors.primary;
      case 'Text':
        return context.colors.secondary;
      case 'WiFi':
        return context.colors.accent;
      case 'Email':
        return context.colors.success;
      case 'Phone':
        return context.colors.warning;
      case 'SMS':
        return context.colors.error;
      case 'VCard':
        return context.colors.primary;
      case 'GeoLocation':
        return context.colors.secondary;
      case 'Calendar':
        return context.colors.accent;
      case 'Social Media':
        return context.colors.success;
      case 'Payment':
        return context.colors.warning;
      case 'App Store':
        return context.colors.error;
      default:
        return context.colors.primary;
    }
  }

  void _showQrForm(String qrType) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => QrFormContainer(
        qrType: qrType,
        onQrCreated: (qrData) {
          // TODO: Handle QR creation
          Navigator.pop(context);
        },
      ),
    );
  }
}
