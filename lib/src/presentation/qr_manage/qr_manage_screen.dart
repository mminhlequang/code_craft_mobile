import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:internal_core/internal_core.dart';

import '../../constants/constants.dart';
import '../../utils/app_prefs.dart';
import 'widgets/qr_item_card.dart';
import 'widgets/qr_stats_card.dart';

class QrManageScreen extends StatefulWidget {
  const QrManageScreen({super.key});

  @override
  State<QrManageScreen> createState() => _QrManageScreenState();
}

class _QrManageScreenState extends State<QrManageScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  int _currentTabIndex = 0;

  // Mock data for demonstration
  final List<Map<String, dynamic>> _normalQrCodes = [
    {
      'id': '1',
      'type': 'URL',
      'title': 'Website chính',
      'content': 'https://codecraft.com',
      'createdAt': DateTime.now().subtract(const Duration(days: 2)),
      'isFavorite': true,
    },
    {
      'id': '2',
      'type': 'WiFi',
      'title': 'WiFi nhà',
      'content': 'SSID: HomeWiFi, Password: 12345678',
      'createdAt': DateTime.now().subtract(const Duration(days: 5)),
      'isFavorite': false,
    },
    {
      'id': '3',
      'type': 'Text',
      'title': 'Ghi chú',
      'content': 'Đây là ghi chú quan trọng cần nhớ',
      'createdAt': DateTime.now().subtract(const Duration(days: 1)),
      'isFavorite': true,
    },
  ];

  final List<Map<String, dynamic>> _dynamicQrCodes = [
    {
      'id': 'd1',
      'type': 'Dynamic',
      'title': 'Menu nhà hàng',
      'content': 'codecraft.com/qr/d1',
      'createdAt': DateTime.now().subtract(const Duration(days: 3)),
      'scans': 156,
      'countries': ['VN', 'US', 'JP'],
      'devices': ['iOS', 'Android', 'Web'],
      'isFavorite': true,
    },
    {
      'id': 'd2',
      'type': 'Dynamic',
      'title': 'Thông tin sản phẩm',
      'content': 'codecraft.com/qr/d2',
      'createdAt': DateTime.now().subtract(const Duration(days: 7)),
      'scans': 89,
      'countries': ['VN', 'SG'],
      'devices': ['iOS', 'Android'],
      'isFavorite': false,
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _currentTabIndex = _tabController.index;
      });
    });
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
              Container(
                padding: const EdgeInsets.all(AppSizes.paddingLarge),
                decoration: BoxDecoration(
                  gradient: context.colors.primaryGradient,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon:
                              const Icon(Icons.arrow_back, color: Colors.white),
                        ),
                        Expanded(
                          child: Text(
                            'Quản lý QR Code',
                            style: context.styles.headlineMedium.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        IconButton(
                          onPressed: _showSearch,
                          icon: const Icon(Icons.search, color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSizes.paddingMedium),
                    // Tab Bar
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius:
                            BorderRadius.circular(AppSizes.radiusMedium),
                      ),
                      child: TabBar(
                        controller: _tabController,
                        indicator: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.circular(AppSizes.radiusMedium),
                        ),
                        indicatorSize: TabBarIndicatorSize.tab,
                        labelColor: context.colors.primary,
                        unselectedLabelColor: Colors.white,
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
        floatingActionButton: FloatingActionButton(
          onPressed: _createNewQr,
          backgroundColor: context.colors.primary,
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildNormalQrTab() {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.all(AppSizes.paddingLarge),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              // Stats Card
              QrStatsCard(
                title: 'QR Code Thường',
                totalCount: _normalQrCodes.length,
                favoriteCount:
                    _normalQrCodes.where((qr) => qr['isFavorite']).length,
                recentCount: _normalQrCodes
                    .where((qr) => qr['createdAt'].isAfter(
                        DateTime.now().subtract(const Duration(days: 7))))
                    .length,
              ),

              const SizedBox(height: AppSizes.paddingLarge),

              // QR Code List
              if (_normalQrCodes.isEmpty)
                _buildEmptyState('QR Thường')
              else
                ..._normalQrCodes.map((qr) => Padding(
                      padding:
                          const EdgeInsets.only(bottom: AppSizes.paddingMedium),
                      child: QrItemCard(
                        qrData: qr,
                        isDynamic: false,
                        onTap: () => _viewQrDetails(qr),
                        onEdit: () => _editQr(qr),
                        onDelete: () => _deleteQr(qr),
                        onToggleFavorite: () => _toggleFavorite(qr),
                        onShare: () => _shareQr(qr),
                      ),
                    )),
            ]),
          ),
        ),
      ],
    );
  }

  Widget _buildDynamicQrTab() {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.all(AppSizes.paddingLarge),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              // Stats Card
              QrStatsCard(
                title: 'QR Code Động',
                totalCount: _dynamicQrCodes.length,
                favoriteCount:
                    _dynamicQrCodes.where((qr) => qr['isFavorite']).length,
                totalScans: _dynamicQrCodes.fold(
                    0, (sum, qr) => sum! + (qr['scans'] ?? 0) as int),
                isDynamic: true,
              ),

              const SizedBox(height: AppSizes.paddingLarge),

              // Premium Banner
              if (_dynamicQrCodes.isEmpty)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(AppSizes.paddingLarge),
                  decoration: context.styles.accentGradientDecoration,
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
                        'Tạo QR Code động với thống kê chi tiết',
                        style: context.styles.bodyMedium.copyWith(
                          color: Colors.white.withOpacity(0.9),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: AppSizes.paddingLarge),
                      ElevatedButton(
                        onPressed: _upgradeToPremium,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: context.colors.primary,
                        ),
                        child: Text(
                          'Nâng cấp Premium',
                          style: context.styles.labelLarge.copyWith(
                            color: context.colors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              else
                ..._dynamicQrCodes.map((qr) => Padding(
                      padding:
                          const EdgeInsets.only(bottom: AppSizes.paddingMedium),
                      child: QrItemCard(
                        qrData: qr,
                        isDynamic: true,
                        onTap: () => _viewQrDetails(qr),
                        onEdit: () => _editQr(qr),
                        onDelete: () => _deleteQr(qr),
                        onToggleFavorite: () => _toggleFavorite(qr),
                        onShare: () => _shareQr(qr),
                        onViewStats: () => _viewQrStats(qr),
                      ),
                    )),
            ]),
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState(String type) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.paddingXLarge),
      child: Column(
        children: [
          Icon(
            Icons.qr_code,
            size: 80,
            color: context.colors.textSecondary,
          ),
          const SizedBox(height: AppSizes.paddingLarge),
          Text(
            'Chưa có QR Code $type nào',
            style: context.styles.headlineSmall.copyWith(
              color: context.colors.textSecondary,
            ),
          ),
          const SizedBox(height: AppSizes.paddingMedium),
          Text(
            'Tạo QR Code đầu tiên của bạn ngay bây giờ!',
            style: context.styles.bodyMedium.copyWith(
              color: context.colors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSizes.paddingLarge),
          ElevatedButton(
            onPressed: _createNewQr,
            style: ElevatedButton.styleFrom(
              backgroundColor: context.colors.primary,
              foregroundColor: Colors.white,
            ),
            child: Text(
              'Tạo QR Code',
              style: context.styles.labelLarge.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showSearch() {
    // TODO: Implement search functionality
  }

  void _createNewQr() {
    // TODO: Navigate to QR creation screen
  }

  void _viewQrDetails(Map<String, dynamic> qr) {
    // TODO: Show QR details
  }

  void _editQr(Map<String, dynamic> qr) {
    // TODO: Edit QR code
  }

  void _deleteQr(Map<String, dynamic> qr) {
    // TODO: Delete QR code
  }

  void _toggleFavorite(Map<String, dynamic> qr) {
    setState(() {
      qr['isFavorite'] = !(qr['isFavorite'] ?? false);
    });
  }

  void _shareQr(Map<String, dynamic> qr) {
    // TODO: Share QR code
  }

  void _viewQrStats(Map<String, dynamic> qr) {
    // TODO: Show QR statistics
  }

  void _upgradeToPremium() {
    // TODO: Navigate to premium upgrade
  }
}
