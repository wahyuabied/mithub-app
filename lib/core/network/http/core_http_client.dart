import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:alice/alice.dart';
import 'package:alice/core/alice_http_extensions.dart';
import 'package:http/http.dart' as http;
import 'package:mithub_app/core/di/service_locator.dart';
import 'package:mithub_app/core/network/auth_interceptor.dart';
import 'package:mithub_app/core/network/exception/no_connectivityException.dart';

// This is created via [CoreHttpBuilder] object.
// The actual HTTP method call reside in this object.
class CoreHttpClient {
  final Future<Uri> _uri;
  final Map<String, String> _additionalHeaders;
  final http.Client Function() _httpClient;
  final Alice _httpInspector;
  final _authInterceptor = serviceLocator.get<AuthInterceptor>();

  CoreHttpClient(
    this._uri,
    this._additionalHeaders,
    this._httpClient,
    this._httpInspector,
  );

  Future<http.Response> post<T extends Object>([T? body]) async {
    var client = _httpClient();
    try {
      var uri = await _uri;

      /*var isEnableCertificatePinning =
          _remoteConfig.getBool(enableCertificatePinning);

      if (isEnableCertificatePinning) {
        var isSecure = await SslPinning().isSecureConnection(
            '${uri.scheme}://${uri.host}', _additionalHeaders);

        if (!isSecure) {
          throw SslCertificateException();
        }
      }*/

      var response = await client
          .post(uri, headers: _additionalHeaders, body: jsonEncode(body))
          .interceptWithAlice(_httpInspector)
          .onError((error, stackTrace) {
        throw NoConnectivityException();
      });
      return response;
    } finally {
      client.close();
    }
  }

  Future<http.Response> get<T extends Object>() async {
    var client = _httpClient();
    try {
      var uri = await _uri;

      /*var isEnableCertificatePinning =
          _remoteConfig.getBool(enableCertificatePinning);

      if (isEnableCertificatePinning) {
        var isSecure = await SslPinning().isSecureConnection(
            '${uri.scheme}://${uri.host}', _additionalHeaders);

        if (!isSecure) {
          throw SslCertificateException();
        }
      }*/

      var response = await client
          .get(uri, headers: _additionalHeaders)
          .interceptWithAlice(_httpInspector)
          .onError((error, stackTrace) {
        throw NoConnectivityException();
      });

      return response;
    } finally {
      client.close();
    }
  }

  Future<http.Response> put<T>([T? body]) async {
    var client = _httpClient();
    try {
      var uri = await _uri;

     /* var isEnableCertificatePinning =
          _remoteConfig.getBool(enableCertificatePinning);

      if (isEnableCertificatePinning) {
        var isSecure = await SslPinning().isSecureConnection(
            '${uri.scheme}://${uri.host}', _additionalHeaders);

        if (!isSecure) {
          throw SslCertificateException();
        }
      }*/

      var response = await client
          .put(uri, headers: _additionalHeaders, body: jsonEncode(body))
          .interceptWithAlice(_httpInspector)
          .onError((error, stackTrace) {
        throw NoConnectivityException();
      });

      return response;
    } finally {
      client.close();
    }
  }

  Future<http.Response> patch<T extends Object>([T? body]) async {
    var client = _httpClient();
    try {
      var uri = await _uri;

      /*var isEnableCertificatePinning =
          _remoteConfig.getBool(enableCertificatePinning);

      if (isEnableCertificatePinning) {
        var isSecure = await SslPinning().isSecureConnection(
            '${uri.scheme}://${uri.host}', _additionalHeaders);

        if (!isSecure) {
          throw SslCertificateException();
        }
      }*/

      var response = await client
          .patch(uri, headers: _additionalHeaders, body: jsonEncode(body))
          .interceptWithAlice(_httpInspector)
          .onError((error, stackTrace) {
        throw NoConnectivityException();
      });

      return response;
    } finally {
      client.close();
    }
  }

  Future<http.Response> delete<T extends Object>([T? body]) async {
    var client = _httpClient();
    try {
      var uri = await _uri;

      /*var isEnableCertificatePinning =
          _remoteConfig.getBool(enableCertificatePinning);

      if (isEnableCertificatePinning) {
        var isSecure = await SslPinning().isSecureConnection(
            '${uri.scheme}://${uri.host}', _additionalHeaders);

        if (!isSecure) {
          throw SslCertificateException();
        }
      }*/
      var response = await client
          .delete(uri, headers: _additionalHeaders, body: jsonEncode(body))
          .interceptWithAlice(_httpInspector)
          .onError((error, stackTrace) {
        throw NoConnectivityException();
      });

      return response;
    } finally {
      client.close();
    }
  }

  Future<http.StreamedResponse> postMultipart({
    Map<String, String> fields = const {},
    List<http.MultipartFile> files = const [],
  }) async {
    var uri = await _uri;

    /*var isEnableCertificatePinning =
        _remoteConfig.getBool(enableCertificatePinning);

    if (isEnableCertificatePinning) {
      var isSecure = await SslPinning().isSecureConnection(
          '${uri.scheme}://${uri.host}', _additionalHeaders);

      if (!isSecure) {
        throw SslCertificateException();
      }
    }*/
    var allHeaders = await _authInterceptor.getAuthorizationHeader(
        headers: _additionalHeaders);
    final multipartRequest = http.MultipartRequest('POST', uri)
      ..headers.addAll(allHeaders)
      ..headers[HttpHeaders.contentTypeHeader] = 'multipart/form-data'
      ..fields.addAll(fields)
      ..files.addAll(files);

    return await multipartRequest.send();
  }

  Future<http.Response> postFormUrlEncoded<T extends Object>([T? body]) async {
    var client = _httpClient();
    try {
      var uri = await _uri;

      /*var isEnableCertificatePinning =
          _remoteConfig.getBool(enableCertificatePinning);

      if (isEnableCertificatePinning) {
        var isSecure = await SslPinning().isSecureConnection(
            '${uri.scheme}://${uri.host}', _additionalHeaders);

        if (!isSecure) {
          throw SslCertificateException();
        }
      }*/
      _additionalHeaders[HttpHeaders.contentTypeHeader] = 'application/x-www-form-urlencoded';
      var response = await client
          .post(uri, headers: _additionalHeaders,
            body: body,
          )
          .interceptWithAlice(_httpInspector)
          .onError((error, stackTrace) {
        throw NoConnectivityException();
      });
      return response;
    } finally {
      client.close();
    }
  }
}
