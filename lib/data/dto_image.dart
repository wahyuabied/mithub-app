import 'package:json_annotation/json_annotation.dart';
import 'package:mithub_app/core/type_defs.dart';

part 'dto_image.g.dart';

@JsonSerializable()
class Image {
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'path')
  final String? path;
  @JsonKey(name: 'type')
  final String? type;

  Image({this.id, this.path, this.type});

  factory Image.fromJson(Json json) => _$ImageFromJson(json);

  Json toJson() => _$ImageToJson(this);
}
