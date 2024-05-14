import 'package:json_annotation/json_annotation.dart';
import 'package:mithub_app/core/type_defs.dart';

part 'dto_check_pin.g.dart';

@JsonSerializable()
class PostCheckPinRequest {
  @JsonKey(name: 'stat_code')
  final int statusCode;
  @JsonKey(name: 'stat_msg')
  final String statusMessage;

  PostCheckPinRequest({
    required this.statusCode,
    required this.statusMessage,
  });

  factory PostCheckPinRequest.fromJson(Json json) =>
      _$PostCheckPinRequestFromJson(
        json,
      );

  Json toJson() => _$PostCheckPinRequestToJson(
    this,
  );
}
