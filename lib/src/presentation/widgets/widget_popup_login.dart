import 'package:app/src/utils/utils.dart';
import 'package:flutter/material.dart';
import '../../constants/app_sizes.dart';
import '../../constants/constants.dart';

/// Popup yêu cầu đăng nhập để xem nội dung
class PopupLoginRequired extends StatelessWidget {
  final VoidCallback? onLogin;
  final VoidCallback? onClose;

  const PopupLoginRequired({
    super.key,
    this.onLogin,
    this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    // Lấy theme context
    final theme = Theme.of(context);
    final colors = theme.extension<AppColors>() ?? AppColors.instance;
    final textStyles = theme.textTheme;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppSizes.radiusXLarge),
        ),
        child: Container(
          padding: const EdgeInsets.all(AppSizes.paddingXLarge),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                colors.primary.withOpacity(0.1),
                colors.accent.withOpacity(0.1),
              ],
            ),
            borderRadius: BorderRadius.circular(AppSizes.radiusXLarge),
            border: Border.all(
              color: colors.primary.withOpacity(0.2),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: colors.primary.withOpacity(0.08),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: AppSizes.paddingMedium),

              // Icon
              Container(
                padding: const EdgeInsets.all(AppSizes.paddingLarge),
                decoration: BoxDecoration(
                  color: colors.primary.withOpacity(0.08),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.lock_outline_rounded,
                  color: colors.primary,
                  size: 48,
                ),
              ),
              const SizedBox(height: AppSizes.paddingLarge),

              // Title
              Text(
                'Bạn cần đăng nhập',
                style: textStyles.headlineSmall?.copyWith(
                  color: colors.text,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSizes.paddingMedium),

              // Subtitle
              Text(
                'Vui lòng đăng nhập để xem nội dung này.',
                style: textStyles.bodyMedium?.copyWith(
                  color: colors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSizes.paddingLarge),

              // Login button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      vertical: AppSizes.paddingMedium,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
                    ),
                    elevation: 2,
                    shadowColor: colors.primary.withOpacity(0.2),
                  ),
                  onPressed: onLogin ?? () => AppGoRouter.instance.goToLogin(),
                  child: const Text(
                    'Đăng nhập',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
