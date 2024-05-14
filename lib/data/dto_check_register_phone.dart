import 'package:json_annotation/json_annotation.dart';
import 'package:mithub_app/core/type_defs.dart';

part 'dto_check_register_phone.g.dart';

@JsonSerializable()
class PostCheckRegisterPhoneRequest {
  final String phone;

  const PostCheckRegisterPhoneRequest({required this.phone});

  factory PostCheckRegisterPhoneRequest.fromJson(Json json) =>
      _$PostCheckRegisterPhoneRequestFromJson(json);

  Json toJson() => _$PostCheckRegisterPhoneRequestToJson(this);
}

@JsonSerializable()
class PostCheckRegisterPhoneResponse {
  @JsonKey(name: 'is_registered')
  final bool? isRegistered;
  @JsonKey(name: 'is_mitra')
  final bool? isMitra;

  PostCheckRegisterPhoneResponse({this.isRegistered, this.isMitra});

  factory PostCheckRegisterPhoneResponse.fromJson(Json json) =>
      _$PostCheckRegisterPhoneResponseFromJson(json);

  Json toJson() => _$PostCheckRegisterPhoneResponseToJson(this);
}
