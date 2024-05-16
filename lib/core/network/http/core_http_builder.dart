import 'dart:async';

import 'package:alice/alice.dart';
import 'package:http/http.dart' as http;
import 'package:mithub_app/core/network/api_env.dart';
import 'package:mithub_app/core/network/core_http_repository.dart';
import 'package:mithub_app/core/network/http/core_http_client.dart';
import 'package:mithub_app/core/type_defs.dart';

// Core Http is the component for http network call.
// This object will generate proper configuration for [CoreHttpClient].
class CoreHttpBuilder {
  final Map<String, String> defaultHeaders;
  final http.Client Function() coreClient;
  final Alice httpInspector;
  final CoreHttpRepository coreHttpRepository;

  CoreHttpBuilder({
    required this.defaultHeaders,
    required this.coreClient,
    required this.httpInspector,
    required this.coreHttpRepository,
  });

  Future<ApiEnv> get apiEnv => coreHttpRepository.getEnv();

  CoreHttpClient localHost({
    required String path,
    Json? query,
    Map<String, String>? headers,
  }) {
    final url = apiEnv.then((value) => value.localHost);

    return _buildClient(
      url,
      path,
      query,
      headers,
    );
  }

  CoreHttpClient aplus({
    required String path,
    Json? query,
    Map<String, String>? headers,
  }) =>
      _buildClient(
          apiEnv.then((value) => value.aplusUrl), path, query, headers);


  CoreHttpClient _buildClient(
    Future<String> url,
    String path, [
    Json? query,
    Map<String, String>? headers,
  ]) {
    final finalHeaders = Map.of(defaultHeaders)..addAll(headers ?? {});
    final uri = Future.sync(() async {
      final urlSegments = await url.then((value) => value.split('/'));
      final pathSegments = path.split('/');

      final authority = urlSegments.first;
      final basePathSegments = urlSegments.sublist(1);
      final finalSegments = (basePathSegments + pathSegments)
        ..removeWhere((element) => element.isEmpty);

      final finalPath = finalSegments.join('/');
      final uri = Uri.http(authority, finalPath, query);
      return uri;
    });

    return CoreHttpClient(
      uri,
      finalHeaders,
      coreClient,
      httpInspector,
    );
  }
}
