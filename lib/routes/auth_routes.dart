import 'package:go_router/go_router.dart';
import 'package:mithub_app/core/routing/a_page.dart';
import 'package:mithub_app/login/input_pin.dart';
import 'package:mithub_app/login/login.dart';

class AuthRoutes {
  AuthRoutes._();

  static final mainRoutes = [
    login,
    inputPin,
  ];

  static final login = GoRoute(
    path: '/login',
    name: 'Login',
    pageBuilder: (context, state) =>
        APage(
          key: state.pageKey,
          child: const LoginPhoneScreen(),
        ),
  );

  static final inputPin = GoRoute(
    path: '/input-pin',
    name: 'Input Pin',
    pageBuilder: (context, state) {
      final extra = state.extra as InputPinExtra;

      return APage(
        key: state.pageKey,
        child: InputPinScreen(
          phone: extra.phone,
          authPurpose: extra.authPurpose,
        ),
      );
    },
  );

}

class InputPinExtra {
  InputPinExtra({
    required this.phone,
    this.authPurpose = AuthPurpose.login,
  });

  final String phone;
  final String authPurpose;
}

class AuthPurpose {
  static const login = 'login';
  static const forgotPin = 'forgotPin';
  static const updatePhone = 'updatePhone';
  static const updateNik = 'updateNik';
}