import 'package:alice/alice.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/models/interceptor_contract.dart';
import 'package:mithub_app/core/di/service_locator.dart';
import 'package:mithub_app/core/event_bus/event_bus.dart';
import 'package:mithub_app/core/event_bus/http_unauthorized_event.dart';
import 'package:mithub_app/core/network/core_http_repository.dart';
import 'package:synchronized/synchronized.dart';

extension on BaseRequest {
  void authorize(String token) {
    headers['Authorization'] = 'Bearer $token';
  }
}

class AuthInterceptor extends InterceptorContract {
  late final CoreHttpRepository _coreHttpRepository = serviceLocator();
  // late final AuthRepository _authRepository = serviceLocator();
  late final EventBus _networkEventBus = serviceLocator();
  late final Alice _alice = serviceLocator();

  final _lock = Lock();

  AuthInterceptor();

  Future<BaseResponse> _autoLogout(
      BaseResponse response,
      ) async {
    _networkEventBus.fire(HttpUnauthorizedEvent(
      response.request,
      response.statusCode,
    ));
    return response;
  }

  Future<bool> _refreshTokenWithSynchronize(
      String oldToken,
      ) async {
    return await _lock.synchronized<bool>(() async {
      final token = await _coreHttpRepository.getToken();
      if (oldToken == token) {
        // return await _authRepository.refreshToken();
      }
      return true;
    });
  }

  Future<BaseResponse> _retryWithRefreshToken(
      BaseResponse response,
      ) async {
    try {
      final requestOrigin = response.request;
      final httpResponseOrigin = response;

      final token = await _coreHttpRepository.getToken();
      final hasNewToken = await _refreshTokenWithSynchronize(token);
      if (hasNewToken && requestOrigin != null) {
        final newToken = await _coreHttpRepository.getToken();
        final request = requestOrigin..authorize(newToken);
        final streamResponse = await request.send();
        final httpResponse = await Response.fromStream(streamResponse);

        if (httpResponseOrigin is Response) {
          _alice.onHttpResponse(httpResponseOrigin);
        }
        return httpResponse;
      }
    } on PlatformException catch (e) {
      if (e.message?.contains('invalid_grant') == true) {
        _networkEventBus.fire(HttpUnauthorizedEvent(
          response.request,
          response.statusCode,
        ));
      }
    }
    return response;
  }

  @override
  Future<BaseRequest> interceptRequest({required BaseRequest request}) async {
    final token = await _coreHttpRepository.getToken();
    return request..authorize(token);
  }

  @override
  Future<BaseResponse> interceptResponse({
    required BaseResponse response,
  }) async {
    switch (response.statusCode) {
      case 401:
        return await _retryWithRefreshToken(response);
      case 403:
        return await _autoLogout(response);
    }
    return response;
  }

  Future<Map<String, String>> getAuthorizationHeader(
      {required Map<String, String> headers}) async {
    final Map<String, String> allHeaders = Map.from(headers);
    final tokenFuture = _coreHttpRepository.getToken().then((token) =>
        allHeaders.putIfAbsent('Authorization', () => 'Bearer $token'));
    await Future.wait([tokenFuture]);
    return allHeaders;
  }
}
