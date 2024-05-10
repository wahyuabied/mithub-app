import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';

// Central Service Locator
// This is the container where all dependencies is actually stored
// Usages are as simple as:
// `serviceLocator<MyDependency>()` or `serviceLocator.get<MyDependency>()`

extension ServiceLocatorExt on GetIt {
  T create<T extends Object>(BuildContext context) => get<T>();
}

final GetIt serviceLocator = GetIt.instance;
