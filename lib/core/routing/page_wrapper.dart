import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mithub_app/core/di/service_locator.dart';
import 'package:mithub_app/core/network/http_inspector.dart';

/// Provide helper and utility function for debugging a page
class PageWrapper extends StatelessWidget {
  final Widget child;

  const PageWrapper({
    super.key,
    required this.child,
  });

  List<DebugAction> _getAction() {
    final HttpInspector httpInspector = serviceLocator.get();
    return [
      DebugAction(
        title: 'Dev Ops',
        action: (context) => httpInspector.showInspector(),
      ),
    ];
  }

  void _showDebugMenu(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (innnerContext) {
        return CupertinoActionSheet(
          actions: _getAction()
              .map((e) => CupertinoActionSheetAction(
                    onPressed: () {
                      Navigator.pop(innnerContext);
                      e.action(context);
                    },
                    child: Text(e.title),
                  ))
              .toList(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenType = child.runtimeType.toString();
    return Stack(
      children: [
        Positioned.fill(child: child),
        if (!kReleaseMode)
          SafeArea(
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 32),
                child: Material(
                  color: Colors.white,
                  child: InkWell(
                    child: Text(
                      '($screenType)',
                      overflow: TextOverflow.ellipsis,
                      key: const Key('text-debug'),
                      maxLines: 1,
                      textAlign: TextAlign.center,
                    ),
                    onLongPress: () {
                      _showDebugMenu(context);
                    },
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class DebugAction {
  DebugAction({
    required this.title,
    required this.action,
  });

  /// Action title
  final String title;

  /// On tap action
  final Function(BuildContext context) action;
}
