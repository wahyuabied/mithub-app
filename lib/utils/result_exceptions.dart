import 'package:mithub_app/data/repository/core/api_response.dart';

class ApiResultException implements Exception {
  final dynamic message;
  final ApiResponse response;

  ApiResultException(
    this.message,
    this.response,
  );

  @override
  String toString() {
    return message ?? '';
  }
}
