import 'package:mithub_app/core/type_defs.dart';
import 'package:mithub_app/data/repository/core/api_response.dart';

/// Response of [data] with type [List] of [Json].
/// constructor [cast] to cast [Json] -> [T].
/// returns non growable [List] of [T], list can be null or empty,
/// so it is up to the client on how to handle each of them.
/// throw [FormatException] when expected type is different than actual.
class JsonListResponse<T> extends ApiResponse {
  final T Function(Json json) cast;
  late final List<T>? data = castList();

  JsonListResponse(super.response, this.cast);

  List<T>? castList() {
    final dynamic value = rawData;
    if (value == null) return null;
    if (value! is List<Json>) {
      throw FormatException(
        'expected T: $T but actual data: ${value.runtimeType}',
        rawData,
      );
    }

    final values = value as List<dynamic>;
    return values.map((data) => cast(data)).toList(growable: false);
  }
}
