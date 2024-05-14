// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dto_fcm_token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetFcmTokenResponse _$GetFcmTokenResponseFromJson(Map<String, dynamic> json) =>
    GetFcmTokenResponse(
      id: (json['id'] as num?)?.toInt(),
      userId: (json['user_id'] as num?)?.toInt(),
      token: json['token'] as String?,
      type: json['type'] as String?,
      version: json['version'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$GetFcmTokenResponseToJson(
        GetFcmTokenResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'token': instance.token,
      'type': instance.type,
      'version': instance.version,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };

PostFcmTokenRequest _$PostFcmTokenRequestFromJson(Map<String, dynamic> json) =>
    PostFcmTokenRequest(
      token: json['token'] as String?,
      type: json['type'] as String?,
      version: json['version'] as String?,
    );

Map<String, dynamic> _$PostFcmTokenRequestToJson(
        PostFcmTokenRequest instance) =>
    <String, dynamic>{
      'token': instance.token,
      'type': instance.type,
      'version': instance.version,
    };
