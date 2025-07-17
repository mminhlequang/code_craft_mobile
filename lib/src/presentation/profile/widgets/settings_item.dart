import 'package:flutter/material.dart';
import 'package:internal_core/internal_core.dart';

import '../../../constants/constants.dart';

class SettingsItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final Widget? trailing;
  final Color? textColor;

  const SettingsItem({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.trailing,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSizes.paddingSmall),
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
        border: Border.all(
          color: context.colors.divider,
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(AppSizes.paddingMedium),
            child: Row(
              children: [
                // Icon
                Container(
                  padding: const EdgeInsets.all(AppSizes.paddingSmall),
                  decoration: BoxDecoration(
                    color:
                        (textColor ?? context.colors.primary).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppSizes.radiusSmall),
                  ),
                  child: Icon(
                    icon,
                    color: textColor ?? context.colors.primary,
                    size: AppSizes.iconSmall,
                  ),
                ),

                const SizedBox(width: AppSizes.paddingMedium),

                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: context.styles.titleSmall.copyWith(
                          color: textColor ?? context.colors.text,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        subtitle,
                        style: context.styles.bodySmall.copyWith(
                          color: textColor?.withOpacity(0.7) ??
                              context.colors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),

                // Trailing Widget
                if (trailing != null) ...[
                  const SizedBox(width: AppSizes.paddingSmall),
                  trailing!,
                ] else ...[
                  Icon(
                    Icons.arrow_forward_ios,
                    color: context.colors.textSecondary,
                    size: AppSizes.iconTiny,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
