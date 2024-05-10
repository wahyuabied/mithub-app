import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:mithub_app/core/di/service_locator.dart';
import 'package:mithub_app/core/event_bus/event_bus.dart';

/// A widget that listen on [EventBus] then call [onEvent] when an event occurs
///
/// Useful to enable communication between [Provider] and a [Widget]
///
/// For example, you need to show dialog in a safe way without
/// the need of passing [BuildContext]
///
/// Example usage
///
/// In Provider:
///
/// ```dart
/// void fetchSomething() async {
///    try {
///       await _doSomething();
///    } catch (e) {
///       serviceLocator<EventBus>().fire(ShowErrorDialog(message: 'Error'));
///    }
/// }
/// ```
///
/// In UI
///
/// ```dart
/// return EventBusListener<dynamic>(
///   onEvent: (event) {
///       if (event is ShowErrorDialog) {
///            showDialog(
///               context: context,
///               ....
///            );
///       }
///   },
///   child: Scaffold(...)
/// )
/// ```
class EventBusListener<T> extends StatefulWidget {
  const EventBusListener({
    super.key,
    required this.onEvent,
    required this.child,
  });

  final Function(T event) onEvent;

  final Widget child;

  @override
  State<EventBusListener<T>> createState() => _EventBusListenerState<T>();
}

class _EventBusListenerState<T> extends State<EventBusListener<T>> {
  StreamSubscription? _subs;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _subs?.cancel();
    _subs = null;

    _subs = serviceLocator<EventBus>().on<T>().listen((event) {
      if (mounted) {
        widget.onEvent(event);
      }
    });
  }

  @override
  void dispose() {
    _subs?.cancel();
    _subs = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
