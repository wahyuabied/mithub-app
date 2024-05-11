import 'package:mithub_app/core/di/core_module.dart';

Future configureCoreDependencies() async {
  final coreModule = CoreModule();
  await coreModule.configureDependency();
}
