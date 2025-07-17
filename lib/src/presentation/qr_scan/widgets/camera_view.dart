import 'package:flutter/material.dart';
import 'package:internal_core/internal_core.dart';

import '../../../constants/constants.dart';

class CameraView extends StatefulWidget {
  final Function(String) onQrDetected;
  final Function(String) onCameraError;

  const CameraView({
    super.key,
    required this.onQrDetected,
    required this.onCameraError,
  });

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  @override
  Widget build(BuildContext context) {
    // TODO: Implement actual camera functionality
    // For now, return a placeholder with simulated QR detection
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.black,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.camera_alt,
              size: 80,
              color: Colors.white.withOpacity(0.5),
            ),
            const SizedBox(height: AppSizes.paddingLarge),
            Text(
              'Camera View',
              style: context.styles.headlineMedium.copyWith(
                color: Colors.white.withOpacity(0.5),
              ),
            ),
            const SizedBox(height: AppSizes.paddingLarge),
            Text(
              'Camera functionality will be implemented here',
              style: context.styles.bodyMedium.copyWith(
                color: Colors.white.withOpacity(0.3),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSizes.paddingXLarge),

            // Simulated QR detection button for testing
            ElevatedButton(
              onPressed: () {
                // Simulate QR detection
                widget.onQrDetected('https://example.com/test-qr-code');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: context.colors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.paddingLarge,
                  vertical: AppSizes.paddingMedium,
                ),
              ),
              child: Text(
                'Simulate QR Detection',
                style: context.styles.labelLarge.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
