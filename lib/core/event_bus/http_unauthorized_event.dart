import 'package:http/http.dart';

/// Event indicating apps should perform logout
class HttpUnauthorizedEvent {
  final BaseRequest? request;
  final int statusCode;

  HttpUnauthorizedEvent(this.request, this.statusCode);
}
