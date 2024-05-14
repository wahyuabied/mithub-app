
import 'package:mithub_app/data/repository/core/api_response.dart';

class ScalarResponse<T> extends ApiResponse {
  late final T? data = cast();

  ScalarResponse(super.response);

  T? cast() {
    final dynamic value = rawData;
    if (value == null) return null;
    if (value is T) return value;

    throw FormatException(
      'expected T: $T but actual data: ${value.runtimeType}',
      value,
    );
  }
}
