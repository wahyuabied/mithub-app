import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mithub_app/core/di/service_locator.dart';
import 'package:mithub_app/data/repository/auth_repository.dart';
import 'package:mithub_app/data/repository/core/login_result.dart';
import 'package:mithub_app/design/colors.dart';
import 'package:mithub_app/design/theme_extension.dart';
import 'package:mithub_app/design/widget/app_bar.dart';
import 'package:mithub_app/design/widget/error_loading_dialog.dart';
import 'package:mithub_app/design/widget/loading_dialog.dart';
import 'package:mithub_app/design/widget/number_keyboard.dart';
import 'package:mithub_app/design/widget/pin_indicator.dart';
import 'package:mithub_app/routes/auth_routes.dart';

class InputPinScreen extends StatefulWidget {
  final String phone;

  const InputPinScreen({
    super.key,
    required this.phone,
  });

  @override
  State<StatefulWidget> createState() => _InputPinScreenState();
}

class _InputPinScreenState extends State<InputPinScreen> {
  static const pinSize = 6;
  final pin = Queue<int>();
  final _authRepo = serviceLocator<AuthRepository>();
  var wrongPinError = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: textAppBar(''),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                top: 20.h,
                left: 20.w,
                right: 20.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.0.h),
                    child: Text(
                      'Masukkan PIN',
                      style: context.textTheme.headlineLarge
                          ?.copyWith(color: context.colorScheme.onBackground),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 32.h),
                    child: const Text(
                        'Pastikan PIN Amartha yang dimasukkan benar.'),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 24..h),
                    child: PinIndicator(
                      length: pinSize,
                      filled: pin.length,
                      isError: wrongPinError,
                    ),
                  ),
                  Visibility(
                    visible: wrongPinError,
                    child: Text(
                      'Maaf PIN salah, coba lagi, ya.',
                      style: context.textTheme.bodyMedium
                          ?.copyWith(color: context.colorScheme.error),
                    ),
                  )
                ],
              ),
            ),
          ),
          Visibility(
            visible: true,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 0),
              child: Row(
                children: [
                  const Text('Lupa PIN? '),
                  InkWell(
                    onTap: () => _onForgotPin(widget.phone, ''),
                    child: const Text(
                      'Klik Disini',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: FunDsColors.primaryBase),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: IntrinsicHeight(
                child: NumberKeyboard(
                  onNumberPressed: (int number) {
                    if (pin.length >= pinSize) return;
                    setState(() => pin.addLast(number));

                    // pin completed
                    if (pin.length == pinSize) {
                      _onPinCompleted(widget.phone, pin);
                    }
                  },
                  onBackPressed: () {
                    if (pin.isEmpty) return;
                    setState(() {
                      pin.removeLast();
                      wrongPinError = false;
                    });
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool getVisibilityByPurpose(String authPurpose) {
    switch (authPurpose) {
      case AuthPurpose.updatePhone:
        return false;
      default:
        return true;
    }
  }

  void _onForgotPin(String phone, authPurpose) async {}

  void _onPinCompleted(String phone, Queue<int> pin) async {
    unawaited(showDialog(
      context: context,
      barrierDismissible: false,
      useRootNavigator: false,
      builder: (context) => const LoadingDialog(),
    ));
    final loginResult = await _authRepo.login(
      phone,
      pin.join(),
    );
    if (!mounted) return;
    Navigator.pop(context);

    if (loginResult is ImmediateLogin) {
      context.goNamed(AuthRoutes.homepage.name!);
    } else {
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
          return ErrorDialog(
            title: 'Maaf, Pin anda salah',
            subtitle:
                'PIN yang anda masukkan salah cek kembali PIN untuk Nomor $phone',
            imageAsset: 'assets/images/error_ibu_amanah_green.png',
            primaryButtonText: 'Daftar Sekarang',
            secondaryButtonText: 'Kembali',
          );
        },
      );
    }
  }
}
