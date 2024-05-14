// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dto_check_register_phone.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostCheckRegisterPhoneRequest _$PostCheckRegisterPhoneRequestFromJson(
        Map<String, dynamic> json) =>
    PostCheckRegisterPhoneRequest(
      phone: json['phone'] as String,
    );

Map<String, dynamic> _$PostCheckRegisterPhoneRequestToJson(
        PostCheckRegisterPhoneRequest instance) =>
    <String, dynamic>{
      'phone': instance.phone,
    };

PostCheckRegisterPhoneResponse _$PostCheckRegisterPhoneResponseFromJson(
        Map<String, dynamic> json) =>
    PostCheckRegisterPhoneResponse(
      isRegistered: json['is_registered'] as bool?,
      isMitra: json['is_mitra'] as bool?,
    );

Map<String, dynamic> _$PostCheckRegisterPhoneResponseToJson(
        PostCheckRegisterPhoneResponse instance) =>
    <String, dynamic>{
      'is_registered': instance.isRegistered,
      'is_mitra': instance.isMitra,
    };
