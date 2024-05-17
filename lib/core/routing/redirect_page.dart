import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mithub_app/core/routing/a_page.dart';
import 'package:mithub_app/design/widget/loading_dialog.dart';

/// A page that only doing redirection
/// Can be used to add alternative path to a page
class RedirectPage extends StatefulWidget {
  const RedirectPage({
    super.key,
    required this.redirectTo,
  });

  final Future Function(BuildContext context, GoRouterState state) redirectTo;

  static GoRoute createRoute({
    required String path,
    String? name,
    required Future Function(BuildContext context, GoRouterState) redirectTo,
  }) {
    return GoRoute(
      path: path,
      name: name,
      pageBuilder: (context, state) => APage(
        key: state.pageKey,
        child: RedirectPage(
          redirectTo: redirectTo,
        ),
      ),
    );
  }

  @override
  State<RedirectPage> createState() => _RedirectPageState();
}

class _RedirectPageState extends State<RedirectPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        widget.redirectTo(context, GoRouterState.of(context));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: LoadingDialog(),
    );
  }
}
