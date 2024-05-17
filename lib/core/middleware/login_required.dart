import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mithub_app/core/di/service_locator.dart';
import 'package:mithub_app/core/routing/route_middleware.dart';
import 'package:mithub_app/data/repository/auth_repository.dart';
import 'package:mithub_app/routes/auth_routes.dart';

/// Check if a user is logged in or not
/// Redirect to onboarding if not
class LoginRequired extends RouteRedirect {
  final AuthRepository _authRepository = serviceLocator.get();

  @override
  FutureOr<String?> process(BuildContext context, GoRouterState state) async {
    final isLoggedIn = await _authRepository.isLoggedIn();
    if (!isLoggedIn) {
      return state.namedLocation(AuthRoutes.onboarding.name!);
    }

    return null;
  }
}
