import 'package:json_annotation/json_annotation.dart';
import 'package:mithub_app/core/type_defs.dart';

part 'dto_user_login.g.dart';

@JsonSerializable()
class PostUserLoginRequest {
  @JsonKey(name: 'phone_number')
  final String phoneNumber;
  @JsonKey(name: 'pin')
  final String pin;

  PostUserLoginRequest({
    required this.phoneNumber,
    required this.pin,
  });

  factory PostUserLoginRequest.fromJson(Json json) =>
      _$PostUserLoginRequestFromJson(json);

  Json toJson() => _$PostUserLoginRequestToJson(this);
}

@JsonSerializable()
class PostUserLoginResponse {
  @JsonKey(name: 'token')
  String? token;

  PostUserLoginResponse();

  factory PostUserLoginResponse.fromJson(Json json) =>
      _$PostUserLoginResponseFromJson(json);

  Json toJson() => _$PostUserLoginResponseToJson(this);
}
