// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dto_image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Image _$ImageFromJson(Map<String, dynamic> json) => Image(
      id: (json['id'] as num?)?.toInt(),
      path: json['path'] as String?,
      type: json['type'] as String?,
    );

Map<String, dynamic> _$ImageToJson(Image instance) => <String, dynamic>{
      'id': instance.id,
      'path': instance.path,
      'type': instance.type,
    };
