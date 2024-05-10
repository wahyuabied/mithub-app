import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mithub_app/core/notification/notification_data.dart';
import 'package:mithub_app/my_app.dart';
import 'package:provider/provider.dart';

Future<void> main() async{

  final StreamController<NotificationData> didReceiveLocalNotificationStream =
  StreamController<NotificationData>.broadcast();

  runApp(MultiProvider(
    providers: [],
    child: MyApp(
      notificationStream: didReceiveLocalNotificationStream,
    ),
  ));
}

