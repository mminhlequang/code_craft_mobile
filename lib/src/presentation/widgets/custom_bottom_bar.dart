import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:internal_core/internal_core.dart';

import '../../constants/constants.dart';

class CustomBottomBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;
  final List<BottomBarItem> items;
  final bool showBackground;
  final bool useGradient;
  final Color? backgroundColor;
  final double elevation;

  const CustomBottomBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
    this.showBackground = true,
    this.useGradient = true,
    this.backgroundColor,
    this.elevation = 20,
  });

  @override
  State<CustomBottomBar> createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _slideAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _animationController.forward();
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
        return Transform.translate(
          offset: Offset(0, 20 * (1 - _slideAnimation.value)),
          child: Opacity(
            opacity: _fadeAnimation.value,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: widget.elevation,
                    offset: const Offset(0, -4),
                    spreadRadius: 0,
                  ),
                  BoxShadow(
                    color: context.colors.primary.withOpacity(0.05),
                    blurRadius: 15,
                    offset: const Offset(0, -2),
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: widget.items.asMap().entries.map((entry) {
                      final index = entry.key;
                      final item = entry.value;
                      final isSelected = index == widget.currentIndex;

                      return _BottomBarItem(
                        item: item,
                        isSelected: isSelected,
                        onTap: () {
                          if (index != widget.currentIndex) {
                            widget.onTap(index);
                            _animationController.reset();
                            _animationController.forward();
                          }
                        },
                      );
                    }).toList(),
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

class _BottomBarItem extends StatefulWidget {
  final BottomBarItem item;
  final bool isSelected;
  final VoidCallback onTap;

  const _BottomBarItem({
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<_BottomBarItem> createState() => _BottomBarItemState();
}

class _BottomBarItemState extends State<_BottomBarItem>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _bounceAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    ));

    _bounceAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    if (widget.isSelected) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(_BottomBarItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isSelected != oldWidget.isSelected) {
      if (widget.isSelected) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: GestureDetector(
            onTap: widget.onTap,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                gradient: widget.isSelected
                    ? LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          context.colors.primary.withOpacity(0.1),
                          context.colors.primary.withOpacity(0.05),
                        ],
                        stops: const [0.0, 1.0],
                      )
                    : null,
                borderRadius: BorderRadius.circular(16),
                border: widget.isSelected
                    ? Border.all(
                        color: context.colors.primary.withOpacity(0.2),
                        width: 1,
                      )
                    : null,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Icon with bounce animation
                  Transform.translate(
                    offset: Offset(0, -2 * _bounceAnimation.value),
                    child: Icon(
                      widget.isSelected
                          ? widget.item.selectedIcon
                          : widget.item.icon,
                      color: widget.isSelected
                          ? context.colors.primary
                          : Colors.grey.shade600,
                      size: widget.isSelected ? 24 : 22,
                    ),
                  ),
                  const SizedBox(height: 4),
                  // Label
                  Text(
                    widget.item.label,
                    style: context.styles.bodySmall.copyWith(
                      color: widget.isSelected
                          ? context.colors.primary
                          : Colors.grey.shade600,
                      fontWeight:
                          widget.isSelected ? FontWeight.w600 : FontWeight.w500,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class BottomBarItem {
  final IconData icon;
  final IconData selectedIcon;
  final String label;

  const BottomBarItem({
    required this.icon,
    required this.selectedIcon,
    required this.label,
  });
}

// Predefined bottom bar items
class BottomBarItems {
  static const home = BottomBarItem(
    icon: Icons.home_outlined,
    selectedIcon: Icons.home_rounded,
    label: 'Trang chủ',
  );

  static const qr = BottomBarItem(
    icon: Icons.qr_code_outlined,
    selectedIcon: Icons.qr_code_rounded,
    label: 'QR Code',
  );

  static const scan = BottomBarItem(
    icon: Icons.qr_code_scanner_outlined,
    selectedIcon: Icons.qr_code_scanner_rounded,
    label: 'Quét QR',
  );

  static const history = BottomBarItem(
    icon: Icons.history_outlined,
    selectedIcon: Icons.history_rounded,
    label: 'Lịch sử',
  );

  static const profile = BottomBarItem(
    icon: Icons.person_outline_rounded,
    selectedIcon: Icons.person_rounded,
    label: 'Cá nhân',
  );
}
