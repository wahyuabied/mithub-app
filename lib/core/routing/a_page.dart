import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mithub_app/core/routing/page_wrapper.dart';

/// Base page for all amartha page
/// Based on [MaterialPage] with minimal change
class APage<T> extends Page<T> {
  const APage({
    this.maintainState = true,
    this.fullscreenDialog = false,
    required super.key,
    required this.child,
    super.name,
    super.arguments,
    super.restorationId,
  });

  /// The content to be shown in the [Route] created by this page.
  final Widget child;

  /// {@macro flutter.widgets.ModalRoute.maintainState}
  final bool maintainState;

  /// {@macro flutter.widgets.PageRoute.fullscreenDialog}
  final bool fullscreenDialog;

  @override
  Route<T> createRoute(BuildContext context) {
    return APageRoute<T>(page: this);
  }
}

class APageRoute<T> extends PageRoute<T> with MaterialRouteTransitionMixin<T> {
  APageRoute({
    required APage<T> page,
  }) : super(settings: page) {
    assert(opaque);
  }

  APage<T> get _page => settings as APage<T>;

  Future<GoRouterState?> get goRouterState {
    // Using future because we need to wait until the page is built
    return Future.microtask(() {
      final context = subtreeContext;
      if (context != null) {
        try {
          return GoRouterState.of(context);
        } catch (e) {
          return null;
        }
      }
      return null;
    });
  }

  @override
  Widget buildContent(BuildContext context) {
    // Wrap Child with PageWrapper
    return PageWrapper(child: _page.child);
  }

  @override
  bool get maintainState => _page.maintainState;

  @override
  bool get fullscreenDialog => _page.fullscreenDialog;

  @override
  String get debugLabel => '${super.debugLabel}(${_page.name})';
}
