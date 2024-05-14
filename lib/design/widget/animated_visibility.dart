import 'package:flutter/material.dart';

class AnimatedVisibility extends StatelessWidget {
  const AnimatedVisibility({
    super.key,
    required this.duration,
    required this.visible,
    required this.child,
  });

  /// Animation duration
  final Duration duration;

  /// Is child visible
  final bool visible;

  /// The child to show
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      firstCurve: Curves.fastOutSlowIn,
      secondCurve: Curves.fastOutSlowIn,
      sizeCurve: Curves.fastOutSlowIn,
      crossFadeState:
      visible ? CrossFadeState.showSecond : CrossFadeState.showFirst,
      duration: duration,
      firstChild: const SizedBox(),
      secondChild: child,
    );
  }
}
