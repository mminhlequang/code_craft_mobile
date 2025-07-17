import 'package:flutter/material.dart';
import 'package:internal_core/internal_core.dart';

import '../../constants/constants.dart';

class AppBarActionButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback? onTap;
  final String? tooltip;
  final Color? iconColor;
  final double? iconSize;
  final bool useGradient;
  final bool showBadge;
  final int? badgeCount;
  final Color? badgeColor;

  const AppBarActionButton({
    super.key,
    required this.icon,
    this.onTap,
    this.tooltip,
    this.iconColor,
    this.iconSize,
    this.useGradient = true,
    this.showBadge = false,
    this.badgeCount,
    this.badgeColor,
  });

  @override
  State<AppBarActionButton> createState() => _AppBarActionButtonState();
}

class _AppBarActionButtonState extends State<AppBarActionButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.9,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 0.1,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Transform.rotate(
            angle: _rotationAnimation.value,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
                onTap: widget.onTap != null
                    ? () {
                        _animationController.forward().then((_) {
                          _animationController.reverse();
                        });
                        widget.onTap!();
                      }
                    : null,
                child: Container(
                  padding: const EdgeInsets.all(AppSizes.paddingSmall),
                  decoration: BoxDecoration(
                    gradient: widget.useGradient
                        ? LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.white.withOpacity(0.3),
                              Colors.white.withOpacity(0.1),
                            ],
                          )
                        : null,
                    borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      Icon(
                        widget.icon,
                        color: widget.iconColor ?? Colors.white,
                        size: widget.iconSize ?? AppSizes.iconMedium,
                      ),
                      if (widget.showBadge && widget.badgeCount != null)
                        Positioned(
                          right: 0,
                          top: 0,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 4,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: widget.badgeColor ?? Colors.red,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            constraints: const BoxConstraints(
                              minWidth: 16,
                              minHeight: 16,
                            ),
                            child: Text(
                              widget.badgeCount.toString(),
                              style: context.styles.bodySmall.copyWith(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// Predefined action buttons
class AppBarActions {
  static Widget search({
    VoidCallback? onTap,
    String? tooltip,
  }) {
    return AppBarActionButton(
      icon: Icons.search_rounded,
      onTap: onTap,
      tooltip: tooltip ?? 'Tìm kiếm',
    );
  }

  static Widget notification({
    VoidCallback? onTap,
    String? tooltip,
    int? badgeCount,
  }) {
    return AppBarActionButton(
      icon: Icons.notifications_rounded,
      onTap: onTap,
      tooltip: tooltip ?? 'Thông báo',
      showBadge: badgeCount != null && badgeCount > 0,
      badgeCount: badgeCount,
    );
  }

  static Widget settings({
    VoidCallback? onTap,
    String? tooltip,
  }) {
    return AppBarActionButton(
      icon: Icons.settings_rounded,
      onTap: onTap,
      tooltip: tooltip ?? 'Cài đặt',
    );
  }

  static Widget share({
    VoidCallback? onTap,
    String? tooltip,
  }) {
    return AppBarActionButton(
      icon: Icons.share_rounded,
      onTap: onTap,
      tooltip: tooltip ?? 'Chia sẻ',
    );
  }

  static Widget favorite({
    VoidCallback? onTap,
    String? tooltip,
    bool isFavorite = false,
  }) {
    return AppBarActionButton(
      icon: isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
      onTap: onTap,
      tooltip: tooltip ?? 'Yêu thích',
      iconColor: isFavorite ? Colors.red : null,
    );
  }

  static Widget qrCode({
    VoidCallback? onTap,
    String? tooltip,
  }) {
    return AppBarActionButton(
      icon: Icons.qr_code_rounded,
      onTap: onTap,
      tooltip: tooltip ?? 'QR Code',
    );
  }

  static Widget camera({
    VoidCallback? onTap,
    String? tooltip,
  }) {
    return AppBarActionButton(
      icon: Icons.camera_alt_rounded,
      onTap: onTap,
      tooltip: tooltip ?? 'Camera',
    );
  }

  static Widget add({
    VoidCallback? onTap,
    String? tooltip,
  }) {
    return AppBarActionButton(
      icon: Icons.add_rounded,
      onTap: onTap,
      tooltip: tooltip ?? 'Thêm mới',
    );
  }

  static Widget edit({
    VoidCallback? onTap,
    String? tooltip,
  }) {
    return AppBarActionButton(
      icon: Icons.edit_rounded,
      onTap: onTap,
      tooltip: tooltip ?? 'Chỉnh sửa',
    );
  }

  static Widget delete({
    VoidCallback? onTap,
    String? tooltip,
  }) {
    return AppBarActionButton(
      icon: Icons.delete_rounded,
      onTap: onTap,
      tooltip: tooltip ?? 'Xóa',
      iconColor: Colors.red,
    );
  }

  static Widget more({
    VoidCallback? onTap,
    String? tooltip,
  }) {
    return AppBarActionButton(
      icon: Icons.more_vert_rounded,
      onTap: onTap,
      tooltip: tooltip ?? 'Thêm tùy chọn',
    );
  }
}
