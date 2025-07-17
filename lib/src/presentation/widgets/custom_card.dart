import 'package:flutter/material.dart';
import 'package:internal_core/internal_core.dart';

import '../../constants/constants.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final bool useGradient;
  final Gradient? gradient;
  final Color? backgroundColor;
  final double borderRadius;
  final bool useShadow;
  final double shadowBlur;
  final Color? shadowColor;
  final Offset? shadowOffset;
  final VoidCallback? onTap;
  final bool animateOnTap;
  final Duration? animationDuration;

  const CustomCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.useGradient = false,
    this.gradient,
    this.backgroundColor,
    this.borderRadius = AppSizes.radiusLarge,
    this.useShadow = true,
    this.shadowBlur = 8,
    this.shadowColor,
    this.shadowOffset,
    this.onTap,
    this.animateOnTap = true,
    this.animationDuration,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: animationDuration ?? AppStyles.instance.animationFast,
      margin: margin,
      decoration: BoxDecoration(
        gradient:
            useGradient ? (gradient ?? context.colors.primaryGradient) : null,
        color: useGradient ? null : (backgroundColor ?? context.colors.surface),
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: useShadow
            ? [
                BoxShadow(
                  color: shadowColor ?? Colors.black.withOpacity(0.1),
                  blurRadius: shadowBlur,
                  offset: shadowOffset ?? const Offset(0, 2),
                ),
              ]
            : null,
        border: useGradient
            ? null
            : Border.all(
                color: context.colors.divider,
                width: 1,
              ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(borderRadius),
          onTap: onTap,
          child: AnimatedPadding(
            duration: animationDuration ?? AppStyles.instance.animationFast,
            padding: padding ?? const EdgeInsets.all(AppSizes.paddingLarge),
            child: child,
          ),
        ),
      ),
    );
  }
}

class AnimatedCard extends StatefulWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final bool useGradient;
  final Gradient? gradient;
  final Color? backgroundColor;
  final double borderRadius;
  final bool useShadow;
  final double shadowBlur;
  final Color? shadowColor;
  final Offset? shadowOffset;
  final VoidCallback? onTap;
  final Duration? animationDuration;
  final bool isSelected;
  final Color? selectedColor;

  const AnimatedCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.useGradient = false,
    this.gradient,
    this.backgroundColor,
    this.borderRadius = AppSizes.radiusLarge,
    this.useShadow = true,
    this.shadowBlur = 8,
    this.shadowColor,
    this.shadowOffset,
    this.onTap,
    this.animationDuration,
    this.isSelected = false,
    this.selectedColor,
  });

  @override
  State<AnimatedCard> createState() => _AnimatedCardState();
}

class _AnimatedCardState extends State<AnimatedCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _elevationAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.animationDuration ?? AppStyles.instance.animationFast,
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
    _elevationAnimation = Tween<double>(
      begin: 1.0,
      end: 0.5,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
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
          child: AnimatedContainer(
            duration:
                widget.animationDuration ?? AppStyles.instance.animationFast,
            margin: widget.margin,
            decoration: BoxDecoration(
              gradient: widget.useGradient
                  ? (widget.gradient ?? context.colors.primaryGradient)
                  : null,
              color: widget.useGradient
                  ? null
                  : (widget.isSelected
                      ? (widget.selectedColor ??
                          context.colors.primary.withOpacity(0.1))
                      : widget.backgroundColor ?? context.colors.surface),
              borderRadius: BorderRadius.circular(widget.borderRadius),
              boxShadow: widget.useShadow
                  ? [
                      BoxShadow(
                        color: (widget.shadowColor ??
                                Colors.black.withOpacity(0.1))
                            .withOpacity(_elevationAnimation.value),
                        blurRadius:
                            widget.shadowBlur * _elevationAnimation.value,
                        offset: widget.shadowOffset ?? const Offset(0, 2),
                      ),
                    ]
                  : null,
              border: widget.useGradient
                  ? null
                  : Border.all(
                      color: widget.isSelected
                          ? context.colors.primary
                          : context.colors.divider,
                      width: widget.isSelected ? 2 : 1,
                    ),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                onTap: widget.onTap,
                onTapDown: (_) => _controller.forward(),
                onTapUp: (_) => _controller.reverse(),
                onTapCancel: () => _controller.reverse(),
                child: AnimatedPadding(
                  duration: widget.animationDuration ??
                      AppStyles.instance.animationFast,
                  padding: widget.padding ??
                      const EdgeInsets.all(AppSizes.paddingLarge),
                  child: widget.child,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class GradientCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Gradient gradient;
  final double borderRadius;
  final bool useShadow;
  final double shadowBlur;
  final Color? shadowColor;
  final Offset? shadowOffset;
  final VoidCallback? onTap;
  final Duration? animationDuration;

  const GradientCard({
    super.key,
    required this.child,
    required this.gradient,
    this.padding,
    this.margin,
    this.borderRadius = AppSizes.radiusLarge,
    this.useShadow = true,
    this.shadowBlur = 12,
    this.shadowColor,
    this.shadowOffset,
    this.onTap,
    this.animationDuration,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      padding: padding,
      margin: margin,
      useGradient: true,
      gradient: gradient,
      borderRadius: borderRadius,
      useShadow: useShadow,
      shadowBlur: shadowBlur,
      shadowColor: shadowColor,
      shadowOffset: shadowOffset,
      onTap: onTap,
      animationDuration: animationDuration,
      child: child,
    );
  }
}
