import 'package:go_router/go_router.dart';
import 'package:mithub_app/core/routing/a_page.dart';
import 'package:mithub_app/feature/login/input_pin.dart';
import 'package:mithub_app/feature/login/login.dart';
import 'package:mithub_app/feature/onboarding/onboarding_screen.dart';

class AuthRoutes {
  AuthRoutes._();

  static final mainRoutes = [
    onboarding,
    login,
    inputPin,
  ];

  static final onboarding = GoRoute(
    path: '/onboarding',
    name: 'Onboarding',
    pageBuilder: (context, state) =>
        APage(
          key: state.pageKey,
          child: const OnboardingScreen(),
        ),
  );

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
      return APage(
        key: state.pageKey,
        child: InputPinScreen(
          phone: state.uri.queryParameters['phone'] as String,
        ),
      );
    },
  );
}

class AuthPurpose {
  static const login = 'login';
  static const forgotPin = 'forgotPin';
  static const updatePhone = 'updatePhone';
  static const updateNik = 'updateNik';
}