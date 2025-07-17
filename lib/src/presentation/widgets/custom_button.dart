import 'package:flutter/material.dart';
import 'package:internal_core/internal_core.dart';

import '../../constants/constants.dart';

class CustomButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool useGradient;
  final Gradient? gradient;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;
  final double height;
  final double borderRadius;
  final bool isLoading;
  final bool isDisabled;
  final Duration? animationDuration;
  final bool useShadow;
  final double shadowBlur;
  final Color? shadowColor;
  final bool useRipple;
  final double? elevation;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.icon,
    this.useGradient = true,
    this.gradient,
    this.backgroundColor,
    this.textColor,
    this.width,
    this.height = AppSizes.buttonHeightLarge,
    this.borderRadius = AppSizes.radiusMedium,
    this.isLoading = false,
    this.isDisabled = false,
    this.animationDuration,
    this.useShadow = true,
    this.shadowBlur = 12,
    this.shadowColor,
    this.useRipple = true,
    this.elevation,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _elevationAnimation;
  late Animation<double> _rippleAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.animationDuration ?? const Duration(milliseconds: 200),
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
      end: 0.3,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _rippleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    if (widget.onPressed != null && !widget.isDisabled && !widget.isLoading) {
      setState(() => _isPressed = true);
      _controller.forward();
    }
  }

  void _handleTapUp(TapUpDetails details) {
    if (widget.onPressed != null && !widget.isDisabled && !widget.isLoading) {
      setState(() => _isPressed = false);
      _controller.reverse();
    }
  }

  void _handleTapCancel() {
    if (widget.onPressed != null && !widget.isDisabled && !widget.isLoading) {
      setState(() => _isPressed = false);
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEnabled =
        widget.onPressed != null && !widget.isDisabled && !widget.isLoading;
    final effectiveElevation = widget.elevation ?? (isEnabled ? 4.0 : 0.0);

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Container(
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              gradient: widget.useGradient && isEnabled
                  ? (widget.gradient ?? _getDefaultGradient(context))
                  : null,
              color: widget.useGradient || !isEnabled
                  ? null
                  : (widget.backgroundColor ?? context.colors.primary),
              borderRadius: BorderRadius.circular(widget.borderRadius),
              boxShadow: widget.useShadow && isEnabled
                  ? [
                      BoxShadow(
                        color: (widget.shadowColor ??
                                Colors.black.withOpacity(0.15))
                            .withOpacity(_elevationAnimation.value),
                        blurRadius:
                            widget.shadowBlur * _elevationAnimation.value,
                        offset: Offset(
                            0, effectiveElevation * _elevationAnimation.value),
                        spreadRadius: 0,
                      ),
                      if (_isPressed && widget.useRipple)
                        BoxShadow(
                          color: (widget.shadowColor ??
                                  Colors.black.withOpacity(0.1))
                              .withOpacity(_rippleAnimation.value),
                          blurRadius: 20 * _rippleAnimation.value,
                          offset: const Offset(0, 0),
                          spreadRadius: 5 * _rippleAnimation.value,
                        ),
                    ]
                  : null,
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                onTap: isEnabled ? widget.onPressed : null,
                onTapDown: _handleTapDown,
                onTapUp: _handleTapUp,
                onTapCancel: _handleTapCancel,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: Center(
                    child: widget.isLoading
                        ? _buildLoadingIndicator()
                        : _buildButtonContent(context),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLoadingIndicator() {
    return SizedBox(
      width: 24,
      height: 24,
      child: CircularProgressIndicator(
        strokeWidth: 2.5,
        valueColor: AlwaysStoppedAnimation<Color>(
          widget.textColor ?? Colors.white,
        ),
      ),
    );
  }

  Widget _buildButtonContent(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.icon != null) ...[
          Icon(
            widget.icon,
            color: widget.textColor ?? Colors.white,
            size: 20,
          ),
          const SizedBox(width: AppSizes.paddingSmall),
        ],
        Text(
          widget.text,
          style: context.styles.labelLarge.copyWith(
            color: widget.textColor ?? Colors.white,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }

  Gradient _getDefaultGradient(BuildContext context) {
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        context.colors.primary,
        context.colors.primary.withOpacity(0.8),
        context.colors.accent,
      ],
    );
  }
}

class GradientButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;
  final Gradient gradient;
  final Color? textColor;
  final double? width;
  final double height;
  final double borderRadius;
  final bool isLoading;
  final bool isDisabled;
  final Duration? animationDuration;
  final bool useShadow;
  final double shadowBlur;
  final Color? shadowColor;
  final bool useRipple;
  final double? elevation;

  const GradientButton({
    super.key,
    required this.text,
    required this.gradient,
    this.onPressed,
    this.icon,
    this.textColor,
    this.width,
    this.height = AppSizes.buttonHeightLarge,
    this.borderRadius = AppSizes.radiusMedium,
    this.isLoading = false,
    this.isDisabled = false,
    this.animationDuration,
    this.useShadow = true,
    this.shadowBlur = 12,
    this.shadowColor,
    this.useRipple = true,
    this.elevation,
  });

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      text: text,
      onPressed: onPressed,
      icon: icon,
      useGradient: true,
      gradient: gradient,
      textColor: textColor,
      width: width,
      height: height,
      borderRadius: borderRadius,
      isLoading: isLoading,
      isDisabled: isDisabled,
      animationDuration: animationDuration,
      useShadow: useShadow,
      shadowBlur: shadowBlur,
      shadowColor: shadowColor,
      useRipple: useRipple,
      elevation: elevation,
    );
  }
}

class IconButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? iconColor;
  final double size;
  final double borderRadius;
  final bool useShadow;
  final double shadowBlur;
  final Color? shadowColor;
  final Duration? animationDuration;
  final bool useGradient;
  final Gradient? gradient;
  final double? elevation;

  const IconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.backgroundColor,
    this.iconColor,
    this.size = AppSizes.buttonHeightMedium,
    this.borderRadius = AppSizes.radiusMedium,
    this.useShadow = true,
    this.shadowBlur = 8,
    this.shadowColor,
    this.animationDuration,
    this.useGradient = false,
    this.gradient,
    this.elevation,
  });

  @override
  State<IconButton> createState() => _IconButtonState();
}

class _IconButtonState extends State<IconButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _elevationAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.animationDuration ?? const Duration(milliseconds: 150),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.9,
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

  void _handleTapDown(TapDownDetails details) {
    if (widget.onPressed != null) {
      setState(() => _isPressed = true);
      _controller.forward();
    }
  }

  void _handleTapUp(TapUpDetails details) {
    if (widget.onPressed != null) {
      setState(() => _isPressed = false);
      _controller.reverse();
    }
  }

  void _handleTapCancel() {
    if (widget.onPressed != null) {
      setState(() => _isPressed = false);
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEnabled = widget.onPressed != null;
    final effectiveElevation = widget.elevation ?? (isEnabled ? 2.0 : 0.0);

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              gradient: widget.useGradient && isEnabled
                  ? (widget.gradient ?? _getDefaultGradient(context))
                  : null,
              color: widget.useGradient || !isEnabled
                  ? null
                  : (widget.backgroundColor ?? context.colors.primary),
              borderRadius: BorderRadius.circular(widget.borderRadius),
              boxShadow: widget.useShadow && isEnabled
                  ? [
                      BoxShadow(
                        color: (widget.shadowColor ??
                                Colors.black.withOpacity(0.1))
                            .withOpacity(_elevationAnimation.value),
                        blurRadius:
                            widget.shadowBlur * _elevationAnimation.value,
                        offset: Offset(
                            0, effectiveElevation * _elevationAnimation.value),
                      ),
                    ]
                  : null,
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                onTap: widget.onPressed,
                onTapDown: _handleTapDown,
                onTapUp: _handleTapUp,
                onTapCancel: _handleTapCancel,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: Center(
                    child: Icon(
                      widget.icon,
                      color: widget.iconColor ?? Colors.white,
                      size: widget.size * 0.4,
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

  Gradient _getDefaultGradient(BuildContext context) {
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        context.colors.primary,
        context.colors.accent,
      ],
    );
  }
}

class FloatingActionButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? iconColor;
  final double size;
  final bool useShadow;
  final double shadowBlur;
  final Color? shadowColor;
  final Duration? animationDuration;
  final bool useGradient;
  final Gradient? gradient;
  final double? elevation;

  const FloatingActionButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.backgroundColor,
    this.iconColor,
    this.size = 56,
    this.useShadow = true,
    this.shadowBlur = 12,
    this.shadowColor,
    this.animationDuration,
    this.useGradient = true,
    this.gradient,
    this.elevation,
  });

  @override
  State<FloatingActionButton> createState() => _FloatingActionButtonState();
}

class _FloatingActionButtonState extends State<FloatingActionButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _elevationAnimation;
  late Animation<double> _rotationAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.animationDuration ?? const Duration(milliseconds: 200),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.85,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _elevationAnimation = Tween<double>(
      begin: 1.0,
      end: 0.3,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 0.1,
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

  void _handleTapDown(TapDownDetails details) {
    if (widget.onPressed != null) {
      setState(() => _isPressed = true);
      _controller.forward();
    }
  }

  void _handleTapUp(TapUpDetails details) {
    if (widget.onPressed != null) {
      setState(() => _isPressed = false);
      _controller.reverse();
    }
  }

  void _handleTapCancel() {
    if (widget.onPressed != null) {
      setState(() => _isPressed = false);
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEnabled = widget.onPressed != null;
    final effectiveElevation = widget.elevation ?? (isEnabled ? 6.0 : 0.0);

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Transform.rotate(
            angle: _rotationAnimation.value,
            child: Container(
              width: widget.size,
              height: widget.size,
              decoration: BoxDecoration(
                gradient: widget.useGradient && isEnabled
                    ? (widget.gradient ?? _getDefaultGradient(context))
                    : null,
                color: widget.useGradient || !isEnabled
                    ? null
                    : (widget.backgroundColor ?? context.colors.primary),
                shape: BoxShape.circle,
                boxShadow: widget.useShadow && isEnabled
                    ? [
                        BoxShadow(
                          color: (widget.shadowColor ??
                                  Colors.black.withOpacity(0.2))
                              .withOpacity(_elevationAnimation.value),
                          blurRadius:
                              widget.shadowBlur * _elevationAnimation.value,
                          offset: Offset(0,
                              effectiveElevation * _elevationAnimation.value),
                          spreadRadius: 0,
                        ),
                        if (_isPressed)
                          BoxShadow(
                            color: (widget.shadowColor ??
                                    Colors.black.withOpacity(0.1))
                                .withOpacity(0.5),
                            blurRadius: 20,
                            offset: const Offset(0, 0),
                            spreadRadius: 5,
                          ),
                      ]
                    : null,
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(widget.size / 2),
                  onTap: widget.onPressed,
                  onTapDown: _handleTapDown,
                  onTapUp: _handleTapUp,
                  onTapCancel: _handleTapCancel,
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    child: Center(
                      child: Icon(
                        widget.icon,
                        color: widget.iconColor ?? Colors.white,
                        size: widget.size * 0.4,
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

  Gradient _getDefaultGradient(BuildContext context) {
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        context.colors.primary,
        context.colors.primary.withOpacity(0.8),
        context.colors.accent,
      ],
    );
  }
}
