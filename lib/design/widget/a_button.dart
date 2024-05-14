import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mithub_app/design/colors.dart';

/// General button component
class AButton extends StatelessWidget {
  const AButton({
    super.key,
    this.onPressed,
    this.enabled = true,
    this.flat = false,
    required this.variant,
    required this.child,
  });

  /// Button callback
  final VoidCallback? onPressed;

  /// Button variant
  final ButtonVariant variant;

  /// Is button enabled
  final bool enabled;

  /// Is flat type
  ///
  /// Only [ButtonVariant.primary] for now
  final bool flat;

  /// Button child
  final Widget child;

  Widget _buildPrimary(BuildContext context) {
    return ElevatedButton(
      onPressed: enabled ? onPressed : null,
      style: flat
          ? ElevatedButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
      )
          : null,
      child: child,
    );
  }

  Widget _buildSecondary(BuildContext context) {
    return OutlinedButton(
      onPressed: enabled ? onPressed : null,
      child: child,
    );
  }

  Widget _buildSecondaryOutlined(BuildContext context) {
    return ElevatedButton(
      onPressed: enabled ? onPressed : null,
      style: flat
          ? ElevatedButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
      )
          : ElevatedButton.styleFrom(
        disabledBackgroundColor: FunDsColors.neutralSix,
        side: enabled
            ? null
            : BorderSide(
          color: FunDsColors.neutralFive,
          width: 2.h,
        ),
      ),
      child: child,
    );
  }

  Widget _buildTertiary(BuildContext context) {
    return OutlinedButton(
      onPressed: enabled ? onPressed : null,
      style: OutlinedButton.styleFrom(
        side: BorderSide(
          color: FunDsColors.neutral200,
          width: 2.w,
        ),
      ),
      child: child,
    );
  }

  Widget _buildText(BuildContext context) {
    return TextButton(
      onPressed: enabled ? onPressed : null,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (variant) {
      case ButtonVariant.primary:
        return _buildPrimary(context);
      case ButtonVariant.secondary:
        return _buildSecondary(context);
      case ButtonVariant.tertiary:
        return _buildTertiary(context);
      case ButtonVariant.text:
        return _buildText(context);
      case ButtonVariant.primaryWithOutlineWhenDisabled:
        return _buildSecondaryOutlined(context);
    }
  }
}

enum ButtonVariant {
  text,
  primary,
  tertiary,
  secondary,
  primaryWithOutlineWhenDisabled,
}
