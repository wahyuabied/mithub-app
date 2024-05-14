import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mithub_app/core/di/auth_di.dart';
import 'package:mithub_app/core/di/core_di.dart';
import 'package:mithub_app/core/notification/notification_data.dart';
import 'package:mithub_app/my_app.dart';

Future<void> main() async {
  final StreamController<NotificationData> didReceiveLocalNotificationStream =
      StreamController<NotificationData>.broadcast();

  WidgetsFlutterBinding.ensureInitialized();
  unawaited(SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]));


  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyA4LRWpoKh0NDQ3_D_HzT-Pn3NI5xQi4Nc',
      appId: '1:905077645826:android:f7d4aecd6f5a8748be7d1b',
      messagingSenderId: 'com.example.mithub',
      projectId: 'mithub-79d43',
    ),
  );

  await configureCoreDependencies();
  await configureAuthDependencies();

  runApp(MyApp(
    notificationStream: didReceiveLocalNotificationStream,
  ));
}
