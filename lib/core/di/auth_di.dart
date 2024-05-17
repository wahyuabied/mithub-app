import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:mithub_app/core/di/service_locator.dart';
import 'package:mithub_app/core/network/core_http_repository.dart';
import 'package:mithub_app/core/network/http/core_http_builder.dart';
import 'package:mithub_app/core/storage/core_secure_storage.dart';
import 'package:mithub_app/data/repository/auth_network.dart';
import 'package:mithub_app/data/repository/auth_repository.dart';
import 'package:mithub_app/data/repository/user_profile_repository.dart';

Future configureAuthDependencies() async {

  serviceLocator.registerFactory<AuthNetwork>(
      () => AuthNetwork(serviceLocator<CoreHttpBuilder>()));

  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepository(
      serviceLocator<AuthNetwork>(),
      serviceLocator<CoreSecureStorage>(),
      serviceLocator<CoreHttpRepository>(),
      serviceLocator<FirebaseMessaging>(),
    ),
  );

  serviceLocator.registerFactory<UserProfileRepository>(
        () => UserProfileRepository(
          serviceLocator<CoreSecureStorage>(),
          serviceLocator<AuthNetwork>(),
    ),
  );
}
