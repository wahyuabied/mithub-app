import 'package:flutter/cupertino.dart';
import 'package:mithub_app/core/state_management/a_base_change_notifier.dart';
import 'package:provider/provider.dart';

abstract class ABaseChangeNotifierState<T extends Object>
    extends ABaseChangeNotifier {
  ABaseChangeNotifierState(T initialState) {
    state = initialState;
  }

  late T state;

  void setState(T state) {
    this.state = state;
    notifyListeners();
  }
}

class StateSelector<T extends ABaseChangeNotifierState, S extends Object>
    extends Selector<T, S> {
  StateSelector({
    super.key,
    required Widget Function(BuildContext, S state) builder,
  }) : super(
          builder: (context, state, widget) => builder(context, state),
          selector: (context, provider) => provider.state as S,
        );
}
