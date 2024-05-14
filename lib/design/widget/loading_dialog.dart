import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mithub_app/design/theme_extension.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({super.key});

  static Future showLoadingDialog(BuildContext context,
      [bool rootNavigator = false]) {
    return showDialog(
      context: context,
      useRootNavigator: rootNavigator,
      barrierDismissible: false,
      builder: (context) => const LoadingDialog(),
    );
  }

  static Future<T> runWithLoading<T>(
      BuildContext context,
      Future<T> Function() block,
      ) async {
    try {
      unawaited(showLoadingDialog(context, true));
      final result = await block();
      return result;
    } finally {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: context.theme.dialogBackgroundColor,
        ),
        width: 200,
        height: 150,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const CircularProgressIndicator(),
            Text(
              'Loading',
              style: context.textTheme.labelLarge,
            )
          ],
        ),
      ),
    );
  }
}
