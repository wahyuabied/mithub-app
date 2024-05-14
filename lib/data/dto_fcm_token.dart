import 'package:json_annotation/json_annotation.dart';
import 'package:mithub_app/core/type_defs.dart';

part 'dto_fcm_token.g.dart';

@JsonSerializable()
class GetFcmTokenResponse {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'user_id')
  int? userId;
  @JsonKey(name: 'token')
  String? token;
  @JsonKey(name: 'type')
  String? type;
  @JsonKey(name: 'version')
  String? version;
  @JsonKey(name: 'created_at')
  String? createdAt;
  @JsonKey(name: 'updated_at')
  String? updatedAt;

  GetFcmTokenResponse({
    this.id,
    this.userId,
    this.token,
    this.type,
    this.version,
    this.createdAt,
    this.updatedAt,
  });

  factory GetFcmTokenResponse.fromJson(dynamic json) =>
      _$GetFcmTokenResponseFromJson(json);

  Json toJson() => _$GetFcmTokenResponseToJson(this);
}

@JsonSerializable()
class PostFcmTokenRequest {
  @JsonKey(name: 'token')
  String? token;
  @JsonKey(name: 'type')
  String? type;
  @JsonKey(name: 'version')
  String? version;

  PostFcmTokenRequest({
    this.token,
    this.type,
    this.version,
  });

  factory PostFcmTokenRequest.fromJson(Json json) =>
      _$PostFcmTokenRequestFromJson(json);

  Json toJson() => _$PostFcmTokenRequestToJson(this);
}
