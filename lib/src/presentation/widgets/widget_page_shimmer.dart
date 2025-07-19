import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_sizes.dart';

/// Widget shimmer cho trang loading hoàn chỉnh
class PageShimmer extends StatelessWidget {
  final Widget? child;
  final bool enabled;
  final Duration duration;
  final Color? baseColor;
  final Color? highlightColor;

  const PageShimmer({
    super.key,
    this.child,
    this.enabled = true,
    this.duration = const Duration(milliseconds: 1500),
    this.baseColor,
    this.highlightColor,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Shimmer.fromColors(
          baseColor: baseColor ?? AppColors.instance.shimmerBaseColor,
          highlightColor:
              highlightColor ?? AppColors.instance.shimmerHighlightColor,
          period: duration,
          enabled: enabled,
          child: child ?? const _DefaultShimmerContent(),
        ),
      ),
    );
  }
}

/// Nội dung shimmer mặc định cho trang
class _DefaultShimmerContent extends StatelessWidget {
  const _DefaultShimmerContent();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(AppSizes.paddingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header shimmer
          _buildHeaderShimmer(),
          SizedBox(height: AppSizes.paddingLarge),

          // Search bar shimmer
          _buildSearchBarShimmer(),
          SizedBox(height: AppSizes.paddingLarge),

          // Cards shimmer
          _buildCardsShimmer(),
          SizedBox(height: AppSizes.paddingLarge),

          // List items shimmer
          _buildListItemsShimmer(),
        ],
      ),
    );
  }

  Widget _buildHeaderShimmer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title shimmer
        Container(
          width: 200,
          height: 32,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
          ),
        ),
        SizedBox(height: AppSizes.paddingSmall),
        // Subtitle shimmer
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

  Widget _buildSearchBarShimmer() {
    return Container(
      height: AppSizes.inputHeightMedium,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
      ),
    );
  }

  Widget _buildCardsShimmer() {
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
        // Cards grid
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: AppSizes.paddingMedium,
            mainAxisSpacing: AppSizes.paddingMedium,
            childAspectRatio: 1.2,
          ),
          itemCount: 4,
          itemBuilder: (context, index) => _buildCardShimmer(),
        ),
      ],
    );
  }

  Widget _buildCardShimmer() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
      ),
      child: Padding(
        padding: EdgeInsets.all(AppSizes.paddingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon shimmer
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7),
                borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
              ),
            ),
            SizedBox(height: AppSizes.paddingMedium),
            // Title shimmer
            Container(
              width: double.infinity,
              height: 16,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7),
                borderRadius: BorderRadius.circular(AppSizes.radiusTiny),
              ),
            ),
            SizedBox(height: AppSizes.paddingSmall),
            // Subtitle shimmer
            Container(
              width: 60,
              height: 12,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.5),
                borderRadius: BorderRadius.circular(AppSizes.radiusTiny),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListItemsShimmer() {
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
        // List items
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 5,
          itemBuilder: (context, index) => _buildListItemShimmer(),
        ),
      ],
    );
  }

  Widget _buildListItemShimmer() {
    return Padding(
      padding: EdgeInsets.only(bottom: AppSizes.paddingMedium),
      child: Row(
        children: [
          // Avatar shimmer
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
            ),
          ),
          SizedBox(width: AppSizes.paddingMedium),
          // Content shimmer
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 16,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(AppSizes.radiusTiny),
                  ),
                ),
                SizedBox(height: AppSizes.paddingSmall),
                Container(
                  width: 120,
                  height: 12,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(AppSizes.radiusTiny),
                  ),
                ),
              ],
            ),
          ),
          // Action shimmer
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
    );
  }
}

/// Shimmer cho app bar
class AppBarShimmer extends StatelessWidget {
  final double height;
  final EdgeInsetsGeometry? padding;

  const AppBarShimmer({
    super.key,
    this.height = 56.0,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding:
          padding ?? EdgeInsets.symmetric(horizontal: AppSizes.paddingMedium),
      child: Row(
        children: [
          // Back button shimmer
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
            ),
          ),
          SizedBox(width: AppSizes.paddingMedium),
          // Title shimmer
          Expanded(
            child: Container(
              height: 24,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
              ),
            ),
          ),
          SizedBox(width: AppSizes.paddingMedium),
          // Action button shimmer
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
            ),
          ),
        ],
      ),
    );
  }
}

/// Shimmer cho card
class CardShimmer extends StatelessWidget {
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;

  const CardShimmer({
    super.key,
    this.width,
    this.height,
    this.padding,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding ?? EdgeInsets.all(AppSizes.paddingMedium),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            borderRadius ?? BorderRadius.circular(AppSizes.radiusMedium),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header shimmer
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
                ),
              ),
              SizedBox(width: AppSizes.paddingMedium),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 16,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.7),
                        borderRadius:
                            BorderRadius.circular(AppSizes.radiusTiny),
                      ),
                    ),
                    SizedBox(height: AppSizes.paddingSmall),
                    Container(
                      width: 80,
                      height: 12,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        borderRadius:
                            BorderRadius.circular(AppSizes.radiusTiny),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: AppSizes.paddingMedium),
          // Content shimmer
          Container(
            width: double.infinity,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.7),
              borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
            ),
          ),
          SizedBox(height: AppSizes.paddingMedium),
          // Footer shimmer
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 60,
                height: 12,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(AppSizes.radiusTiny),
                ),
              ),
              Container(
                width: 40,
                height: 12,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(AppSizes.radiusTiny),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Shimmer cho list item
class ListItemShimmer extends StatelessWidget {
  final bool showAvatar;
  final bool showSubtitle;
  final bool showTrailing;

  const ListItemShimmer({
    super.key,
    this.showAvatar = true,
    this.showSubtitle = true,
    this.showTrailing = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.paddingMedium,
        vertical: AppSizes.paddingSmall,
      ),
      child: Row(
        children: [
          if (showAvatar) ...[
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
              ),
            ),
            SizedBox(width: AppSizes.paddingMedium),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 16,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(AppSizes.radiusTiny),
                  ),
                ),
                if (showSubtitle) ...[
                  SizedBox(height: AppSizes.paddingSmall),
                  Container(
                    width: 120,
                    height: 12,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(AppSizes.radiusTiny),
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (showTrailing) ...[
            SizedBox(width: AppSizes.paddingMedium),
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.5),
                borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Shimmer cho button
class ButtonShimmer extends StatelessWidget {
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;

  const ButtonShimmer({
    super.key,
    this.width,
    this.height,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height ?? AppSizes.buttonHeightMedium,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            borderRadius ?? BorderRadius.circular(AppSizes.radiusMedium),
      ),
    );
  }
}

/// Shimmer cho input field
class InputFieldShimmer extends StatelessWidget {
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;

  const InputFieldShimmer({
    super.key,
    this.width,
    this.height,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height ?? AppSizes.inputHeightMedium,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            borderRadius ?? BorderRadius.circular(AppSizes.radiusMedium),
      ),
    );
  }
}

/// Shimmer cho image
class ImageShimmer extends StatelessWidget {
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;

  const ImageShimmer({
    super.key,
    this.width,
    this.height,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            borderRadius ?? BorderRadius.circular(AppSizes.radiusMedium),
      ),
    );
  }
}

/// Shimmer cho text
class TextShimmer extends StatelessWidget {
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;

  const TextShimmer({
    super.key,
    this.width,
    this.height = 16,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            borderRadius ?? BorderRadius.circular(AppSizes.radiusTiny),
      ),
    );
  }
}

