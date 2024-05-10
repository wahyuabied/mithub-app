import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mithub_app/core/di/service_locator.dart';
import 'package:mithub_app/core/routing/a_page.dart';

class ARouter {
  GlobalKey<NavigatorState> get _navigatorKey => serviceLocator();

  final rootSheelNavigatorKey = GlobalKey<NavigatorState>();

  final routeObserver = ARouteObserver();

  /// Refresh current route
  void refresh() {
    final context = _navigatorKey.currentContext;
    if (context != null) {
      GoRouter.of(context).refresh();
    }
  }

  /// Get GoRouter instance without context
  /// Prefer use context.goNamed or context.pushNamed if you
  GoRouter? getRouter() {
    final context = _navigatorKey.currentContext;
    if (context != null) {
      return GoRouter.of(context);
    }
    return null;
  }

  /// Get [BuildContext] from currently shown route
  /// Usually you need to use this function to show modal
  /// inside redirect middleware
  BuildContext? currentRouteContext() =>
      routeObserver.currentRoute?.subtreeContext;

  /// Get current route [GoRouterState]
  /// Usually you need to use this to get current screen state inside a
  /// redirect middleware
  ///
  /// Will return null if currently shown screen not a GoRoute page
  /// (Maybe you use Navigator.of(context).push())
  GoRouterState? currentRouteState() {
    try {
      final context = routeObserver.currentRoute?.subtreeContext;
      if (context != null) {
        return GoRouterState.of(context);
      }

      return null;
    } on Error {
      return null;
    }
  }
}

/// Route observer for the GoRouter
/// It also listen to currently shown route and store it
class ARouteObserver extends RouteObserver<ModalRoute> {
  PageRoute? currentRoute;

  @override
  void didPush(Route route, Route? previousRoute) {
    if (route is PageRoute) {
      onPageChanged(route);
    }

    super.didPush(route, previousRoute);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    if (previousRoute is PageRoute) {
      onPageChanged(previousRoute);
    }

    super.didPop(route, previousRoute);
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    if (newRoute is PageRoute) {
      onPageChanged(newRoute);
    }

    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    if (previousRoute is PageRoute) {
      onPageChanged(previousRoute);
    }

    super.didRemove(route, previousRoute);
  }

  void onPageChanged(PageRoute route) {
    currentRoute = route;

    if (route is APageRoute) {
      route.goRouterState;
    }
  }
}
