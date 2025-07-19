import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_sizes.dart';
import '../../widgets/widget_page_shimmer.dart';

/// Shimmer cho trang profile
class ProfileShimmer extends StatelessWidget {
  const ProfileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return PageShimmer(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(AppSizes.paddingMedium),
        child: Column(
          children: [
            _buildProfileHeaderShimmer(),
            SizedBox(height: AppSizes.paddingLarge),
            _buildProfileStatsShimmer(),
            SizedBox(height: AppSizes.paddingLarge),
            _buildSettingsListShimmer(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeaderShimmer() {
    return Column(
      children: [
        // Avatar
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        SizedBox(height: AppSizes.paddingMedium),
        // Name
        Container(
          width: 150,
          height: 24,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
          ),
        ),
        SizedBox(height: AppSizes.paddingSmall),
        // Email
        Container(
          width: 200,
          height: 16,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.7),
            borderRadius: BorderRadius.circular(AppSizes.radiusTiny),
          ),
        ),
        SizedBox(height: AppSizes.paddingMedium),
        // Edit button
        Container(
          width: 120,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.5),
            borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
          ),
        ),
      ],
    );
  }

  Widget _buildProfileStatsShimmer() {
    return Row(
      children: [
        Expanded(
          child: _buildStatItemShimmer(),
        ),
        SizedBox(width: AppSizes.paddingMedium),
        Expanded(
          child: _buildStatItemShimmer(),
        ),
        SizedBox(width: AppSizes.paddingMedium),
        Expanded(
          child: _buildStatItemShimmer(),
        ),
      ],
    );
  }

  Widget _buildStatItemShimmer() {
    return Column(
      children: [
        Container(
          width: 40,
          height: 24,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
          ),
        ),
        SizedBox(height: AppSizes.paddingSmall),
        Container(
          width: 60,
          height: 16,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.7),
            borderRadius: BorderRadius.circular(AppSizes.radiusTiny),
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsListShimmer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section title
        Container(
          width: 100,
          height: 20,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppSizes.radiusTiny),
          ),
        ),
        SizedBox(height: AppSizes.paddingMedium),
        // Settings items
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 6,
          itemBuilder: (context, index) => _buildSettingItemShimmer(),
        ),
      ],
    );
  }

  Widget _buildSettingItemShimmer() {
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
            // Icon
            Container(
              width: 40,
              height: 40,
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
                  Container(
                    width: double.infinity,
                    height: 16,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(AppSizes.radiusTiny),
                    ),
                  ),
                  SizedBox(height: AppSizes.paddingSmall),
                  Container(
                    width: 120,
                    height: 12,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(AppSizes.radiusTiny),
                    ),
                  ),
                ],
              ),
            ),
            // Arrow
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
      ),
    );
  }
}

/// Shimmer cho profile header
class ProfileHeaderShimmer extends StatelessWidget {
  const ProfileHeaderShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return PageShimmer(
      child: Container(
        padding: EdgeInsets.all(AppSizes.paddingLarge),
        child: Column(
          children: [
            // Avatar
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40),
              ),
            ),
            SizedBox(height: AppSizes.paddingMedium),
            // Name
            Container(
              width: 120,
              height: 20,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
              ),
            ),
            SizedBox(height: AppSizes.paddingSmall),
            // Email
            Container(
              width: 150,
              height: 14,
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
}

/// Shimmer cho setting item
class SettingItemShimmer extends StatelessWidget {
  final bool showSubtitle;
  final bool showTrailing;

  const SettingItemShimmer({
    super.key,
    this.showSubtitle = true,
    this.showTrailing = true,
  });

  @override
  Widget build(BuildContext context) {
    return PageShimmer(
      child: Container(
        padding: EdgeInsets.all(AppSizes.paddingMedium),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
        ),
        child: Row(
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
            SizedBox(width: AppSizes.paddingMedium),
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 16,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(AppSizes.radiusTiny),
                    ),
                  ),
                  if (showSubtitle) ...[
                    SizedBox(height: AppSizes.paddingSmall),
                    Container(
                      width: 100,
                      height: 12,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        borderRadius:
                            BorderRadius.circular(AppSizes.radiusTiny),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (showTrailing) ...[
              SizedBox(width: AppSizes.paddingMedium),
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Shimmer cho premium banner
class PremiumBannerShimmer extends StatelessWidget {
  const PremiumBannerShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return PageShimmer(
      child: Container(
        padding: EdgeInsets.all(AppSizes.paddingLarge),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
        ),
        child: Column(
          children: [
            // Icon
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7),
                borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
              ),
            ),
            SizedBox(height: AppSizes.paddingMedium),
            // Title
            Container(
              width: 150,
              height: 20,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7),
                borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
              ),
            ),
            SizedBox(height: AppSizes.paddingSmall),
            // Description
            Container(
              width: double.infinity,
              height: 14,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.5),
                borderRadius: BorderRadius.circular(AppSizes.radiusTiny),
              ),
            ),
            SizedBox(height: AppSizes.paddingMedium),
            // Button
            Container(
              width: 120,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.5),
                borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
