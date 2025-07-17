import 'package:flutter/material.dart';
import 'package:internal_core/internal_core.dart';

import '../../../constants/constants.dart';

class ProfileHeader extends StatelessWidget {
  final String username;
  final String email;
  final String? avatarUrl;
  final bool isPremium;
  final VoidCallback onEditProfile;
  final VoidCallback onUpgradePremium;

  const ProfileHeader({
    super.key,
    required this.username,
    required this.email,
    this.avatarUrl,
    required this.isPremium,
    required this.onEditProfile,
    required this.onUpgradePremium,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.paddingLarge),
      decoration: context.styles.cardDecoration,
      child: Column(
        children: [
          // Avatar and Info
          Row(
            children: [
              // Avatar
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: context.colors.primaryGradient,
                  boxShadow: [
                    BoxShadow(
                      color: context.colors.primary.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: avatarUrl != null
                    ? ClipOval(
                        child: Image.network(
                          avatarUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return _buildDefaultAvatar(context);
                          },
                        ),
                      )
                    : _buildDefaultAvatar(context),
              ),

              const SizedBox(width: AppSizes.paddingLarge),

              // User Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            username,
                            style: context.styles.headlineSmall.copyWith(
                              color: context.colors.text,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (isPremium)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSizes.paddingSmall,
                              vertical: AppSizes.paddingTiny,
                            ),
                            decoration: BoxDecoration(
                              gradient: context.colors.accentGradient,
                              borderRadius:
                                  BorderRadius.circular(AppSizes.radiusSmall),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.white,
                                  size: 12,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'Premium',
                                  style: context.styles.labelSmall.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: AppSizes.paddingSmall),
                    Text(
                      email,
                      style: context.styles.bodyMedium.copyWith(
                        color: context.colors.textSecondary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppSizes.paddingMedium),

                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: onEditProfile,
                            icon: const Icon(Icons.edit, size: 16),
                            label: Text(
                              'Chỉnh sửa',
                              style: context.styles.labelMedium.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: context.colors.surfaceVariant,
                              foregroundColor: context.colors.text,
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(
                                vertical: AppSizes.paddingSmall,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(AppSizes.radiusSmall),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: AppSizes.paddingSmall),
                        if (!isPremium)
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: onUpgradePremium,
                              icon: const Icon(Icons.star, size: 16),
                              label: Text(
                                'Nâng cấp',
                                style: context.styles.labelMedium.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: context.colors.primary,
                                foregroundColor: Colors.white,
                                elevation: 0,
                                padding: const EdgeInsets.symmetric(
                                  vertical: AppSizes.paddingSmall,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      AppSizes.radiusSmall),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Premium Banner (if not premium)
          if (!isPremium) ...[
            const SizedBox(height: AppSizes.paddingLarge),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSizes.paddingMedium),
              decoration: context.styles.accentGradientDecoration,
              child: Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.white,
                    size: AppSizes.iconMedium,
                  ),
                  const SizedBox(width: AppSizes.paddingMedium),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Nâng cấp Premium',
                          style: context.styles.titleSmall.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Mở khóa tất cả tính năng nâng cao',
                          style: context.styles.bodySmall.copyWith(
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: AppSizes.iconSmall,
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDefaultAvatar(BuildContext context) {
    return Center(
      child: Icon(
        Icons.person,
        color: Colors.white,
        size: AppSizes.iconLarge,
      ),
    );
  }
}
