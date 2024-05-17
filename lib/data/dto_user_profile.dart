import 'package:json_annotation/json_annotation.dart';
import 'package:mithub_app/core/type_defs.dart';
import 'package:mithub_app/data/dto_image.dart';

part 'dto_user_profile.g.dart';

@JsonSerializable()
class PostUserProfileResponse {
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'code')
  final String? code;
  @JsonKey(name: 'customer_number')
  final String? customerNumber;
  @JsonKey(name: 'identity_number')
  final String? identityNumber;
  @JsonKey(name: 'identity_image_id')
  final int? identityImageId;
  @JsonKey(name: 'identity_image')
  final Image? identityImage;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'phone_number')
  final String? phone;
  @JsonKey(name: 'pin')
  final String? pin;
  @JsonKey(name: 'is_ibu_amanah')
  final bool? isIbuAmanah;
  @JsonKey(name: 'is_agent')
  final bool? isAgent;
  @JsonKey(name: 'email')
  final String? email;
  @JsonKey(name: 'can_access_saving')
  final bool? canAccessSaving;
  @JsonKey(name: 'validate_phone_number')
  final bool? validatePhoneNumber;
  @JsonKey(name: 'validation_message')
  final String? validationMessage;
  @JsonKey(name: 'is_saving_user')
  final bool? isSavingUser;
  @JsonKey(name: 'coordinator_id')
  final int? coordinatorId;
  @JsonKey(name: 'profile_image_id')
  final int? profileImageId;
  @JsonKey(name: 'profile_image')
  final Image? profileImage;
  @JsonKey(name: 'session_token')
  final String? sessionToken;
  @JsonKey(name: 'status')
  final String? status;
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @JsonKey(name: 'updated_at')
  final String? updatedAt;
  @JsonKey(name: 'deleted_at')
  final String? deletedAt;
  @JsonKey(name: 'mitra_id')
  final int? mitraId;
  @JsonKey(name: 'mitra_name')
  final String? mitraName;
  @JsonKey(name: 'mitra_loan_stage')
  final String? mitraLoanStage;
  @JsonKey(name: 'mitra_region')
  final String? mitraRegion;
  @JsonKey(name: 'mitra_area_id')
  final int? mitraAreaId;
  @JsonKey(name: 'mitra_area')
  final String? mitraArea;
  @JsonKey(name: 'mitra_branch_id')
  final int? mitraBranchId;
  @JsonKey(name: 'mitra_branch')
  final String? mitraBranch;
  @JsonKey(name: 'mitra_majelis_id')
  final int? mitraMajelisId;
  @JsonKey(name: 'mitra_majelis')
  final String? mitraMajelis;
  @JsonKey(name: 'is_bank_partner')
  final bool? isBankPartner;
  @JsonKey(name: 'is_pin_expired')
  final bool? isPinExpired;
  @JsonKey(name: 'is_neobank')
  final bool? isNeobank;
  @JsonKey(name: 'is_available_ewallet')
  final bool? isAvailableEwallet;

  PostUserProfileResponse({
    this.id,
    this.code,
    this.customerNumber,
    this.identityNumber,
    this.identityImageId,
    this.identityImage,
    this.name,
    this.phone,
    this.pin,
    this.isIbuAmanah,
    this.isAgent,
    this.email,
    this.canAccessSaving,
    this.validatePhoneNumber,
    this.validationMessage,
    this.isSavingUser,
    this.coordinatorId,
    this.profileImageId,
    this.profileImage,
    this.sessionToken,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.mitraId,
    this.mitraName,
    this.mitraLoanStage,
    this.mitraRegion,
    this.mitraAreaId,
    this.mitraArea,
    this.mitraBranchId,
    this.mitraBranch,
    this.mitraMajelisId,
    this.mitraMajelis,
    this.isBankPartner,
    this.isPinExpired,
    this.isNeobank,
    this.isAvailableEwallet,
  });

  factory PostUserProfileResponse.fromJson(Json json) =>
      _$PostUserProfileResponseFromJson(json);

  Json toJson() => _$PostUserProfileResponseToJson(this);
}
