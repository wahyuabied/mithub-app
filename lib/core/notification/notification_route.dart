import 'package:flutter/material.dart';
import 'package:mithub_app/core/di/service_locator.dart';
import 'package:mithub_app/core/notification/notification_data.dart';
import 'package:mithub_app/core/routing/a_route.dart';

class NotificationRoute {
  static ARouter aRouter = serviceLocator.get();

  static void getRoute(
      NotificationData notificationData, BuildContext context) {
    final type = notificationData.type;
    var router = aRouter.getRouter();
    if (router != null) {
      switch (type) {
        //put route here
      }
    }
  }
}