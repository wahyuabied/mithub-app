import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mithub_app/core/di/service_locator.dart';
import 'package:mithub_app/core/routing/a_route.dart';

/// Base class to create a redirect middleware
abstract class RouteRedirect {
  ARouter get aRouter => serviceLocator<ARouter>();

  /// Get BuildContext from currently shown route
  /// Use this if you want to show dialog
  BuildContext? getCurrentContext() => aRouter.currentRouteContext();

  /// Get current route [GoRouterState]
  /// Will return null if currently shown screen not a
  /// GoRoute page (Maybe you use Navigator.of(context).push)
  GoRouterState? getCurrentState() => aRouter.currentRouteState();

  /// Process the redirect middleware
  ///
  /// Return [Null] if you want to proceed with the navigation
  /// Return [String] if you want to redirect to other screen
  ///
  /// [context] is above the Navigator, so you cannot use
  /// Navigator function here
  /// If you need to access navigator, use [getCurrentContext] instead
  FutureOr<String?> process(BuildContext context, GoRouterState state);
}

/// Execute middleware before accessing a route
/// The middleware will be executed sequentially
/// Parent route middleware will be executed first, before executing sub route
GoRouterRedirect useMiddleware(List<RouteRedirect> middleware) {
  FutureOr<String?> executeMiddleware(
    BuildContext context,
    GoRouterState state,
  ) async {
    for (var m in middleware) {
      final result = await m.process(context, state);
      if (result != null) {
        return result;
      }
    }

    return null;
  }

  return executeMiddleware;
}
