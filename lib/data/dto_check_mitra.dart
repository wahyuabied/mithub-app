import 'package:json_annotation/json_annotation.dart';
import 'package:mithub_app/core/type_defs.dart';

part 'dto_check_mitra.g.dart';

@JsonSerializable()
class PostCheckMitraRequest {
  @JsonKey(name: 'mitra_id')
  final int mitraId;

  PostCheckMitraRequest({required this.mitraId});

  factory PostCheckMitraRequest.fromJson(Json json) =>
      _$PostCheckMitraRequestFromJson(json);

  Json toJson() => _$PostCheckMitraRequestToJson(this);
}

@JsonSerializable()
class PostCheckMitraResponse {
  /// Only 12 Digits and will be half masked
  /// ex: 127***471***
  @JsonKey(name: 'identity_number')
  final String? identityNumber;
  @JsonKey(name: 'mitra_id')
  final int? mitraId;
  @JsonKey(name: 'name')
  final String? name;

  PostCheckMitraResponse({this.identityNumber, this.mitraId, this.name});

  factory PostCheckMitraResponse.fromJson(Json json) =>
      _$PostCheckMitraResponseFromJson(json);

  Json toJson() => _$PostCheckMitraResponseToJson(this);
}
