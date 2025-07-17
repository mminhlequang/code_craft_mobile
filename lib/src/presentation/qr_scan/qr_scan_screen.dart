import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:internal_core/internal_core.dart';

import '../../constants/constants.dart';
import '../../utils/app_prefs.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_button.dart';
import 'widgets/camera_view.dart';
import 'widgets/scan_result_dialog.dart';

class QrScanScreen extends StatefulWidget {
  const QrScanScreen({super.key});

  @override
  State<QrScanScreen> createState() => _QrScanScreenState();
}

class _QrScanScreenState extends State<QrScanScreen>
    with TickerProviderStateMixin {
  late AnimationController _scanAnimationController;
  late Animation<double> _scanAnimation;
  late AnimationController _cornerAnimationController;
  late Animation<double> _cornerAnimation;
  bool _isScanning = false;
  String? _lastScannedData;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _scanAnimationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _scanAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _scanAnimationController,
      curve: Curves.easeInOut,
    ));

    _cornerAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _cornerAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _cornerAnimationController,
      curve: Curves.easeInOut,
    ));

    _scanAnimationController.repeat();
    _cornerAnimationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _scanAnimationController.dispose();
    _cornerAnimationController.dispose();
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
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Stack(
            children: [
              // Camera View
              CameraView(
                onQrDetected: _handleQrDetected,
                onCameraError: _handleCameraError,
              ),

              // Top Bar
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(AppSizes.paddingLarge),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.7),
                        Colors.transparent,
                      ],
                    ),
                  ),
                  child: Row(
                    children: [
                      AnimatedContainer(
                        duration: AppStyles.instance.animationFast,
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius:
                                BorderRadius.circular(AppSizes.radiusMedium),
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              padding:
                                  const EdgeInsets.all(AppSizes.paddingSmall),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(
                                    AppSizes.radiusMedium),
                              ),
                              child: const Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                                size: 28,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Quét QR Code',
                          style: context.styles.headlineSmall.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      AnimatedContainer(
                        duration: AppStyles.instance.animationFast,
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius:
                                BorderRadius.circular(AppSizes.radiusMedium),
                            onTap: _toggleFlash,
                            child: Container(
                              padding:
                                  const EdgeInsets.all(AppSizes.paddingSmall),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(
                                    AppSizes.radiusMedium),
                              ),
                              child: Icon(
                                _isFlashOn ? Icons.flash_on : Icons.flash_off,
                                color: Colors.white,
                                size: 28,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Scan Frame
              Center(
                child: AnimatedBuilder(
                  animation: _cornerAnimation,
                  builder: (context, child) {
                    return Container(
                      width: 250,
                      height: 250,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: context.colors.primary
                              .withOpacity(0.8 + _cornerAnimation.value * 0.2),
                          width: 2,
                        ),
                        borderRadius:
                            BorderRadius.circular(AppSizes.radiusMedium),
                      ),
                      child: Stack(
                        children: [
                          // Corner indicators
                          Positioned(
                            top: 0,
                            left: 0,
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                color: context.colors.primary,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(4),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                color: context.colors.primary,
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(4),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                color: context.colors.primary,
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(4),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                color: context.colors.primary,
                                borderRadius: const BorderRadius.only(
                                  bottomRight: Radius.circular(4),
                                ),
                              ),
                            ),
                          ),

                          // Scanning line
                          if (_isScanning)
                            Positioned(
                              top: 0,
                              left: 0,
                              right: 0,
                              child: AnimatedBuilder(
                                animation: _scanAnimation,
                                builder: (context, child) {
                                  return Transform.translate(
                                    offset: Offset(
                                      0,
                                      _scanAnimation.value * 250,
                                    ),
                                    child: Container(
                                      height: 2,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.transparent,
                                            context.colors.primary,
                                            Colors.transparent,
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              // Bottom Instructions
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(AppSizes.paddingLarge),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.7),
                      ],
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Đặt QR Code vào khung hình',
                        style: context.styles.bodyLarge.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: AppSizes.paddingMedium),
                      Text(
                        'QR Code sẽ được quét tự động',
                        style: context.styles.bodyMedium.copyWith(
                          color: Colors.white.withOpacity(0.8),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: AppSizes.paddingLarge),

                      // Action Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildActionButton(
                            icon: Icons.photo_library,
                            label: 'Thư viện',
                            onTap: _pickFromGallery,
                          ),
                          _buildActionButton(
                            icon: Icons.history,
                            label: 'Lịch sử',
                            onTap: _showHistory,
                          ),
                          _buildActionButton(
                            icon: Icons.settings,
                            label: 'Cài đặt',
                            onTap: _showSettings,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: AppStyles.instance.animationFast,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(AppSizes.paddingMedium),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: AppSizes.iconMedium,
              ),
            ),
            const SizedBox(height: AppSizes.paddingSmall),
            Text(
              label,
              style: context.styles.labelSmall.copyWith(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleQrDetected(String data) {
    if (data != _lastScannedData) {
      _lastScannedData = data;
      setState(() {
        _isScanning = false;
      });

      _scanAnimationController.stop();

      // Show result dialog
      showDialog(
        context: context,
        builder: (context) => ScanResultDialog(
          qrData: data,
          onAction: _handleQrAction,
        ),
      );
    }
  }

  void _handleQrAction(String action, String data) {
    switch (action) {
      case 'copy':
        Clipboard.setData(ClipboardData(text: data));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Đã sao chép vào clipboard'),
            backgroundColor: context.colors.success,
          ),
        );
        break;
      case 'share':
        // TODO: Implement share functionality
        break;
      case 'open':
        // TODO: Implement open URL functionality
        break;
      case 'save':
        // TODO: Implement save to history
        break;
    }
  }

  void _handleCameraError(String error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Lỗi camera: $error'),
        backgroundColor: context.colors.error,
      ),
    );
  }

  void _toggleFlash() {
    // TODO: Implement flash toggle
    setState(() {
      _isFlashOn = !_isFlashOn;
    });
  }

  void _pickFromGallery() {
    // TODO: Implement gallery picker
  }

  void _showHistory() {
    // TODO: Navigate to scan history
  }

  void _showSettings() {
    // TODO: Show camera settings
  }

  bool _isFlashOn = false;
}
