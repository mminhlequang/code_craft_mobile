import 'package:flutter/material.dart';
import 'package:internal_core/internal_core.dart';

import '../../constants/constants.dart';

class AppBarSearchBar extends StatefulWidget {
  final String? hintText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final bool enabled;
  final Widget? leading;
  final List<Widget>? actions;

  const AppBarSearchBar({
    super.key,
    this.hintText,
    this.controller,
    this.onChanged,
    this.onTap,
    this.enabled = true,
    this.leading,
    this.actions,
  });

  @override
  State<AppBarSearchBar> createState() => _AppBarSearchBarState();
}

class _AppBarSearchBarState extends State<AppBarSearchBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
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
        return SlideTransition(
          position: _slideAnimation,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Container(
              height: 45,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: Colors.white.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  // Leading icon
                  if (widget.leading != null)
                    widget.leading!
                  else
                    Padding(
                      padding:
                          const EdgeInsets.only(left: AppSizes.paddingMedium),
                      child: Icon(
                        Icons.search_rounded,
                        color: Colors.white.withOpacity(0.8),
                        size: 20,
                      ),
                    ),

                  // Text field
                  Expanded(
                    child: TextField(
                      controller: widget.controller,
                      onChanged: widget.onChanged,
                      onTap: widget.onTap,
                      enabled: widget.enabled,
                      style: context.styles.bodyMedium.copyWith(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        hintText: widget.hintText ?? 'Tìm kiếm...',
                        hintStyle: context.styles.bodyMedium.copyWith(
                          color: Colors.white.withOpacity(0.6),
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: AppSizes.paddingMedium,
                          vertical: AppSizes.paddingSmall,
                        ),
                      ),
                    ),
                  ),

                  // Actions
                  if (widget.actions != null) ...widget.actions!,
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class AppBarTabBar extends StatefulWidget {
  final List<String> tabs;
  final int selectedIndex;
  final ValueChanged<int>? onTap;
  final bool useGradient;

  const AppBarTabBar({
    super.key,
    required this.tabs,
    required this.selectedIndex,
    this.onTap,
    this.useGradient = true,
  });

  @override
  State<AppBarTabBar> createState() => _AppBarTabBarState();
}

class _AppBarTabBarState extends State<AppBarTabBar>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: widget.tabs.length,
      vsync: this,
    );
    _tabController.index = widget.selectedIndex;
  }

  @override
  void didUpdateWidget(AppBarTabBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedIndex != oldWidget.selectedIndex) {
      _tabController.animateTo(widget.selectedIndex);
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TabBar(
      dividerColor: Colors.transparent,
      controller: _tabController,
      onTap: widget.onTap,
      indicator: BoxDecoration(
        gradient: widget.useGradient
            ? LinearGradient(
                colors: [
                  Colors.white.withOpacity(0.3),
                  Colors.white.withOpacity(0.1),
                ],
              )
            : null,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
          width: 1,
        ),
      ),
      indicatorSize: TabBarIndicatorSize.tab,
      labelColor: Colors.white,
      unselectedLabelColor: Colors.white.withOpacity(0.6),
      labelStyle: context.styles.bodyMedium.copyWith(
        fontWeight: FontWeight.bold,
      ),
      unselectedLabelStyle: context.styles.bodyMedium,
      tabs: widget.tabs.map((tab) => Tab(text: tab)).toList(),
    );
  }
}

class AppBarChipBar extends StatelessWidget {
  final List<String> chips;
  final int selectedIndex;
  final ValueChanged<int>? onTap;
  final bool useGradient;

  const AppBarChipBar({
    super.key,
    required this.chips,
    required this.selectedIndex,
    this.onTap,
    this.useGradient = true,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: chips.asMap().entries.map((entry) {
          final index = entry.key;
          final chip = entry.value;
          final isSelected = index == selectedIndex;

          return Padding(
            padding: const EdgeInsets.only(right: AppSizes.paddingSmall),
            child: GestureDetector(
              onTap: () => onTap?.call(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.paddingMedium,
                  vertical: AppSizes.paddingSmall,
                ),
                decoration: BoxDecoration(
                  gradient: isSelected && useGradient
                      ? LinearGradient(
                          colors: [
                            Colors.white.withOpacity(0.3),
                            Colors.white.withOpacity(0.1),
                          ],
                        )
                      : null,
                  color: isSelected && !useGradient
                      ? Colors.white.withOpacity(0.2)
                      : null,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected
                        ? Colors.white.withOpacity(0.5)
                        : Colors.white.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: Text(
                  chip,
                  style: context.styles.bodySmall.copyWith(
                    color: isSelected
                        ? Colors.white
                        : Colors.white.withOpacity(0.7),
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class AppBarInfoBar extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? leading;
  final List<Widget>? actions;
  final VoidCallback? onTap;

  const AppBarInfoBar({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.actions,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.paddingMedium,
          vertical: AppSizes.paddingSmall,
        ),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Colors.white.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            // Leading
            if (leading != null) ...[
              leading!,
              const SizedBox(width: AppSizes.paddingMedium),
            ],

            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: context.styles.bodyMedium.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      subtitle!,
                      style: context.styles.bodySmall.copyWith(
                        color: Colors.white.withOpacity(0.7),
                      ),
                    ),
                  ],
                ],
              ),
            ),

            // Actions
            if (actions != null) ...[
              const SizedBox(width: AppSizes.paddingMedium),
              ...actions!,
            ],
          ],
        ),
      ),
    );
  }
}
