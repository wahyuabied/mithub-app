import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mithub_app/core/di/service_locator.dart';
import 'package:mithub_app/core/middleware/login_required.dart';
import 'package:mithub_app/core/routing/a_page.dart';
import 'package:mithub_app/core/routing/route_middleware.dart';
import 'package:mithub_app/data/repository/auth_repository.dart';
import 'package:mithub_app/design/widget/loading_dialog.dart';
import 'package:mithub_app/feature/home/homepage.dart';
import 'package:mithub_app/feature/login/input_pin.dart';
import 'package:mithub_app/feature/login/login.dart';
import 'package:mithub_app/feature/onboarding/onboarding_screen.dart';

class AuthRoutes {
  AuthRoutes._();

  static final mainRoutes = [
    onboarding,
    login,
    inputPin,
    main
  ];

  static final onboarding = GoRoute(
    path: '/onboarding',
    name: 'Onboarding',
    pageBuilder: (context, state) => APage(
      key: state.pageKey,
      child: FutureBuilder<bool>(
        future: serviceLocator<AuthRepository>().isLoggedIn(),
        builder: (BuildContext c, AsyncSnapshot<bool> s) {
          if (s.connectionState == ConnectionState.done) {
              return OnboardingScreen(isLogin: s.requireData);
          } else {
            return const Scaffold(body: LoadingDialog());
          }
        },
      ),
    ),
  );

  static final login = GoRoute(
    path: '/login',
    name: 'Login',
    pageBuilder: (context, state) => APage(
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

  static final homepage = GoRoute(
    path: '/',
    name: 'Homepage',
    pageBuilder: (context, state) => APage(
      key: state.pageKey,
      child: const Homepage(selectedPage: 0),
    ),
  );

  static final main = GoRoute(
    path: '/',
    name: 'Homepage',
    redirect: useMiddleware([
      LoginRequired(),
    ]),
    pageBuilder: (context, state) {
      final queryParams = state.uri.queryParameters;
      final page = int.tryParse(queryParams['page'] ?? '') ?? 0;

      return APage(
        key: state.pageKey,
        child: Homepage(
          selectedPage: page,
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
