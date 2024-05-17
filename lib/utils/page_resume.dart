import 'package:flutter/material.dart';
import 'package:mithub_app/core/di/service_locator.dart';
import 'package:mithub_app/core/routing/a_route.dart';

/// Widget to add callback when current page is resumed from background
/// Used to refresh data when back from other page
/// or when open the app from background to foreground
///
/// Basically the same with Android onResume callback
class PageResume extends StatefulWidget {
  const PageResume({
    super.key,
    this.handleAppResume = true,
    this.handleRoutePopNext = true,
    required this.onResume,
    required this.child,
  });

  /// Should handle app resume state
  final bool handleAppResume;

  /// Should handle pop from other page
  final bool handleRoutePopNext;

  /// The callback to be called
  final VoidCallback onResume;

  /// Page content
  final Widget child;

  @override
  State<PageResume> createState() => _PageResumeState();
}

class _PageResumeState extends State<PageResume>
    with WidgetsBindingObserver, RouteAware {
  final aRouter = serviceLocator<ARouter>();
  bool isPageActive = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    aRouter.routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    // Handle resume state, this is basicaaly Android onResume
    // It will be executed if the app is shown after it on background
    //
    // But because Flutter is a single activity app,
    // it will not called when the router page changes
    if (state == AppLifecycleState.resumed && widget.handleAppResume) {
      // Only run callback if the page is shown
      // Without this, a page on bottom stack will run the callback and
      // make unnnecessary call
      if (isPageActive) {
        widget.onResume();
      }
    }
  }

  @override
  void didPushNext() {
    super.didPushNext();

    /// Called when pushing another route, and this page is inactive
    isPageActive = false;
  }

  @override
  void didPopNext() {
    super.didPopNext();

    /// Called when pop a route, and this page is the next destination
    isPageActive = true;

    if (widget.handleRoutePopNext) {
      widget.onResume();
    }
  }

  @override
  void dispose() {
    aRouter.routeObserver.unsubscribe(this);
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
