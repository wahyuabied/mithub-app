import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mithub_app/design/colors.dart';
import 'package:mithub_app/design/theme_extension.dart';
import 'package:mithub_app/design/widget/a_button.dart';

class NumberKeyboard extends StatelessWidget {
  final void Function(int num) onNumberPressed;
  final void Function() onBackPressed;
  final void Function()? onFinishPressed;
  final void Function()? onThousandPressed;
  final NumberKeyboardVariant variant;
  final Color? color;
  final EdgeInsets? padding;
  final double opacity;
  final bool enableThousandButton;
  final bool enableFinishButton;

  const NumberKeyboard({
    super.key,
    required this.onNumberPressed,
    required this.onBackPressed,
    this.onFinishPressed,
    this.onThousandPressed,
    this.variant = NumberKeyboardVariant.numberOnly,
    this.color,
    this.padding,
    this.opacity = 0,
    this.enableThousandButton = false,
    this.enableFinishButton = false,
  });

  factory NumberKeyboard.controller({
    required TextEditingController controller,
    Function()? onFinishPressed,
    NumberKeyboardVariant variant = NumberKeyboardVariant.numberOnly,
    Color? color,
  }) {
    return NumberKeyboard(
      onFinishPressed: onFinishPressed,
      onNumberPressed: (int num) {
        final text = '${controller.text}$num';
        controller.value = TextEditingValue(
          text: text,
          selection: TextSelection.collapsed(offset: text.length),
        );
      },
      onBackPressed: () {
        var text = controller.text;
        if (text.isEmpty) return;
        text = text.substring(0, text.length - 1);
        controller.value = TextEditingValue(
          text: text,
          selection: TextSelection.collapsed(offset: text.length),
        );
      },
      variant: variant,
      color: color,
    );
  }

  @override
  Widget build(BuildContext context) {
    EdgeInsets keyboardPadding;
    bool showFinishBar;
    bool largeButton;

    switch (variant) {
      case NumberKeyboardVariant.numberOnly:
        keyboardPadding = padding ??
            EdgeInsets.symmetric(
              vertical: 8.h,
              horizontal: 20.w,
            );
        showFinishBar = false;
        largeButton = true;
        break;
      case NumberKeyboardVariant.finishBar:
        keyboardPadding = padding ??
            EdgeInsets.symmetric(
              vertical: 12.h,
              horizontal: 24.w,
            );
        showFinishBar = true;
        largeButton = false;
        break;
    }

    return DecoratedBox(
      decoration: BoxDecoration(color: Colors.white.withOpacity(opacity)),
      child: Column(
        children: [
          Visibility(
            visible: showFinishBar,
            child: enableFinishButton ? Padding(
              padding: const EdgeInsets.only(
                  bottom: 10,
                  top: 20,
                  left: 20,
                  right: 20
              ),
              child: SizedBox(
                width: double.infinity,
                height: 44.h,
                child: AButton(
                    enabled: true,
                    variant: ButtonVariant.primary,
                    child: Text(
                      'Selesai',
                      style: context.textTheme.bodyMedium?.copyWith(
                          fontSize: 14.sp,
                          color: FunDsColors.white,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    onPressed: () {
                      onFinishPressed?.call();
                    }),
              ),
            ) :
            Column(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 8.h,
                      horizontal: 32.w,
                    ),
                    child: TextButton(
                      onPressed: () {
                        onFinishPressed?.call();
                      },
                      child: Text(
                        'Selesai',
                        style: context.textTheme.titleSmall?.copyWith(
                          color: context.colorScheme.primary,
                        ),
                      ),
                    ),
                  ),
                ),
                const Divider(height: 0),
              ],
            ),
          ),
          Padding(
            padding: keyboardPadding,
            child: Column(
              children: [
                _InputRow(
                  children: [
                    _NumberButton(
                      1,
                      onNumberPressed,
                      enlarge: largeButton,
                      color: color,
                    ),
                    _NumberButton(
                      2,
                      onNumberPressed,
                      enlarge: largeButton,
                      color: color,
                    ),
                    _NumberButton(
                      3,
                      onNumberPressed,
                      enlarge: largeButton,
                      color: color,
                    ),
                  ],
                ),
                _InputRow(
                  children: [
                    _NumberButton(
                      4,
                      onNumberPressed,
                      enlarge: largeButton,
                      color: color,
                    ),
                    _NumberButton(
                      5,
                      onNumberPressed,
                      enlarge: largeButton,
                      color: color,
                    ),
                    _NumberButton(
                      6,
                      onNumberPressed,
                      enlarge: largeButton,
                      color: color,
                    ),
                  ],
                ),
                _InputRow(
                  children: [
                    _NumberButton(
                      7,
                      onNumberPressed,
                      enlarge: largeButton,
                      color: color,
                    ),
                    _NumberButton(
                      8,
                      onNumberPressed,
                      enlarge: largeButton,
                      color: color,
                    ),
                    _NumberButton(
                      9,
                      onNumberPressed,
                      enlarge: largeButton,
                      color: color,
                    ),
                  ],
                ),
                _InputRow(
                  children: [
                    enableThousandButton ? _ThousandButton(
                      onThousandPressed ?? () {},
                      enlarge: largeButton,
                      color: color,
                      isThousandButton: true,
                    ) : Expanded(child: Container()),
                    _NumberButton(
                      0,
                      onNumberPressed,
                      enlarge: largeButton,
                      color: color,
                    ),
                    _BackspaceButton(
                      onBackPressed,
                      color: color,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NumberButton extends StatelessWidget {
  final void Function(int) onNumberPressed;
  final int num;
  final bool enlarge;
  final Color? color;

  const _NumberButton(
      this.num,
      this.onNumberPressed, {
        this.enlarge = false,
        this.color = Colors.black,
      });

  @override
  Widget build(BuildContext context) {
    final textStyle = context.textTheme.headlineSmall;
    return Expanded(
      child: SizedBox(
        height: enlarge ? 64.h : null,
        child: TextButton(
          onPressed: () {
            onNumberPressed(num);
          },
          child: Text(
            num.toString(),
            style: textStyle!.copyWith(color: color),
          ),
        ),
      ),
    );
  }
}

class _ThousandButton extends StatelessWidget {
  final void Function() onThousandPressed;
  final bool enlarge;
  final Color? color;
  final bool isThousandButton;

  const _ThousandButton(
      this.onThousandPressed, {
        this.enlarge = false,
        this.color = Colors.black,
        this.isThousandButton = false
      });

  @override
  Widget build(BuildContext context) {
    final textStyle = context.textTheme.headlineSmall;
    return Expanded(
      child: SizedBox(
        height: enlarge ? 64.h : null,
        child: TextButton(
          onPressed: () {
            onThousandPressed();
          },
          child: Text(
            '000',
            style: textStyle!.copyWith(color: color),
          ),
        ),
      ),
    );
  }
}

class _BackspaceButton extends StatelessWidget {
  final void Function() onBackPressed;
  final Color? color;

  const _BackspaceButton(
      this.onBackPressed, {
        this.color,
      });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: IconButton(
        onPressed: onBackPressed,
        highlightColor: context.colorScheme.secondary,
        icon: Icon(
          Icons.backspace_outlined,
          color: color ?? context.colorScheme.onBackground,
        ),
      ),
    );
  }
}

class _InputRow extends StatelessWidget {
  final List<Widget> children;

  const _InputRow({required this.children});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: children,
    );
  }
}

enum NumberKeyboardVariant {
  /// only number, buttons are slightly bigger
  numberOnly,

  /// has finish bar with its own callback
  finishBar;
}
