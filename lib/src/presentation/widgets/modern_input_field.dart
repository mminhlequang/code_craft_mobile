import 'package:flutter/material.dart';
import 'package:internal_core/internal_core.dart';

import '../../constants/constants.dart';

class ModernInputField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String? hint;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final TextInputType? keyboardType;
  final bool obscureText;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final int? maxLines;
  final bool enabled;
  final bool isRequired;
  final Color? borderColor;
  final Color? focusColor;

  const ModernInputField({
    super.key,
    required this.controller,
    required this.label,
    this.hint,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.obscureText = false,
    this.validator,
    this.onChanged,
    this.maxLines = 1,
    this.enabled = true,
    this.isRequired = false,
    this.borderColor,
    this.focusColor,
  });

  @override
  State<ModernInputField> createState() => _ModernInputFieldState();
}

class _ModernInputFieldState extends State<ModernInputField>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _focusAnimation;
  late Animation<double> _scaleAnimation;
  late FocusNode _focusNode;
  bool _isFocused = false;
  bool _isObscured = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _focusAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.02,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));
    _focusNode = FocusNode();
    _isObscured = widget.obscureText;

    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
      if (_isFocused) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Container(
            margin: const EdgeInsets.only(bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Label
                Padding(
                  padding: const EdgeInsets.only(bottom: 8, left: 4),
                  child: Row(
                    children: [
                      if (widget.prefixIcon != null) ...[
                        Icon(
                          widget.prefixIcon,
                          size: 16,
                          color: _isFocused
                              ? (widget.focusColor ?? context.colors.primary)
                              : context.colors.textSecondary,
                        ),
                        const SizedBox(width: 8),
                      ],
                      Text(
                        widget.label,
                        style: context.styles.labelMedium.copyWith(
                          color: _isFocused
                              ? (widget.focusColor ?? context.colors.primary)
                              : context.colors.textSecondary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (widget.isRequired) ...[
                        const SizedBox(width: 4),
                        Text(
                          '*',
                          style: context.styles.labelMedium.copyWith(
                            color: context.colors.error,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),

                // Input Container
                Container(
                  decoration: BoxDecoration(
                    gradient: _isFocused
                        ? LinearGradient(
                            colors: [
                              (widget.focusColor ?? context.colors.primary)
                                  .withOpacity(0.1),
                              (widget.focusColor ?? context.colors.primary)
                                  .withOpacity(0.05),
                            ],
                          )
                        : null,
                    color: _isFocused ? null : context.colors.surfaceVariant,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: _isFocused
                          ? (widget.focusColor ?? context.colors.primary)
                          : (widget.borderColor ?? context.colors.divider),
                      width: _isFocused ? 2 : 1,
                    ),
                    boxShadow: _isFocused
                        ? [
                            BoxShadow(
                              color:
                                  (widget.focusColor ?? context.colors.primary)
                                      .withOpacity(0.2),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ]
                        : [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 4,
                              offset: const Offset(0, 1),
                            ),
                          ],
                  ),
                  child: TextFormField(
                    controller: widget.controller,
                    focusNode: _focusNode,
                    keyboardType: widget.keyboardType,
                    obscureText: _isObscured,
                    maxLines: widget.maxLines,
                    enabled: widget.enabled,
                    validator: widget.validator,
                    onChanged: widget.onChanged,
                    style: context.styles.bodyMedium.copyWith(
                      color: context.colors.text,
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: InputDecoration(
                      hintText: widget.hint,
                      hintStyle: context.styles.bodyMedium.copyWith(
                        color: context.colors.textSecondary.withOpacity(0.7),
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
                      suffixIcon: widget.obscureText
                          ? IconButton(
                              onPressed: () {
                                setState(() {
                                  _isObscured = !_isObscured;
                                });
                              },
                              icon: Icon(
                                _isObscured
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: context.colors.textSecondary,
                                size: 20,
                              ),
                            )
                          : widget.suffixIcon != null
                              ? Icon(
                                  widget.suffixIcon,
                                  color: context.colors.textSecondary,
                                  size: 20,
                                )
                              : null,
                    ),
                  ),
                ),

                // Animated underline
                if (_isFocused)
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: 2,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          (widget.focusColor ?? context.colors.primary),
                          (widget.focusColor ?? context.colors.primary)
                              .withOpacity(0.7),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(1),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ModernDropdownField extends StatefulWidget {
  final String label;
  final String? hint;
  final IconData? prefixIcon;
  final List<String> options;
  final String? value;
  final Function(String?) onChanged;
  final String? Function(String?)? validator;
  final bool isRequired;
  final Color? borderColor;
  final Color? focusColor;

  const ModernDropdownField({
    super.key,
    required this.label,
    this.hint,
    this.prefixIcon,
    required this.options,
    this.value,
    required this.onChanged,
    this.validator,
    this.isRequired = false,
    this.borderColor,
    this.focusColor,
  });

  @override
  State<ModernDropdownField> createState() => _ModernDropdownFieldState();
}

class _ModernDropdownFieldState extends State<ModernDropdownField>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _focusAnimation;
  late Animation<double> _scaleAnimation;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _focusAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.02,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
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
          child: Container(
            margin: const EdgeInsets.only(bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Label
                Padding(
                  padding: const EdgeInsets.only(bottom: 8, left: 4),
                  child: Row(
                    children: [
                      if (widget.prefixIcon != null) ...[
                        Icon(
                          widget.prefixIcon,
                          size: 16,
                          color: _isFocused
                              ? (widget.focusColor ?? context.colors.primary)
                              : context.colors.textSecondary,
                        ),
                        const SizedBox(width: 8),
                      ],
                      Text(
                        widget.label,
                        style: context.styles.labelMedium.copyWith(
                          color: _isFocused
                              ? (widget.focusColor ?? context.colors.primary)
                              : context.colors.textSecondary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (widget.isRequired) ...[
                        const SizedBox(width: 4),
                        Text(
                          '*',
                          style: context.styles.labelMedium.copyWith(
                            color: context.colors.error,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),

                // Dropdown Container
                Container(
                  decoration: BoxDecoration(
                    gradient: _isFocused
                        ? LinearGradient(
                            colors: [
                              (widget.focusColor ?? context.colors.primary)
                                  .withOpacity(0.1),
                              (widget.focusColor ?? context.colors.primary)
                                  .withOpacity(0.05),
                            ],
                          )
                        : null,
                    color: _isFocused ? null : context.colors.surfaceVariant,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: _isFocused
                          ? (widget.focusColor ?? context.colors.primary)
                          : (widget.borderColor ?? context.colors.divider),
                      width: _isFocused ? 2 : 1,
                    ),
                    boxShadow: _isFocused
                        ? [
                            BoxShadow(
                              color:
                                  (widget.focusColor ?? context.colors.primary)
                                      .withOpacity(0.2),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ]
                        : [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 4,
                              offset: const Offset(0, 1),
                            ),
                          ],
                  ),
                  child: DropdownButtonFormField<String>(
                    value: widget.value,
                    onChanged: (value) {
                      setState(() {
                        _isFocused = false;
                      });
                      _animationController.reverse();
                      widget.onChanged(value);
                    },
                    onTap: () {
                      setState(() {
                        _isFocused = true;
                      });
                      _animationController.forward();
                    },
                    decoration: InputDecoration(
                      hintText: widget.hint,
                      hintStyle: context.styles.bodyMedium.copyWith(
                        color: context.colors.textSecondary.withOpacity(0.7),
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
                      suffixIcon: Icon(
                        Icons.keyboard_arrow_down,
                        color: context.colors.textSecondary,
                        size: 20,
                      ),
                    ),
                    style: context.styles.bodyMedium.copyWith(
                      color: context.colors.text,
                      fontWeight: FontWeight.w500,
                    ),
                    dropdownColor: context.colors.surface,
                    items: widget.options.map((String option) {
                      return DropdownMenuItem<String>(
                        value: option,
                        child: Text(option),
                      );
                    }).toList(),
                    validator: widget.validator,
                  ),
                ),

                // Animated underline
                if (_isFocused)
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: 2,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          (widget.focusColor ?? context.colors.primary),
                          (widget.focusColor ?? context.colors.primary)
                              .withOpacity(0.7),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(1),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
