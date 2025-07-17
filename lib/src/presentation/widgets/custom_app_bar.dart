import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:internal_core/internal_core.dart';

import '../../constants/constants.dart';

class WidgetCustomAppBar extends StatefulWidget {
  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final bool useGradient;
  final double height;
  final bool centerTitle;
  final Color? backgroundColor;
  final Widget? flexibleSpace;
  final Widget? bottomWidget;
  final double bottomWidgetHeight;
  final bool showBottomDivider;
  final EdgeInsetsGeometry? contentPadding;

  const WidgetCustomAppBar({
    super.key,
    required this.title,
    this.actions,
    this.leading,
    this.showBackButton = true,
    this.onBackPressed,
    this.useGradient = true,
    this.height = kToolbarHeight,
    this.centerTitle = true,
    this.backgroundColor,
    this.flexibleSpace,
    this.bottomWidget,
    this.bottomWidgetHeight = 60,
    this.showBottomDivider = true,
    this.contentPadding,
  });

  @override
  State<WidgetCustomAppBar> createState() => _WidgetCustomAppBarState();
}

class _WidgetCustomAppBarState extends State<WidgetCustomAppBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
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
      begin: const Offset(0, -1),
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
              // height: widget.height,
              decoration: BoxDecoration(
                gradient: widget.useGradient
                    ? LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          context.colors.primary.withOpacity(0.95),
                          context.colors.secondary.withOpacity(0.95),
                          context.colors.accent.withOpacity(0.95),
                        ],
                      )
                    : null,
                color: widget.useGradient
                    ? null
                    : (widget.backgroundColor ?? context.colors.surface),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 15,
                    offset: const Offset(0, 3),
                    spreadRadius: 0,
                  ),
                  BoxShadow(
                    color: context.colors.primary.withOpacity(0.1),
                    blurRadius: 25,
                    offset: const Offset(0, 1),
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                    ),
                    child: SafeArea(
                      bottom: false,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSizes.paddingMedium,
                          vertical: AppSizes.paddingMedium,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Main AppBar Row
                            Row(
                              children: [
                                // Leading Widget - Fixed width for balance
                                SizedBox(
                                  width: 60,
                                  child: widget.leading != null
                                      ? widget.leading!
                                      : widget.showBackButton
                                          ? _buildBackButton(context)
                                          : null,
                                ),

                                // Title - Always centered
                                Expanded(
                                  child: Center(
                                    child: _buildTitle(context),
                                  ),
                                ),

                                // Actions - Fixed width for balance
                                SizedBox(
                                  width: 60,
                                  child: widget.actions != null
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: widget.actions!
                                              .map(
                                                (action) => Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    left: AppSizes.paddingSmall,
                                                  ),
                                                  child: action,
                                                ),
                                              )
                                              .toList(),
                                        )
                                      : null,
                                ),
                              ],
                            ),

                            // Bottom Widget
                            if (widget.bottomWidget != null) ...[
                              if (widget.showBottomDivider)
                                Container(
                                  height: 1,
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: AppSizes.paddingMedium,
                                    vertical: AppSizes.paddingSmall,
                                  ),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.transparent,
                                        Colors.white.withOpacity(0.3),
                                        Colors.transparent,
                                      ],
                                    ),
                                  ),
                                ),
                              Container(
                                height: widget.bottomWidgetHeight,
                                padding: widget.contentPadding ??
                                    const EdgeInsets.symmetric(
                                      horizontal: AppSizes.paddingMedium,
                                      vertical: AppSizes.paddingSmall,
                                    ),
                                child: widget.bottomWidget!,
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return AnimatedContainer(
      duration: AppStyles.instance.animationFast,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
          onTap: widget.onBackPressed ?? () => Navigator.pop(context),
          child: Container(
            padding: const EdgeInsets.all(AppSizes.paddingSmall),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withOpacity(0.3),
                  Colors.white.withOpacity(0.1),
                ],
              ),
              borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              Icons.arrow_back_ios_new,
              color: widget.useGradient ? Colors.white : context.colors.text,
              size: AppSizes.iconMedium,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return AnimatedDefaultTextStyle(
      duration: AppStyles.instance.animationFast,
      style: context.styles.headlineSmall.copyWith(
        color: widget.useGradient ? Colors.white : context.colors.text,
        fontWeight: FontWeight.bold,
        shadows: widget.useGradient
            ? [
                Shadow(
                  color: Colors.black.withOpacity(0.3),
                  offset: const Offset(0, 1),
                  blurRadius: 3,
                ),
              ]
            : null,
      ),
      child: Text(widget.title),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(widget.height);
}

class CustomSliverAppBar extends StatefulWidget {
  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final bool useGradient;
  final double expandedHeight;
  final bool floating;
  final bool pinned;
  final Widget? flexibleSpace;
  final Color? backgroundColor;

  const CustomSliverAppBar({
    super.key,
    required this.title,
    this.actions,
    this.leading,
    this.showBackButton = true,
    this.onBackPressed,
    this.useGradient = true,
    this.expandedHeight = 120,
    this.floating = false,
    this.pinned = true,
    this.flexibleSpace,
    this.backgroundColor,
  });

  @override
  State<CustomSliverAppBar> createState() => _CustomSliverAppBarState();
}

class _CustomSliverAppBarState extends State<CustomSliverAppBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

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
        return FadeTransition(
          opacity: _fadeAnimation,
          child: SliverAppBar(
            expandedHeight: widget.expandedHeight,
            floating: widget.floating,
            pinned: widget.pinned,
            backgroundColor: widget.useGradient
                ? null
                : (widget.backgroundColor ?? context.colors.surface),
            elevation: 0,
            leading: widget.leading ??
                (widget.showBackButton
                    ? _buildSliverBackButton(context)
                    : null),
            actions: widget.actions,
            flexibleSpace: FlexibleSpaceBar(
              title: _buildSliverTitle(context),
              centerTitle: true,
              background: widget.useGradient
                  ? Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            context.colors.primary.withOpacity(0.95),
                            context.colors.secondary.withOpacity(0.95),
                            context.colors.accent.withOpacity(0.95),
                          ],
                        ),
                      ),
                    )
                  : null,
            ),
          ),
        );
      },
    );
  }

  Widget _buildSliverBackButton(BuildContext context) {
    return AnimatedContainer(
      duration: AppStyles.instance.animationFast,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
          onTap: widget.onBackPressed ?? () => Navigator.pop(context),
          child: Container(
            margin: const EdgeInsets.all(AppSizes.paddingSmall),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withOpacity(0.3),
                  Colors.white.withOpacity(0.1),
                ],
              ),
              borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              Icons.arrow_back_ios_new,
              color: widget.useGradient ? Colors.white : context.colors.text,
              size: AppSizes.iconMedium,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSliverTitle(BuildContext context) {
    return AnimatedDefaultTextStyle(
      duration: AppStyles.instance.animationFast,
      style: context.styles.headlineMedium.copyWith(
        color: widget.useGradient ? Colors.white : context.colors.text,
        fontWeight: FontWeight.bold,
        shadows: widget.useGradient
            ? [
                Shadow(
                  color: Colors.black.withOpacity(0.3),
                  offset: const Offset(0, 1),
                  blurRadius: 3,
                ),
              ]
            : null,
      ),
      child: Text(widget.title),
    );
  }
}
