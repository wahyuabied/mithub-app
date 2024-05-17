import 'package:flutter/material.dart';
import 'package:mithub_app/utils/result.dart';
import 'package:provider/provider.dart';

/// A builder widget build something based on [Result] state
///
/// Example Usage
///
///```
/// ResultBuilder(
///   result: someResult,
///   defaultBuilder: (context, result) => Loading(),
///   successBuilder: (context, success) => Content(),
///   errorBuilder: (context, error) => SomeError(),
/// )
/// ```
class ResultBuilder<T> extends StatelessWidget {
  const ResultBuilder({
    super.key,
    required this.result,
    required this.defaultBuilder,
    this.initialBuilder,
    this.loadingBuilder,
    this.errorBuilder,
    this.successBuilder,
  });

  final Result<T> result;
  final Widget Function(BuildContext context, Initial<T> initial)?
  initialBuilder;
  final Widget Function(BuildContext context, Loading<T> loading)?
  loadingBuilder;
  final Widget Function(BuildContext context, ResultError<T> error)?
  errorBuilder;
  final Widget Function(BuildContext context, Success<T> success)?
  successBuilder;
  final Widget Function(BuildContext context, Result<T> result) defaultBuilder;

  @override
  Widget build(BuildContext context) {
    if (result is Initial) {
      return initialBuilder?.call(context, result as Initial<T>) ??
          defaultBuilder(context, result);
    }

    if (result is Loading) {
      return loadingBuilder?.call(context, result as Loading<T>) ??
          defaultBuilder(context, result);
    }

    if (result is ResultError) {
      return errorBuilder?.call(context, result as ResultError<T>) ??
          defaultBuilder(context, result);
    }

    if (result is Success) {
      return successBuilder?.call(context, result as Success<T>) ??
          defaultBuilder(context, result);
    }

    return defaultBuilder(context, result);
  }
}

/// Same with [ResultBuilder] but get the [Result] from
/// providers [Selector] widget
///
/// Usage
///
///```dart
/// ResultSelectorBuilder<ScreenProvider, String>(
///   result: (context, p) => p.someResult,
///   defaultBuilder: (context, result) => Loading(),
///   successBuilder: (context, success) => Content(),
///   errorBuilder: (context, error) => SomeError(),
/// )
/// ```
class ResultSelectorBuilder<P, T> extends StatelessWidget {
  const ResultSelectorBuilder({
    super.key,
    required this.resultSelector,
    required this.defaultBuilder,
    this.initialBuilder,
    this.loadingBuilder,
    this.errorBuilder,
    this.successBuilder,
  });

  final Result<T> Function(BuildContext context, P provider) resultSelector;
  final Widget Function(BuildContext context, Initial<T> initial)?
  initialBuilder;
  final Widget Function(BuildContext context, Loading<T> loading)?
  loadingBuilder;
  final Widget Function(BuildContext context, ResultError<T> error)?
  errorBuilder;
  final Widget Function(BuildContext context, Success<T> success)?
  successBuilder;
  final Widget Function(BuildContext context, Result<T> result) defaultBuilder;

  @override
  Widget build(BuildContext context) {
    return Selector<P, Result<T>>(
      builder: (context, value, _) => ResultBuilder(
        result: value,
        defaultBuilder: defaultBuilder,
        initialBuilder: initialBuilder,
        loadingBuilder: loadingBuilder,
        errorBuilder: errorBuilder,
        successBuilder: successBuilder,
      ),
      selector: resultSelector,
    );
  }
}
