import 'package:flutter/material.dart';
import 'package:internal_core/internal_core.dart';

import '../../constants/constants.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
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

  const CustomAppBar({
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
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        gradient: useGradient ? context.colors.primaryGradient : null,
        color: useGradient ? null : (backgroundColor ?? context.colors.surface),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: AppSizes.paddingMedium),
          child: Row(
            children: [
              // Leading Widget
              if (leading != null)
                leading!
              else if (showBackButton)
                AnimatedContainer(
                  duration: AppStyles.instance.animationFast,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius:
                          BorderRadius.circular(AppSizes.radiusMedium),
                      onTap: onBackPressed ?? () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(AppSizes.paddingSmall),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius:
                              BorderRadius.circular(AppSizes.radiusMedium),
                        ),
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          color:
                              useGradient ? Colors.white : context.colors.text,
                          size: AppSizes.iconMedium,
                        ),
                      ),
                    ),
                  ),
                ),

              // Title
              Expanded(
                child: centerTitle
                    ? Center(
                        child: AnimatedDefaultTextStyle(
                          duration: AppStyles.instance.animationFast,
                          style: context.styles.headlineSmall.copyWith(
                            color: useGradient
                                ? Colors.white
                                : context.colors.text,
                            fontWeight: FontWeight.bold,
                          ),
                          child: Text(title),
                        ),
                      )
                    : Padding(
                        padding:
                            const EdgeInsets.only(left: AppSizes.paddingMedium),
                        child: AnimatedDefaultTextStyle(
                          duration: AppStyles.instance.animationFast,
                          style: context.styles.headlineSmall.copyWith(
                            color: useGradient
                                ? Colors.white
                                : context.colors.text,
                            fontWeight: FontWeight.bold,
                          ),
                          child: Text(title),
                        ),
                      ),
              ),

              // Actions
              if (actions != null)
                ...actions!.map((action) => Padding(
                      padding:
                          const EdgeInsets.only(left: AppSizes.paddingSmall),
                      child: action,
                    )),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}

class CustomSliverAppBar extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: expandedHeight,
      floating: floating,
      pinned: pinned,
      backgroundColor:
          useGradient ? null : (backgroundColor ?? context.colors.surface),
      elevation: 0,
      leading: leading ??
          (showBackButton
              ? AnimatedContainer(
                  duration: AppStyles.instance.animationFast,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius:
                          BorderRadius.circular(AppSizes.radiusMedium),
                      onTap: onBackPressed ?? () => Navigator.pop(context),
                      child: Container(
                        margin: const EdgeInsets.all(AppSizes.paddingSmall),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius:
                              BorderRadius.circular(AppSizes.radiusMedium),
                        ),
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          color:
                              useGradient ? Colors.white : context.colors.text,
                          size: AppSizes.iconMedium,
                        ),
                      ),
                    ),
                  ),
                )
              : null),
      actions: actions,
      flexibleSpace: FlexibleSpaceBar(
        title: AnimatedDefaultTextStyle(
          duration: AppStyles.instance.animationFast,
          style: context.styles.headlineMedium.copyWith(
            color: useGradient ? Colors.white : context.colors.text,
            fontWeight: FontWeight.bold,
          ),
          child: Text(title),
        ),
        centerTitle: true,
        background: useGradient
            ? Container(
                decoration: BoxDecoration(
                  gradient: context.colors.primaryGradient,
                ),
              )
            : null,
      ),
    );
  }
}
