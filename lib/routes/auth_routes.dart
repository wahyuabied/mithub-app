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
import 'package:mithub_app/feature/marketplace/marketplace_page.dart';
import 'package:mithub_app/feature/marketplace/marketplace_detail.dart';
import 'package:mithub_app/feature/onboarding/onboarding_screen.dart';
import 'package:mithub_app/feature/payment/payment_page.dart';
import 'package:mithub_app/feature/scanner/qr_generator_page.dart';
import 'package:mithub_app/feature/scanner/qr_scanner.dart';
import 'package:mithub_app/feature/scanner/qr_scanner_provider.dart';

class AuthRoutes {
  AuthRoutes._();

  static final mainRoutes = [
    onboarding,
    login,
    inputPin,
    main,
    qrScanner,
    qrGeneratorPage,
    marketPlace,
    marketplaceDetailPage,
    paymentPage,
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

  static final qrScanner = GoRoute(
      path: '/qrScanner',
      name: 'QrScanner',
      pageBuilder: (context, state) {
        final extra = state.extra != null
            ? state.extra as QrScannerExtra
            : QrScannerExtra();
        return APage(
          key: state.pageKey,
          child: QrScanner(
            onScanned: extra.onScanned,
            isTransaction: extra.isTransaction,
          ),
        );
      });

  static final qrGeneratorPage = GoRoute(
      path: '/qrGeneratorPage',
      name: 'Qr Generator',
      pageBuilder: (context, state) {
        return APage(
          key: state.pageKey,
          child: const QrGeneratorPage(),
        );
      });

  static final marketPlace = GoRoute(
      path: '/marketPlace',
      name: 'MarketPlace',
      pageBuilder: (context, state) {
        return APage(
          key: state.pageKey,
          child: const MarketplacePage(),
        );
      });

  static final marketplaceDetailPage = GoRoute(
      path: '/marketplaceDetailPage',
      name: 'Marketplace Detail',
      pageBuilder: (context, state) {
        final productId = state.extra as String;
        return APage(
          key: state.pageKey,
          child: MarketplaceDetail(productId: productId),
        );
      });

  static final paymentPage = GoRoute(
      path: '/paymentPage',
      name: 'paymentPage',
      pageBuilder: (context, state) {
        final extra = state.extra as QrPaymentExtra;
        return APage(
          key: state.pageKey,
          child: PaymentPage(extra: extra),
        );
      });
}

class AuthPurpose {
  static const login = 'login';
  static const forgotPin = 'forgotPin';
  static const updatePhone = 'updatePhone';
  static const updateNik = 'updateNik';
}
