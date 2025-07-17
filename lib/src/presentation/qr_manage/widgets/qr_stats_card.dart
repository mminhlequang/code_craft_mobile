import 'package:flutter/material.dart';
import 'package:internal_core/internal_core.dart';

import '../../../constants/constants.dart';

class QrStatsCard extends StatelessWidget {
  final String title;
  final int totalCount;
  final int favoriteCount;
  final int? recentCount;
  final int? totalScans;
  final bool isDynamic;

  const QrStatsCard({
    super.key,
    required this.title,
    required this.totalCount,
    required this.favoriteCount,
    this.recentCount,
    this.totalScans,
    this.isDynamic = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.paddingLarge),
      decoration: context.styles.cardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                isDynamic ? Icons.analytics : Icons.qr_code,
                color: context.colors.primary,
                size: AppSizes.iconMedium,
              ),
              const SizedBox(width: AppSizes.paddingMedium),
              Text(
                title,
                style: context.styles.titleLarge.copyWith(
                  color: context.colors.text,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.paddingLarge),

          // Stats Grid
          Row(
            children: [
              Expanded(
                child: _buildStatItem(
                  context,
                  'Tổng cộng',
                  totalCount.toString(),
                  Icons.qr_code,
                  context.colors.primary,
                ),
              ),
              const SizedBox(width: AppSizes.paddingMedium),
              Expanded(
                child: _buildStatItem(
                  context,
                  'Yêu thích',
                  favoriteCount.toString(),
                  Icons.favorite,
                  context.colors.error,
                ),
              ),
              const SizedBox(width: AppSizes.paddingMedium),
              Expanded(
                child: _buildStatItem(
                  context,
                  isDynamic ? 'Lượt quét' : 'Gần đây',
                  isDynamic
                      ? (totalScans ?? 0).toString()
                      : (recentCount ?? 0).toString(),
                  isDynamic ? Icons.trending_up : Icons.access_time,
                  context.colors.success,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(
    BuildContext context,
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.paddingMedium),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: AppSizes.iconSmall,
          ),
          const SizedBox(height: AppSizes.paddingSmall),
          Text(
            value,
            style: context.styles.titleMedium.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppSizes.paddingTiny),
          Text(
            label,
            style: context.styles.labelSmall.copyWith(
              color: context.colors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
