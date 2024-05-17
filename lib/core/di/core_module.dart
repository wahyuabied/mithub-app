import 'dart:io';

import 'package:alice/alice.dart';
import 'package:firebase_in_app_messaging/firebase_in_app_messaging.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:http_interceptor/http/intercepted_client.dart';
import 'package:mithub_app/core/di/service_locator.dart';
import 'package:mithub_app/core/event_bus/event_bus.dart';
import 'package:mithub_app/core/network/auth_interceptor.dart';
import 'package:mithub_app/core/network/core_http_repository.dart';
import 'package:mithub_app/core/network/http/core_http_builder.dart';
import 'package:mithub_app/core/network/http_inspector.dart';
import 'package:mithub_app/core/routing/a_route.dart';
import 'package:mithub_app/core/storage/core_secure_storage.dart';
import 'package:package_info_plus/package_info_plus.dart';

// DI module where core dependencies is being put in one place
// If the module become huge, we need to split this into several DI modules
class CoreModule {
  GlobalKey<NavigatorState> navigatorKey() => GlobalKey();
  HttpInspector aliceHttpInspector() {
    return HttpInspector(
      Alice(
        navigatorKey: serviceLocator.get(),
        showNotification: false,
        showShareButton: true,
        showInspectorOnShake: false,
      ),
    );
  }

  Alice alice() {
    return Alice(
      navigatorKey: serviceLocator.get(),
      showNotification: false,
      showShareButton: true,
      showInspectorOnShake: false,
    );
  }

  Future<Map<String, String>> defaultHttpHeaders() async {
    final packageInfo = await PackageInfo.fromPlatform();
    return Map.unmodifiable({
      'X-App-Version': packageInfo.buildNumber,
      'X-App-Name': 'amarthafin-flutter',
      'X-App-OS': Platform.operatingSystem,
      HttpHeaders.contentTypeHeader: 'application/json',
    });
  }

  EventBus eventBus() => EventBus();

  CoreHttpRepository coreHttpRepository(CoreSecureStorage coreSecureStorage) {
    return CoreHttpRepository(coreSecureStorage);
  }

  CoreHttpBuilder coreHttpBuilder(
      Map<String, String> defaultHeaders,
      Alice httpInspector,
      CoreHttpRepository coreHttpRepository,
      AuthInterceptor interceptor,
      ) {
    return CoreHttpBuilder(
      defaultHeaders: defaultHeaders,
      coreClient: () => InterceptedClient.build(
        interceptors: [
          interceptor,
        ],
      ),
      httpInspector: httpInspector,
      coreHttpRepository: coreHttpRepository,
    );
  }

  CoreSecureStorage coreSecureStorage() => CoreSecureStorage.defaultInstance;

  FirebaseMessaging firebaseMessaging() => FirebaseMessaging.instance;

  FirebaseInAppMessaging firebaseInAppMessaging() =>
      FirebaseInAppMessaging.instance;

  ARouter aRouter() => ARouter();

  static const _defaultHeaders = 'defaultHeaders';

  Future configureDependency() async {
    serviceLocator.registerSingleton<GlobalKey<NavigatorState>>(navigatorKey());
    serviceLocator.registerSingleton<ARouter>(aRouter());
    serviceLocator.registerSingleton<CoreSecureStorage>(coreSecureStorage());
    serviceLocator.registerSingleton<EventBus>(eventBus());
    serviceLocator
        .registerSingleton<FirebaseInAppMessaging>(firebaseInAppMessaging());
    serviceLocator.registerSingleton<FirebaseMessaging>(firebaseMessaging());
    serviceLocator.registerSingleton<Map<String, String>>(
      await defaultHttpHeaders(),
      instanceName: _defaultHeaders,
    );
    serviceLocator.registerSingleton<Alice>(alice());
    serviceLocator.registerLazySingleton<HttpInspector>(
          () => aliceHttpInspector(),
    );
    serviceLocator.registerFactory<CoreHttpRepository>(
          () => coreHttpRepository(
        serviceLocator<CoreSecureStorage>(),
      ),
    );
    serviceLocator.registerSingleton(AuthInterceptor());
    serviceLocator.registerFactory(
          () => coreHttpBuilder(
        serviceLocator(instanceName: _defaultHeaders),
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
      ),
    );
  }
}
