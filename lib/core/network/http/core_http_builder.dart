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

  CoreHttpClient aplusEwallet({
    required String path,
    Json? query,
    Map<String, String>? headers,
  }) {
    final url = apiEnv.then((value) => value.aplusEwalletUrlKrakend);

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

  CoreHttpClient aplusCustomer({
    required String path,
    Json? query,
    Map<String, String>? headers,
  }) =>
      _buildClient(
        apiEnv.then((value) => value.aplusCustomerUrl),
        path,
        query,
        headers,
      );

  CoreHttpClient aplusPpob({
    required String path,
    Json? query,
    Map<String, String>? headers,
  }) {
    final url = apiEnv.then((value) => value.aplusPpobUrlKrakend);

    return _buildClient(url, path, query, headers);
  }

  CoreHttpClient aplusRepayment({
    required String path,
    Json? query,
    Map<String, String>? headers,
  }) =>
      _buildClient(apiEnv.then((value) => value.aplusRepaymentUrl), path, query,
          headers);

  CoreHttpClient aplusPaylater({
    required String path,
    Json? query,
    Map<String, String>? headers,
  }) =>
      _buildClient(
          apiEnv.then((value) => value.aplusPaylaterUrl), path, query, headers);

  CoreHttpClient aplusBuying({
    required String path,
    Json? query,
    Map<String, String>? headers,
  }) =>
      _buildClient(
          apiEnv.then((value) => value.aplusBuyingUrl), path, query, headers);

  CoreHttpClient aplusDigitalLedgerUser({
    required String path,
    Json? query,
    Map<String, String>? headers,
  }) {
    final url = apiEnv.then((value) => value.aplusDigitalLedgerUserUrlKrakend);

    return _buildClient(url, path, query, headers);
  }

  CoreHttpClient aplusDigitalLedger({
    required String path,
    Json? query,
    Map<String, String>? headers,
  }) {
    final url = apiEnv.then((value) => value.aplusDigitalLedgerUrlKrakend);

    return _buildClient(url, path, query, headers);
  }

  CoreHttpClient aplusCsr({
    required String path,
    Json? query,
    Map<String, String>? headers,
  }) =>
      _buildClient(
          apiEnv.then((value) => value.aplusCsrUrl), path, query, headers);

  CoreHttpClient aplusLoan({
    required String path,
    Json? query,
    Map<String, String>? headers,
  }) =>
      _buildClient(
          apiEnv.then((value) => value.aplusLoanUrl), path, query, headers);

  CoreHttpClient aplusLoanDisb({
    required String path,
    Json? query,
    Map<String, String>? headers,
  }) =>
      _buildClient(
          apiEnv.then((value) => value.aplusLoanDisbUrl), path, query, headers);

  CoreHttpClient aplusPoint({
    required String path,
    Json? query,
    Map<String, String>? headers,
  }) =>
      _buildClient(
          apiEnv.then((value) => value.aplusPointUrl), path, query, headers);

  CoreHttpClient aplusNeobank({
    required String path,
    Json? query,
    Map<String, String>? headers,
  }) {
    final url = apiEnv.then((value) => value.aplusNeobankUrlKrakend);

    return _buildClient(url, path, query, headers);
  }

  CoreHttpClient aplusSaving({
    required String path,
    Json? query,
    Map<String, String>? headers,
  }) =>
      _buildClient(
          apiEnv.then((value) => value.aplusSavingUrl), path, query, headers);

  CoreHttpClient aplusMicroInvestment({
    required String path,
    Json? query,
    Map<String, String>? headers,
  }) =>
      _buildClient(apiEnv.then((value) => value.aplusMicroInvestmentUrl), path,
          query, headers);

  CoreHttpClient aplusAutoDebit({
    required String path,
    Json? query,
    Map<String, String>? headers,
  }) {

    final url = apiEnv.then((value) =>value.aplusAutoDebitUrlKrakend);

    return _buildClient(url, path, query, headers);
  }

  CoreHttpClient ascoreKeycloak({
    required String path,
    Json? query,
    Map<String, String>? headers,
  }) =>
      _buildClient(apiEnv.then((value) => value.ascoreKeycloakUrl), path, query,
          headers);

  CoreHttpClient ascore({
    required String path,
    Json? query,
    Map<String, String>? headers,
  }) =>
      _buildClient(
          apiEnv.then((value) => value.ascoreUrl), path, query, headers);

  CoreHttpClient aplusModal({
    required String path,
    Json? query,
    Map<String, String>? headers,
  }) =>
      _buildClient(
          apiEnv.then((value) => value.aplusModalUrl), path, query, headers);

  CoreHttpClient aplusModalService({
    required String path,
    Json? query,
    Map<String, String>? headers,
  }) =>
      _buildClient(
        apiEnv.then((value) => value.aplusModalUrlService),
        path,
        query,
        headers,
      );

  CoreHttpClient goCustomer({
    required String path,
    Json? query,
    Map<String, String>? headers,
  }) =>
      _buildClient(
          apiEnv.then((value) => value.goCustomerUrl), path, query, headers);

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
      final uri = Uri.https(authority, finalPath, query);
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
