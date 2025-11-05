import 'package:flutter/material.dart';
import 'package:mapping/core/core.dart';

enum AppButtonVariant { primary, secondary, outline, text }

class AppButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String title;
  final AppButtonVariant variant;
  final bool isLoading;
  final Widget? leading;
  final Widget? trailing;
  final bool fullWidth;

  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final TextStyle? titleStyle;
  final Color? background;
  final Color? foreground;

  const AppButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.isLoading = false,
    this.leading,
    this.trailing,
    this.fullWidth = true,
    this.borderRadius = 10,
    this.padding = const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
    this.titleStyle,
    this.background,
    this.foreground,
  });

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    // Dynamic theme-based color logic
    final bg =
        background ??
        switch (variant) {
          AppButtonVariant.primary => color.primary,
          AppButtonVariant.secondary => color.secondary,
          AppButtonVariant.outline => Colors.transparent,
          AppButtonVariant.text => Colors.transparent,
        };

    final fg =
        foreground ??
        switch (variant) {
          AppButtonVariant.primary => color.onPrimary,
          AppButtonVariant.secondary => color.onSecondary,
          AppButtonVariant.outline => color.primary,
          AppButtonVariant.text => color.primary,
        };

    final border = variant == AppButtonVariant.outline
        ? BorderSide(color: fg, width: 1.4)
        : BorderSide.none;

    Widget child = isLoading
        ? Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                width: AppSize.radiusMedium * 2,
                height: AppSize.radiusMedium * 2,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
              const SizedBox(width: AppSize.radiusMedium),
              Text("Please wait...", style: titleStyle ?? TextStyle(color: fg)),
            ],
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (leading != null) ...[leading!, const SizedBox(width: 8)],
              Text(title, style: titleStyle ?? TextStyle(color: fg)),
              if (trailing != null) ...[const SizedBox(width: 8), trailing!],
            ],
          );

    return SizedBox(
      width: fullWidth ? double.infinity : null,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: bg,
          foregroundColor: fg,
          elevation: variant == AppButtonVariant.text ? 0 : (isLoading ? 0 : 4),
          padding: padding,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: border,
          ),
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: child,
        ),
      ),
    );
  }
}
