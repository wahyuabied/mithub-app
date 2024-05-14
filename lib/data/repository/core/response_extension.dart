import 'package:http/http.dart';

extension ResponseExt on Response {
  bool get isSuccess {
    return statusCode.inRange(200, 299);
  }

  bool get isClientError {
    return statusCode.inRange(400, 499);
  }

  bool get isServerError {
    return statusCode.inRange(500, 599);
  }

  bool get isError => isClientError || isServerError;
}

extension RangeExt on int? {
  int get orEmpty => this ?? 0;
  bool inRange(int first, int last) {
    return first <= orEmpty && orEmpty <= last;
  }
}
