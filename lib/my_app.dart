import 'dart:async';

import 'package:alice/alice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mithub_app/core/di/service_locator.dart';
import 'package:mithub_app/core/event_bus/event_bus_listener.dart';
import 'package:mithub_app/core/event_bus/general_ui_event.dart';
import 'package:mithub_app/core/notification/notification_data.dart';
import 'package:mithub_app/core/notification/notification_route.dart';
import 'package:mithub_app/core/routing/a_route.dart';
import 'package:mithub_app/design/theme.dart';
import 'package:mithub_app/routes/auth_routes.dart';
import 'package:upgrader/upgrader.dart';

class MyApp extends StatefulWidget {
  final StreamController<NotificationData> notificationStream;

  const MyApp({super.key, required this.notificationStream});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  final Alice httpInspector = serviceLocator.get();
  final ARouter aRouter = serviceLocator.get();
  final GlobalKey<NavigatorState> navigatorKey = serviceLocator.get();
  late StreamSubscription _notifStream;

  @override
  void initState() {
    super.initState();
    configNotificationListener();
  }

  void configNotificationListener() {
    _notifStream = widget.notificationStream.stream.listen((event) {
      NotificationRoute.getRoute(event, context);
    });
  }

  late final goRouter = GoRouter(
    initialLocation: '/onboarding',
    routes: [
      ShellRoute(
        observers: [
          aRouter.routeObserver,
        ],
        navigatorKey: aRouter.rootSheelNavigatorKey,
        builder: (context, state, child) => child,
        routes: AuthRoutes.mainRoutes,
      ),
    ],
    navigatorKey: navigatorKey,
  );

  void handleGeneralUIEvent(BuildContext context, dynamic event) {
    if (event is UIShowSnackbar) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(event.message),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      designSize: const Size(360, 640),
      splitScreenMode: false,
      useInheritedMediaQuery: true,
      builder: (ctx, child) {
        return MaterialApp.router(
          routerConfig: goRouter,
          themeMode: ThemeMode.system,
          theme: funDsTheme(context),
          builder: (context, widget) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: UpgradeAlert(
                child: EventBusListener(
                  onEvent: (event) {
                    handleGeneralUIEvent(context, event);
                  },
                  child: widget!,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
