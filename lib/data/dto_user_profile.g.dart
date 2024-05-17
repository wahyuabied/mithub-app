// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dto_user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostUserProfileResponse _$PostUserProfileResponseFromJson(
        Map<String, dynamic> json) =>
    PostUserProfileResponse(
      id: (json['id'] as num?)?.toInt(),
      code: json['code'] as String?,
      customerNumber: json['customer_number'] as String?,
      identityNumber: json['identity_number'] as String?,
      identityImageId: (json['identity_image_id'] as num?)?.toInt(),
      identityImage: json['identity_image'] == null
          ? null
          : Image.fromJson(json['identity_image'] as Map<String, dynamic>),
      name: json['name'] as String?,
      phone: json['phone_number'] as String?,
      pin: json['pin'] as String?,
      isIbuAmanah: json['is_ibu_amanah'] as bool?,
      isAgent: json['is_agent'] as bool?,
      email: json['email'] as String?,
      canAccessSaving: json['can_access_saving'] as bool?,
      validatePhoneNumber: json['validate_phone_number'] as bool?,
      validationMessage: json['validation_message'] as String?,
      isSavingUser: json['is_saving_user'] as bool?,
      coordinatorId: (json['coordinator_id'] as num?)?.toInt(),
      profileImageId: (json['profile_image_id'] as num?)?.toInt(),
      profileImage: json['profile_image'] == null
          ? null
          : Image.fromJson(json['profile_image'] as Map<String, dynamic>),
      sessionToken: json['session_token'] as String?,
      status: json['status'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      deletedAt: json['deleted_at'] as String?,
      mitraId: (json['mitra_id'] as num?)?.toInt(),
      mitraName: json['mitra_name'] as String?,
      mitraLoanStage: json['mitra_loan_stage'] as String?,
      mitraRegion: json['mitra_region'] as String?,
      mitraAreaId: (json['mitra_area_id'] as num?)?.toInt(),
      mitraArea: json['mitra_area'] as String?,
      mitraBranchId: (json['mitra_branch_id'] as num?)?.toInt(),
      mitraBranch: json['mitra_branch'] as String?,
      mitraMajelisId: (json['mitra_majelis_id'] as num?)?.toInt(),
      mitraMajelis: json['mitra_majelis'] as String?,
      isBankPartner: json['is_bank_partner'] as bool?,
      isPinExpired: json['is_pin_expired'] as bool?,
      isNeobank: json['is_neobank'] as bool?,
      isAvailableEwallet: json['is_available_ewallet'] as bool?,
    );

Map<String, dynamic> _$PostUserProfileResponseToJson(
        PostUserProfileResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'customer_number': instance.customerNumber,
      'identity_number': instance.identityNumber,
      'identity_image_id': instance.identityImageId,
      'identity_image': instance.identityImage?.toJson(),
      'name': instance.name,
      'phone_number': instance.phone,
      'pin': instance.pin,
      'is_ibu_amanah': instance.isIbuAmanah,
      'is_agent': instance.isAgent,
      'email': instance.email,
      'can_access_saving': instance.canAccessSaving,
      'validate_phone_number': instance.validatePhoneNumber,
      'validation_message': instance.validationMessage,
      'is_saving_user': instance.isSavingUser,
      'coordinator_id': instance.coordinatorId,
      'profile_image_id': instance.profileImageId,
      'profile_image': instance.profileImage?.toJson(),
      'session_token': instance.sessionToken,
      'status': instance.status,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'deleted_at': instance.deletedAt,
      'mitra_id': instance.mitraId,
      'mitra_name': instance.mitraName,
      'mitra_loan_stage': instance.mitraLoanStage,
      'mitra_region': instance.mitraRegion,
      'mitra_area_id': instance.mitraAreaId,
      'mitra_area': instance.mitraArea,
      'mitra_branch_id': instance.mitraBranchId,
      'mitra_branch': instance.mitraBranch,
      'mitra_majelis_id': instance.mitraMajelisId,
      'mitra_majelis': instance.mitraMajelis,
      'is_bank_partner': instance.isBankPartner,
      'is_pin_expired': instance.isPinExpired,
      'is_neobank': instance.isNeobank,
      'is_available_ewallet': instance.isAvailableEwallet,
    };
