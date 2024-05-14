import 'package:json_annotation/json_annotation.dart';
import 'package:mithub_app/core/type_defs.dart';

part 'dto_user_login.g.dart';

@JsonSerializable()
class PostUserLoginRequest {
  @JsonKey(name: 'phone')
  final String phone;
  @JsonKey(name: 'pin')
  final String pin;
  @JsonKey(name: 'device_uuid')
  final String deviceUuid;

  PostUserLoginRequest({
    required this.phone,
    required this.pin,
    required this.deviceUuid,
  });

  factory PostUserLoginRequest.fromJson(Json json) =>
      _$PostUserLoginRequestFromJson(json);

  Json toJson() => _$PostUserLoginRequestToJson(this);
}

@JsonSerializable()
class PostUserLoginResponse {
  @JsonKey(name: 'expired_date')
  String? expiredDate;
  @JsonKey(name: 'is_device_registered')
  bool? isDeviceRegistered;
  @JsonKey(name: 'refresh_expired_date')
  String? refreshExpiredDate;
  @JsonKey(name: 'refresh_token')
  String? refreshToken;
  @JsonKey(name: 'status')
  String? status;
  @JsonKey(name: 'session_token')
  String? sessionToken;
  @JsonKey(name: 'retry_date')
  String? retryDate;
  @JsonKey(name: 'seed')
  String? seed;
  @JsonKey(name: 'token')
  String? token;
  @JsonKey(name: 'is_pin_expired')
  bool? isPinExpired;
  @JsonKey(name: 'is_ibu_amanah')
  bool? isIbuAmanah;
  @JsonKey(name: 'is_neobank')
  bool? isNeobank;

  PostUserLoginResponse();

  factory PostUserLoginResponse.fromJson(Json json) =>
      _$PostUserLoginResponseFromJson(json);

  Json toJson() => _$PostUserLoginResponseToJson(this);
}
