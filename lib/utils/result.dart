import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:mithub_app/data/repository/core/api_response.dart';
import 'package:mithub_app/data/repository/core/json_list_response.dart';
import 'package:mithub_app/data/repository/core/json_response.dart';
import 'package:mithub_app/data/repository/core/response_extension.dart';
import 'package:mithub_app/utils/common.dart';
import 'package:mithub_app/utils/result_exceptions.dart';

/// Utility class to describe a loading, error and
/// success state of a method call
///
/// It's almost the same with Result class in Kotlin
///
/// Usage
/// ```dart
/// Result<String> _someResult = Result.initial();
///
/// Result.call<Strng>(
///     future: fetchSomething(),
///     onResult: (result) {
///         _someResult = result;
///        notifyListener();
///     }
/// )
///
/// See [ResultBuilder] and [ResultSelectorBuilder] on how to use it
/// ```
sealed class Result<T> with EquatableMixin {
  const Result._();

  const factory Result.initial() = Initial<T>;

  const factory Result.loading() = Loading<T>;

  const factory Result.success(T value) = Success<T>;

  const factory Result.error(dynamic error, [StackTrace? stackTrace]) =
      ResultError<T>;

  /// Used to call API that return [JsonResponse] or [JsonListResponse]
  ///
  /// Will throw exception if ApiResponse not success
  static Future<bool> callApi<T>({
    required Future<ApiResponse> future,
    required Function(Result<T> result) onResult,
    int retryTimes = 0,
    bool returnData = true,
    Function(T data)? onSuccess,
    Function(dynamic error)? onError,
  }) {
    Future<T> internalCall() async {
      final result = await future;
      if (result.isSuccess) {
        if (result is JsonResponse<T>) {
          return result.data as T;
        } else if (result is JsonListResponse<T>) {
          return result.data as T;
        } else {
          // Plain ApiResponse
          return result as T;
        }
      } else {
        throw ApiResultException(result.statMsg ?? 'API Error', result);
      }
    }

    return call<T>(
      future: internalCall(),
      onResult: onResult,
      retryTimes: retryTimes,
      onError: onError,
      onSuccess: onSuccess,
    );
  }

  /// Call any future
  static Future<bool> call<T>({
    required Future<T> future,
    required Function(Result<T> result) onResult,
    int retryTimes = 0,
    Function(T data)? onSuccess,
    Function(dynamic error)? onError,
  }) async {
    try {
      await retry(retryTimes, () async {
        onResult.call(const Result.loading());
        final response = await future;
        onResult.call(Result.success(response));
        onSuccess?.call(response);
      });
      return Future.value(true);
    } catch (e, s) {
      debugPrint(e.toString());
      onResult.call(Result<T>.error(e));
      onError?.call(e);
      if (e is! ApiResultException) {
        unawaited(FirebaseCrashlytics.instance.recordError(e, s));
      }
      return Future.value(false);
    }
  }
}

class Initial<T> extends Result<T> {
  const Initial() : super._();

  @override
  List<Object?> get props => const [];
}

class Loading<T> extends Result<T> {
  const Loading() : super._();

  @override
  List<Object?> get props => const [];
}

class ResultError<T> extends Result<T> {
  const ResultError(
    this.error, [
    this.stackTrace,
  ]) : super._();

  final dynamic error;
  final StackTrace? stackTrace;

  void rethrowError() {
    if (error is Error) {
      Error.throwWithStackTrace(error, stackTrace ?? StackTrace.current);
    } else {
      throw error;
    }
  }

  @override
  List<Object?> get props => [error, stackTrace];
}

class Success<T> extends Result<T> {
  const Success(this.data) : super._();

  final T data;

  @override
  List<Object?> get props => [data];
}

// coverage:ignore-start
/// A wrapper class for [Result] that save last success value
/// that can be restored if error occur
/// Usage
///
/// ```dart
/// ResultState<String> _someResult = ResultState("Initial",
/// useLastDataOnError: true);
///
/// Result.call<String>(
///     future: fetchSomething(),
///     onResult: (result) {
///         _someResult.setResult(result);
///        notifyListener();
///     },
/// )
/// ```
class ResultState<T> with EquatableMixin {
  Result<T> result = const Result.initial();

  /// Cached last success data
  T? lastData;

  /// Should automaticcaly use last data if error occur
  bool useLastDataOnError;

  ResultState({this.useLastDataOnError = false, T? initalValue}) {
    if (initalValue != null) {
      result = Result.success(initalValue);
      lastData = initalValue;
    }
  }

  /// Set internal [Result] for this wrapper class
  void setResult(Result<T> newResult) {
    result = newResult;
    if (newResult is Success) {
      lastData = newResult.data;
    }

    if (newResult is ResultError && useLastDataOnError) {
      restorePrevious();
    }
  }

  /// Restore previously success data
  void restorePrevious() {
    final data = lastData;
    if (data != null) {
      result = Result.success(data);
    }
  }

  @override
  List<Object?> get props => [result, lastData, useLastDataOnError];
}
// coverage:ignore-end

extension ResultExt<T> on Result<T> {
  bool get isLoading => this is Loading;

  bool get isSuccess => this is Success;

  bool get isError => this is ResultError;

  bool get isInitial => this is Initial;

  bool get isInitialOrLoading => this is Initial || this is Loading;

  @Deprecated(
    '''
    avoid this API that performs unsafe cast.
    use [dataOrNull] as alternative
    ''',
  )
  T get data => (this as Success).data;

  T? get dataOrNull => this is Success ? (this as Success<T>).data : null;

  dynamic get error => (this as ResultError).error;

  void rethrowError() {
    (this as ResultError).rethrowError();
  }
}
