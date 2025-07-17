import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:internal_core/internal_core.dart';

import '../../constants/constants.dart';
import '../../utils/app_prefs.dart';
import '../premium/premium_screen.dart';
import '../widgets/premium_banner.dart';
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
  late AnimationController _mainController;
  late AnimationController _staggerController;
  late Animation<double> _mainAnimation;
  late Animation<double> _staggerAnimation;
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
    _tabController.dispose();
    _mainController.dispose();
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
          child: SafeArea(
            top: false,
            child: Column(
              children: [
                // Hero App Bar
                _buildHeroAppBar(),

                // Tab Bar
                _buildTabBar(),

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
        floatingActionButton: _buildFloatingActionButton(),
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
              left: 32,
              right: 20,
              bottom: 20),
          decoration: BoxDecoration(
            gradient: context.colors.primaryGradient,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            boxShadow: [
              BoxShadow(
                color: context.colors.primary.withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                children: [
                  // Title
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Quản lý QR Code',
                          style: context.styles.headlineSmall.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Quản lý và theo dõi QR Code của bạn',
                          style: context.styles.bodyMedium.copyWith(
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Search Button
                  GestureDetector(
                    onTap: _showSearch,
                    child: Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: const Icon(
                        Icons.search,
                        color: Colors.white,
                        size: 22,
                      ),
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

  Widget _buildTabBar() {
    return FadeTransition(
      opacity: _mainAnimation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.3),
          end: Offset.zero,
        ).animate(_mainAnimation),
        child: Container(
          margin: const EdgeInsets.all(20),
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
          child: TabBar(
            controller: _tabController,
            dividerColor: Colors.transparent,
            indicator: BoxDecoration(
              gradient: context.colors.primaryGradient,
              borderRadius: BorderRadius.circular(20),
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
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return FadeTransition(
      opacity: _mainAnimation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.5),
          end: Offset.zero,
        ).animate(_mainAnimation),
        child: Container(
          decoration: BoxDecoration(
            gradient: context.colors.primaryGradient,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: context.colors.primary.withOpacity(0.4),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: FloatingActionButton(
            onPressed: _createNewQr,
            backgroundColor: Colors.transparent,
            elevation: 0,
            child: const Icon(
              Icons.add,
              color: Colors.white,
              size: 28,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNormalQrTab() {
    return FadeTransition(
      opacity: _staggerAnimation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.2),
          end: Offset.zero,
        ).animate(_staggerAnimation),
        child: CustomScrollView(
          slivers: [
            // Stats Section
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
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
                    Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            gradient: context.colors.primaryGradient,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Icon(
                            Icons.qr_code,
                            color: Colors.white,
                            size: 25,
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'QR Code Thường',
                                style: context.styles.titleLarge.copyWith(
                                  color: context.colors.text,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Quản lý QR Code tĩnh',
                                style: context.styles.bodyMedium.copyWith(
                                  color: context.colors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: _buildStatItem(
                            'Tổng cộng',
                            _normalQrCodes.length.toString(),
                            Icons.qr_code,
                            context.colors.primary,
                          ),
                        ),
                        Expanded(
                          child: _buildStatItem(
                            'Yêu thích',
                            _normalQrCodes
                                .where((qr) => qr['isFavorite'])
                                .length
                                .toString(),
                            Icons.favorite,
                            context.colors.error,
                          ),
                        ),
                        Expanded(
                          child: _buildStatItem(
                            'Gần đây',
                            _normalQrCodes
                                .where((qr) => qr['createdAt'].isAfter(
                                    DateTime.now()
                                        .subtract(const Duration(days: 7))))
                                .length
                                .toString(),
                            Icons.access_time,
                            context.colors.accent,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // QR Code List
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: _normalQrCodes.isEmpty
                  ? SliverToBoxAdapter(child: _buildEmptyState('QR Thường'))
                  : SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: _buildQrCard(_normalQrCodes[index], false),
                        ),
                        childCount: _normalQrCodes.length,
                      ),
                    ),
            ),

            // Bottom spacing
            const SliverToBoxAdapter(
              child: SizedBox(height: 100),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDynamicQrTab() {
    return FadeTransition(
      opacity: _staggerAnimation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.2),
          end: Offset.zero,
        ).animate(_staggerAnimation),
        child: CustomScrollView(
          slivers: [
            // Stats Section
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
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
                    Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            gradient: context.colors.accentGradient,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Icon(
                            Icons.workspace_premium_rounded,
                            color: Colors.white,
                            size: 25,
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'QR Code Động',
                                style: context.styles.titleLarge.copyWith(
                                  color: context.colors.text,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Quản lý QR Code động với thống kê',
                                style: context.styles.bodyMedium.copyWith(
                                  color: context.colors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: _buildStatItem(
                            'Tổng cộng',
                            _dynamicQrCodes.length.toString(),
                            Icons.qr_code,
                            context.colors.accent,
                          ),
                        ),
                        Expanded(
                          child: _buildStatItem(
                            'Yêu thích',
                            _dynamicQrCodes
                                .where((qr) => qr['isFavorite'])
                                .length
                                .toString(),
                            Icons.favorite,
                            context.colors.error,
                          ),
                        ),
                        Expanded(
                          child: _buildStatItem(
                            'Lượt quét',
                            _dynamicQrCodes
                                .fold(
                                    0,
                                    (sum, qr) =>
                                        (sum + (qr['scans'] ?? 0)).toInt())
                                .toString(),
                            Icons.visibility,
                            context.colors.secondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Premium Banner or QR List
            SliverToBoxAdapter(
              child: _dynamicQrCodes.isEmpty
                  ? _buildPremiumBanner()
                  : Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: _dynamicQrCodes
                            .map((qr) => Padding(
                                  padding: const EdgeInsets.only(bottom: 15),
                                  child: _buildQrCard(qr, true),
                                ))
                            .toList(),
                      ),
                    ),
            ),

            // Bottom spacing
            const SliverToBoxAdapter(
              child: SizedBox(height: 100),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(
      String title, String value, IconData icon, Color color) {
    return Column(
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
        const SizedBox(height: 8),
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

  Widget _buildQrCard(Map<String, dynamic> qr, bool isDynamic) {
    return Container(
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
      child: ListTile(
        contentPadding: const EdgeInsets.all(20),
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            gradient: _getQrTypeGradient(qr['type']),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Icon(
            _getQrTypeIcon(qr['type']),
            color: Colors.white,
            size: 24,
          ),
        ),
        title: Text(
          qr['title'],
          style: context.styles.titleMedium.copyWith(
            color: context.colors.text,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              qr['content'],
              style: context.styles.bodySmall.copyWith(
                color: context.colors.textSecondary,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            if (isDynamic && qr['scans'] != null)
              Text(
                '${qr['scans']} lượt quét',
                style: context.styles.bodySmall.copyWith(
                  color: context.colors.accent,
                  fontWeight: FontWeight.w600,
                ),
              ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (qr['isFavorite'] == true)
              Icon(
                Icons.favorite,
                color: context.colors.error,
                size: 20,
              ),
            const SizedBox(width: 10),
            Icon(
              Icons.arrow_forward_ios,
              color: context.colors.textSecondary,
              size: 16,
            ),
          ],
        ),
        onTap: () => _viewQrDetails(qr),
      ),
    );
  }

  Widget _buildPremiumBanner() {
    return PremiumBanner(
      title: 'QR Code Động',
      subtitle: 'Tạo QR Code động với thống kê chi tiết',
      buttonText: 'Nâng cấp Premium',
    );
  }

  Widget _buildEmptyState(String type) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              gradient: context.colors.primaryGradient,
              borderRadius: BorderRadius.circular(25),
            ),
            child: const Icon(
              Icons.qr_code,
              color: Colors.white,
              size: 40,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Chưa có QR Code $type nào',
            style: context.styles.headlineSmall.copyWith(
              color: context.colors.text,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            'Tạo QR Code đầu tiên của bạn ngay bây giờ!',
            style: context.styles.bodyMedium.copyWith(
              color: context.colors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 25),
          Container(
            decoration: BoxDecoration(
              gradient: context.colors.primaryGradient,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: context.colors.primary.withOpacity(0.3),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(15),
                onTap: _createNewQr,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                  child: Text(
                    'Tạo QR Code',
                    style: context.styles.labelLarge.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  LinearGradient _getQrTypeGradient(String type) {
    switch (type) {
      case 'URL':
        return context.colors.primaryGradient;
      case 'WiFi':
        return context.colors.accentGradient;
      case 'Text':
        return context.colors.primaryGradient;
      case 'Dynamic':
        return context.colors.accentGradient;
      default:
        return context.colors.primaryGradient;
    }
  }

  IconData _getQrTypeIcon(String type) {
    switch (type) {
      case 'URL':
        return Icons.link;
      case 'WiFi':
        return Icons.wifi;
      case 'Text':
        return Icons.text_fields;
      case 'Dynamic':
        return Icons.workspace_premium_rounded;
      default:
        return Icons.qr_code;
    }
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
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const PremiumScreen(),
      ),
    );
  }
}
