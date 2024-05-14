import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mithub_app/core/di/service_locator.dart';
import 'package:mithub_app/data/repository/auth_repository.dart';
import 'package:mithub_app/design/colors.dart';
import 'package:mithub_app/design/theme_extension.dart';
import 'package:mithub_app/design/widget/app_bar.dart';
import 'package:mithub_app/design/widget/error_loading_dialog.dart';
import 'package:mithub_app/design/widget/loading_dialog.dart';
import 'package:mithub_app/design/widget/number_keyboard.dart';
import 'package:mithub_app/design/widget/phone_number_field.dart';
import 'package:mithub_app/routes/auth_routes.dart';

class LoginPhoneScreen extends StatefulWidget {
  const LoginPhoneScreen({super.key});

  @override
  State<LoginPhoneScreen> createState() => _LoginPhoneScreenState();
}

class _LoginPhoneScreenState extends State<LoginPhoneScreen> {
  final authRepository = serviceLocator.get<AuthRepository>();
  final phoneNumberController = TextEditingController();
  static const prefix = '08';
  static const minPhoneNumberLength = 7;
  static const maxPhoneNumberLength = 14;
  static const phoneNumberSpacerInterval = 4;

  var showNumberKeyboard = true;
  var phoneNumber = '';
  var enableLoginButton = false;

  String get completePhoneNumber => prefix + phoneNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: textAppBar('Masuk'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 16.h,
                horizontal: 20.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.h),
                    child: Text(
                      'Masukkan Nomor HP',
                      style: context.textTheme.titleLarge,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 24.h),
                    child: const Text(
                      '''Silakan masuk dengan nomor HP yang aktif dan terdaftar, ya.''',
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.h),
                    child: Text(
                      'Nomor HP *',
                      style: context.textTheme.titleSmall,
                    ),
                  ),
                  PhoneNumberField(
                    phoneNumberController: phoneNumberController,
                    onTap: () {
                      if (!showNumberKeyboard) {
                        setState(() {
                          showNumberKeyboard = true;
                        });
                      }
                    },
                  ),
                  Visibility(
                    visible: !showNumberKeyboard,
                    child: Expanded(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ElevatedButton(
                              onPressed:
                              enableLoginButton ? onClickLoginButton : null,
                              child: const Text('Masuk'),
                            ),
                            TextButton(
                              onPressed: () {

                              },
                              child: const Text('Butuh Bantuan?'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: showNumberKeyboard,
            child: NumberKeyboard(
              onNumberPressed: onKeyboardNumberPressed,
              onBackPressed: onKeyboardBackPressed,
              variant: NumberKeyboardVariant.finishBar,
              onFinishPressed: () {
                setState(() {
                  showNumberKeyboard = false;
                });
              },
            ),
          )
        ],
      ),
    );
  }

  void onClickLoginButton() async {
    unawaited(showDialog(
      context: context,
      barrierDismissible: false,
      useRootNavigator: false,
      builder: (context) => const LoadingDialog(),
    ));
    final phone = completePhoneNumber;

    final isRegistered = await authRepository.checkPhoneIsRegistered(phone);

    if (!mounted) return;
    Navigator.pop(context);

    if (isRegistered) {
      unawaited(context.pushNamed(
        AuthRoutes.inputPin.name!,
        extra: InputPinExtra(
          phone: phone,
        ),
      ));
    } else {
      _showErrorDialog(context);
    }
  }

  void _showErrorDialog(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: FunDsColors.white,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12.r),
          topRight: Radius.circular(12.r),
        ),
      ),
      builder: (BuildContext context) {
        return const ErrorDialog(
          title: 'Maaf, Anda belum punya akun',
          subtitle:
          '''Nomor ini belum terdaftar di AmarthaFin. Yuk daftar untuk bisa masuk!''',
          imageAsset: 'assets/images/error_ibu_amanah_green.png',
          primaryButtonText: 'Daftar Sekarang',
          secondaryButtonText: 'Kembali',
        );
      },
    );
  }

  void onKeyboardNumberPressed(int num) {
    if (completePhoneNumber.length >= maxPhoneNumberLength) return;
    phoneNumber += num.toString();

    updatePhoneNumberField();
    updateButtonState();
  }

  void onKeyboardBackPressed() {
    if (phoneNumber.isEmpty) return;
    phoneNumber = phoneNumber.replaceRange(phoneNumber.length - 1, null, '');

    updatePhoneNumberField();
    updateButtonState();
  }

  void updatePhoneNumberField() {
    var formatted = readablePhoneNumber();
    phoneNumberController.value = TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(
        offset: formatted.length,
      ),
    );
  }

  /// format [phoneNumber] to readable phone format
  /// ex: 1234567890 => 1234 5678 90
  String readablePhoneNumber() {
    if (phoneNumber.isEmpty) return '';

    final split = completePhoneNumber.split('');
    var counter = 1;
    final formattedWithSpace = split.reduce((value, element) {
      counter++;
      final spacer = (counter % phoneNumberSpacerInterval == 0) ? ' ' : '';
      return value + element + spacer;
    });
    // remove Prefix 08
    return formattedWithSpace.replaceFirst('08', '');
  }

  void updateButtonState() =>
      enableLoginButton = completePhoneNumber.length > minPhoneNumberLength;
}
