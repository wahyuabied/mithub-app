import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mithub_app/design/colors.dart';
import 'package:mithub_app/design/theme_extension.dart';
import 'package:mithub_app/design/widget/animated_visibility.dart';

/// Widget that can be used as phone number input
class PhoneNumberField extends StatefulWidget {
  final TextEditingController phoneNumberController;
  final Function()? onTap;
  final Function()? onTapClear;
  final Function()? onChanged;
  final bool showKeyboard;
  final bool showClear;
  final bool readOnly;

  const PhoneNumberField({
    super.key,
    required this.phoneNumberController,
    this.onTapClear,
    this.onTap,
    this.onChanged,
    this.showKeyboard = false,
    this.showClear = false,
    this.readOnly = true,
  });

  @override
  State<PhoneNumberField> createState() => _PhoneNumberFieldState();
}

class _PhoneNumberFieldState extends State<PhoneNumberField> {
  bool isFilled = false;

  @override
  void initState() {
    super.initState();
    widget.phoneNumberController.addListener(textListener);
  }

  void textListener() {
    widget.onChanged?.call();
    setState(() {
      isFilled = widget.phoneNumberController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    widget.phoneNumberController.removeListener(textListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            keyboardType:
            widget.showKeyboard ? TextInputType.phone : TextInputType.none,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(12)
            ],
            onTap: widget.onTap,
            controller: widget.phoneNumberController,
            showCursor: true,
            readOnly: widget.readOnly,
            decoration: InputDecoration(
              prefixIcon: Text(
                '08',
                style: context.textTheme.headlineLarge?.copyWith(
                  color: context.colorScheme.onBackground,
                ),
              ),
              hintStyle: context.textTheme.headlineLarge
                  ?.copyWith(color: FunDsColors.neutral200),
              prefixIconConstraints: const BoxConstraints(
                minWidth: 0,
                minHeight: 0,
              ),
              prefixStyle: context.textTheme.headlineLarge?.copyWith(
                color: FunDsColors.neutralOne,
              ),
              hintText: '12 3456 7890',
              border: InputBorder.none,
            ),
            style: context.textTheme.headlineLarge?.copyWith(
              color: context.colorScheme.onBackground,
            ),
          ),
        ),
        AnimatedVisibility(
          visible: widget.showClear && isFilled,
          duration: const Duration(milliseconds: 500),
          child: IconButton(
            onPressed: widget.onTapClear,
            icon: const Icon(
              Icons.cancel,
              color: FunDsColors.neutralFive,
            ),
          ),
        ),
      ],
    );
  }
}
