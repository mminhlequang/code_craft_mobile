import 'package:flutter/material.dart';
import 'package:internal_core/internal_core.dart';

import '../../../constants/constants.dart';
import '../../widgets/custom_card.dart';

class QrTypeCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;

  const QrTypeCard({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedCard(
      isSelected: isSelected,
      selectedColor: color.withOpacity(0.1),
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedContainer(
            duration: AppStyles.instance.animationFast,
            padding: const EdgeInsets.all(AppSizes.paddingMedium),
            decoration: BoxDecoration(
              color:
                  isSelected ? color.withOpacity(0.2) : color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
            ),
            child: Icon(
              icon,
              color: color,
              size: AppSizes.iconLarge,
            ),
          ),
          const SizedBox(height: AppSizes.paddingMedium),
          Text(
            title,
            style: context.styles.titleSmall.copyWith(
              color: context.colors.text,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          if (isSelected) ...[
            const SizedBox(height: AppSizes.paddingSmall),
            AnimatedContainer(
              duration: AppStyles.instance.animationFast,
              child: Icon(
                Icons.check_circle,
                color: color,
                size: AppSizes.iconSmall,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
