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
  late AnimationController _mainController;
  late AnimationController _scanAnimationController;
  late AnimationController _cornerAnimationController;
  late AnimationController _pulseController;
  late Animation<double> _mainAnimation;
  late Animation<double> _scanAnimation;
  late Animation<double> _cornerAnimation;
  late Animation<double> _pulseAnimation;
  bool _isScanning = false;
  String? _lastScannedData;
  bool _isFlashOn = false;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _mainController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _mainAnimation = CurvedAnimation(
      parent: _mainController,
      curve: Curves.easeOutBack,
    );

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

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _pulseAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    _mainController.forward();
    _scanAnimationController.repeat();
    _cornerAnimationController.repeat(reverse: true);
    _pulseController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _mainController.dispose();
    _scanAnimationController.dispose();
    _cornerAnimationController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.black,
        systemNavigationBarIconBrightness: Brightness.light,
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

              // Hero App Bar
              _buildHeroAppBar(),

              // Scan Frame
              _buildScanFrame(),

              // Bottom Instructions
              _buildBottomInstructions(),
            ],
          ),
        ),
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
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.8),
                Colors.transparent,
              ],
            ),
          ),
          child: Row(
            children: [
              // Back Button
              // GestureDetector(
              //   onTap: () => Navigator.pop(context),
              //   child: Container(
              //     width: 45,
              //     height: 45,
              //     decoration: BoxDecoration(
              //       color: Colors.white.withOpacity(0.2),
              //       borderRadius: BorderRadius.circular(15),
              //       border: Border.all(
              //         color: Colors.white.withOpacity(0.3),
              //         width: 1,
              //       ),
              //     ),
              //     child: const Icon(
              //       Icons.arrow_back_ios_new,
              //       color: Colors.white,
              //       size: 20,
              //     ),
              //   ),
              // ),

              SizedBox(
                width: 45,
                height: 45,
              ),

              const SizedBox(width: 15),

              // Title
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Quét QR Code',
                      style: context.styles.headlineSmall.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Đặt QR Code vào khung hình',
                      style: context.styles.bodyMedium.copyWith(
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
              ),

              // Flash Button
              GestureDetector(
                onTap: _toggleFlash,
                child: Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    color: _isFlashOn
                        ? context.colors.primary.withOpacity(0.8)
                        : Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Icon(
                    _isFlashOn ? Icons.flash_on : Icons.flash_off,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScanFrame() {
    return Center(
      child: AnimatedBuilder(
        animation: Listenable.merge([_cornerAnimation, _pulseAnimation]),
        builder: (context, child) {
          return Container(
            width: 280,
            height: 280,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: context.colors.primary
                      .withOpacity(0.3 * _pulseAnimation.value),
                  blurRadius: 30,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Stack(
              children: [
                // Main scan frame
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: context.colors.primary
                          .withOpacity(0.8 + _cornerAnimation.value * 0.2),
                      width: 3,
                    ),
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),

                // Corner indicators
                _buildCornerIndicator(Alignment.topLeft),
                _buildCornerIndicator(Alignment.topRight),
                _buildCornerIndicator(Alignment.bottomLeft),
                _buildCornerIndicator(Alignment.bottomRight),

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
                          offset: Offset(0, _scanAnimation.value * 280),
                          child: Container(
                            height: 3,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.transparent,
                                  context.colors.primary,
                                  Colors.transparent,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                // Center QR icon
                Center(
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Icon(
                      Icons.qr_code_scanner,
                      color: Colors.white.withOpacity(0.7),
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCornerIndicator(Alignment alignment) {
    return Positioned(
      top: alignment == Alignment.topLeft || alignment == Alignment.topRight
          ? 0
          : null,
      bottom: alignment == Alignment.bottomLeft ||
              alignment == Alignment.bottomRight
          ? 0
          : null,
      left: alignment == Alignment.topLeft || alignment == Alignment.bottomLeft
          ? 0
          : null,
      right:
          alignment == Alignment.topRight || alignment == Alignment.bottomRight
              ? 0
              : null,
      child: Container(
        width: 25,
        height: 25,
        decoration: BoxDecoration(
          color: context.colors.primary,
          borderRadius: BorderRadius.only(
            topLeft: alignment == Alignment.topLeft
                ? const Radius.circular(8)
                : Radius.zero,
            topRight: alignment == Alignment.topRight
                ? const Radius.circular(8)
                : Radius.zero,
            bottomLeft: alignment == Alignment.bottomLeft
                ? const Radius.circular(8)
                : Radius.zero,
            bottomRight: alignment == Alignment.bottomRight
                ? const Radius.circular(8)
                : Radius.zero,
          ),
        ),
      ),
    );
  }

  Widget _buildBottomInstructions() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: FadeTransition(
        opacity: _mainAnimation,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 0.5),
            end: Offset.zero,
          ).animate(_mainAnimation),
          child: Container(
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.8),
                ],
              ),
            ),
            child: Column(
              children: [
                // Instructions
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Đặt QR Code vào khung hình',
                        style: context.styles.bodyLarge.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'QR Code sẽ được quét tự động',
                        style: context.styles.bodyMedium.copyWith(
                          color: Colors.white.withOpacity(0.8),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

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
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Colors.white.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 24,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: context.styles.bodySmall.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w500,
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
}
