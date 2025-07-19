import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_sizes.dart';
import '../../widgets/widget_page_shimmer.dart';

/// Shimmer cho trang quản lý QR code
class QRManageShimmer extends StatelessWidget {
  const QRManageShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return PageShimmer(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(AppSizes.paddingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderShimmer(),
            SizedBox(height: AppSizes.paddingLarge),
            _buildStatsShimmer(),
            SizedBox(height: AppSizes.paddingLarge),
            _buildSearchBarShimmer(),
            SizedBox(height: AppSizes.paddingLarge),
            _buildQRListShimmer(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderShimmer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Container(
          width: 200,
          height: 32,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
          ),
        ),
        SizedBox(height: AppSizes.paddingSmall),
        // Subtitle
        Container(
          width: 150,
          height: 16,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppSizes.radiusTiny),
          ),
        ),
      ],
    );
  }

  Widget _buildStatsShimmer() {
    return Row(
      children: [
        Expanded(
          child: _buildStatCardShimmer(),
        ),
        SizedBox(width: AppSizes.paddingMedium),
        Expanded(
          child: _buildStatCardShimmer(),
        ),
        SizedBox(width: AppSizes.paddingMedium),
        Expanded(
          child: _buildStatCardShimmer(),
        ),
      ],
    );
  }

  Widget _buildStatCardShimmer() {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
      ),
      child: Padding(
        padding: EdgeInsets.all(AppSizes.paddingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 16,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7),
                borderRadius: BorderRadius.circular(AppSizes.radiusTiny),
              ),
            ),
            SizedBox(height: AppSizes.paddingSmall),
            Container(
              width: 60,
              height: 20,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7),
                borderRadius: BorderRadius.circular(AppSizes.radiusTiny),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBarShimmer() {
    return Container(
      height: AppSizes.inputHeightMedium,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
      ),
    );
  }

  Widget _buildQRListShimmer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section title
        Container(
          width: 120,
          height: 20,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppSizes.radiusTiny),
          ),
        ),
        SizedBox(height: AppSizes.paddingMedium),
        // QR items
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 5,
          itemBuilder: (context, index) => _buildQRItemShimmer(),
        ),
      ],
    );
  }

  Widget _buildQRItemShimmer() {
    return Container(
      margin: EdgeInsets.only(bottom: AppSizes.paddingMedium),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
      ),
      child: Padding(
        padding: EdgeInsets.all(AppSizes.paddingMedium),
        child: Row(
          children: [
            // QR Code image shimmer
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7),
                borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
              ),
            ),
            SizedBox(width: AppSizes.paddingMedium),
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Container(
                    width: double.infinity,
                    height: 16,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(AppSizes.radiusTiny),
                    ),
                  ),
                  SizedBox(height: AppSizes.paddingSmall),
                  // Subtitle
                  Container(
                    width: 120,
                    height: 12,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(AppSizes.radiusTiny),
                    ),
                  ),
                  SizedBox(height: AppSizes.paddingSmall),
                  // Date
                  Container(
                    width: 80,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(AppSizes.radiusTiny),
                    ),
                  ),
                ],
              ),
            ),
            // Actions
            Column(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
                  ),
                ),
                SizedBox(height: AppSizes.paddingSmall),
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Shimmer cho QR item card
class QRItemCardShimmer extends StatelessWidget {
  final double? width;
  final double? height;

  const QRItemCardShimmer({
    super.key,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return PageShimmer(
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
        ),
        child: Padding(
          padding: EdgeInsets.all(AppSizes.paddingMedium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // QR Code image
              Center(
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
                  ),
                ),
              ),
              SizedBox(height: AppSizes.paddingMedium),
              // Title
              Container(
                width: double.infinity,
                height: 16,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(AppSizes.radiusTiny),
                ),
              ),
              SizedBox(height: AppSizes.paddingSmall),
              // Subtitle
              Container(
                width: 100,
                height: 12,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(AppSizes.radiusTiny),
                ),
              ),
              SizedBox(height: AppSizes.paddingMedium),
              // Actions
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
                    ),
                  ),
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
                    ),
                  ),
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
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
}

/// Shimmer cho QR stats card
class QRStatsCardShimmer extends StatelessWidget {
  final double? width;
  final double? height;

  const QRStatsCardShimmer({
    super.key,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return PageShimmer(
      child: Container(
        width: width,
        height: height ?? 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
        ),
        child: Padding(
          padding: EdgeInsets.all(AppSizes.paddingMedium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
                ),
              ),
              SizedBox(height: AppSizes.paddingMedium),
              // Title
              Container(
                width: 80,
                height: 14,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(AppSizes.radiusTiny),
                ),
              ),
              SizedBox(height: AppSizes.paddingSmall),
              // Value
              Container(
                width: 60,
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(AppSizes.radiusTiny),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
