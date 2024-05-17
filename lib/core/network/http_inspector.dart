import 'dart:convert';

import 'package:alice/alice.dart';
import 'package:alice/model/alice_http_call.dart';
import 'package:alice/model/alice_http_request.dart';
import 'package:alice/model/alice_http_response.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';

class HttpInspector extends InterceptorContract {
  final Alice alice;
  Map<BaseRequest, DateTime> requestMap = {};

  HttpInspector(this.alice);

  @override
  Future<BaseRequest> interceptRequest({required BaseRequest request}) {
    requestMap[request] = DateTime.now();
    return Future.value(request);
  }

  @override
  Future<BaseResponse> interceptResponse({required BaseResponse response}) {
    if (response is http.Response) {
      final request = response.request;
      onResponse(
        requestMap.remove(request) ?? DateTime.now(),
        response,
        body: request is http.Request ? request.body : null,
      );
    }
    return Future.value(response);
  }

  void onResponse(
    DateTime requestTime,
    http.Response response, {
    dynamic body,
  }) {
    if (response.request == null) {
      return;
    }
    final request = response.request!;

    final call = AliceHttpCall(response.request.hashCode)
      ..loading = true
      ..client = 'HttpClient (http package)'
      ..uri = request.url.toString()
      ..method = request.method;
    var path = request.url.path;
    if (path.isEmpty) {
      path = '/';
    }
    call
      ..endpoint = path
      ..server = request.url.host;
    if (request.url.scheme == 'https') {
      call.secure = true;
    }

    final httpRequest = AliceHttpRequest();

    if (response.request is http.Request) {
      // we are guaranteed` the existence of body and headers
      if (body != null) {
        httpRequest.body = body;
      }
      // ignore: cast_nullable_to_non_nullable
      httpRequest
        ..body = body ?? (response.request! as http.Request).body ?? ''
        ..size = utf8.encode(httpRequest.body.toString()).length
        ..headers = Map<String, dynamic>.from(response.request!.headers);
    } else if (body == null) {
      httpRequest
        ..size = 0
        ..body = '';
    } else {
      httpRequest
        ..size = utf8.encode(body.toString()).length
        ..body = body;
    }

    httpRequest.time = requestTime;

    String? contentType = 'unknown';
    if (httpRequest.headers.containsKey('Content-Type')) {
      contentType = httpRequest.headers['Content-Type'] as String?;
    }

    httpRequest
      ..contentType = contentType
      ..queryParameters = response.request!.url.queryParameters;

    final httpResponse = AliceHttpResponse()
      ..status = response.statusCode
      ..body = response.body
      // ignore: noop_primitive_operations
      ..size = utf8.encode(response.body.toString()).length
      ..time = DateTime.now();
    final responseHeaders = <String, String>{};
    response.headers.forEach((header, values) {
      responseHeaders[header] = values;
    });
    httpResponse.headers = responseHeaders;

    call
      ..request = httpRequest
      ..response = httpResponse
      ..loading = false
      ..duration = httpResponse.time.millisecondsSinceEpoch -
          httpRequest.time.millisecondsSinceEpoch;

    alice.addHttpCall(call);
  }

  void showInspector() {
    alice.showInspector();
  }
}
