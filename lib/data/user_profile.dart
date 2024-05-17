import 'package:mithub_app/data/dto_user_profile.dart';
import 'package:mithub_app/data/user_role.dart';

import 'dto_image.dart';

/// User Profile rich object model, contains sensible default value.
/// for DTO, look at [PostUserProfileResponse]
class UserProfile {
  final int id;
  final String code;
  final String customerNumber;
  final String identityNumber;
  final int identityImageId;
  final Image? identityImage;
  final String name;
  final String phone;
  final String pin;
  final bool isIbuAmanah;
  final bool isAgent;
  final String email;
  final bool canAccessSaving;
  final bool validatePhoneNumber;
  final String validationMessage;
  final bool isSavingUser;
  final int coordinatorId;
  final int profileImageId;
  final Image? profileImage;
  final String sessionToken;
  final String status;
  final String createdAt;
  final String updatedAt;
  final String deletedAt;
  final int mitraId;
  final String mitraName;
  final String mitraLoanStage;
  final String mitraRegion;
  final int mitraAreaId;
  final String mitraArea;
  final int mitraBranchId;
  final String mitraBranch;
  final int mitraMajelisId;
  final String mitraMajelis;
  final bool isBankPartner;
  final bool isPinExpired;
  final bool isNeobank;
  final bool isAvailableEwallet;

  UserProfile({
    required this.id,
    required this.code,
    required this.customerNumber,
    required this.identityNumber,
    required this.identityImageId,
    required this.identityImage,
    required this.name,
    required this.phone,
    required this.pin,
    required this.isIbuAmanah,
    required this.isAgent,
    required this.email,
    required this.canAccessSaving,
    required this.validatePhoneNumber,
    required this.validationMessage,
    required this.isSavingUser,
    required this.coordinatorId,
    required this.profileImageId,
    required this.profileImage,
    required this.sessionToken,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.mitraId,
    required this.mitraName,
    required this.mitraLoanStage,
    required this.mitraRegion,
    required this.mitraAreaId,
    required this.mitraArea,
    required this.mitraBranchId,
    required this.mitraBranch,
    required this.mitraMajelisId,
    required this.mitraMajelis,
    required this.isBankPartner,
    required this.isPinExpired,
    required this.isNeobank,
    required this.isAvailableEwallet,
  });

  factory UserProfile.fromResponse(PostUserProfileResponse response) {
    return UserProfile(
      id: response.id ?? -1,
      code: response.code ?? '',
      customerNumber: response.customerNumber ?? '',
      identityNumber: response.identityNumber ?? '',
      identityImageId: response.identityImageId ?? -1,
      identityImage: response.identityImage,
      name: response.name ?? '',
      phone: response.phone ?? '',
      pin: response.pin ?? '',
      isIbuAmanah: response.isIbuAmanah ?? false,
      isAgent: response.isAgent ?? false,
      email: response.email ?? '',
      canAccessSaving: response.canAccessSaving ?? false,
      validatePhoneNumber: response.validatePhoneNumber ?? false,
      validationMessage: response.validationMessage ?? '',
      isSavingUser: response.isSavingUser ?? false,
      coordinatorId: response.coordinatorId ?? -1,
      profileImageId: response.profileImageId ?? -1,
      profileImage: response.profileImage,
      sessionToken: response.sessionToken ?? '',
      status: response.status ?? '',
      createdAt: response.createdAt ?? '',
      updatedAt: response.updatedAt ?? '',
      deletedAt: response.deletedAt ?? '',
      mitraId: response.mitraId ?? -1,
      mitraName: response.mitraName ?? '',
      mitraLoanStage: response.mitraLoanStage ?? '',
      mitraRegion: response.mitraRegion ?? '',
      mitraAreaId: response.mitraAreaId ?? -1,
      mitraArea: response.mitraArea ?? '',
      mitraBranchId: response.mitraBranchId ?? -1,
      mitraBranch: response.mitraBranch ?? '',
      mitraMajelisId: response.mitraMajelisId ?? -1,
      mitraMajelis: response.mitraMajelis ?? '',
      isBankPartner: response.isBankPartner ?? false,
      isPinExpired: response.isPinExpired ?? false,
      isNeobank: response.isNeobank ?? false,
      isAvailableEwallet: response.isAvailableEwallet ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'mitra_id': mitraId,
      'identity_number': identityNumber,
      'mitra_name': mitraName,
      'mitra_loan_stage': mitraLoanStage,
      'mitra_region': mitraRegion,
      'mitra_area_id': mitraAreaId,
      'mitra_branch_id': mitraBranchId,
      'mitra_majelis_id': mitraMajelisId,
    };
  }

  PostUserProfileResponse toResponse() {
    return PostUserProfileResponse(
      id: id,
      code: code,
      customerNumber: customerNumber,
      identityNumber: identityNumber,
      identityImageId: identityImageId,
      identityImage: identityImage,
      name: name,
      phone: phone,
      pin: pin,
      isIbuAmanah: isIbuAmanah,
      isAgent: isAgent,
      email: email,
      canAccessSaving: canAccessSaving,
      validatePhoneNumber: validatePhoneNumber,
      validationMessage: validationMessage,
      isSavingUser: isSavingUser,
      coordinatorId: coordinatorId,
      profileImageId: profileImageId,
      profileImage: profileImage,
      sessionToken: sessionToken,
      status: status,
      createdAt: createdAt,
      updatedAt: updatedAt,
      deletedAt: deletedAt,
      mitraId: mitraId,
      mitraName: mitraName,
      mitraLoanStage: mitraLoanStage,
      mitraRegion: mitraRegion,
      mitraAreaId: mitraAreaId,
      mitraArea: mitraArea,
      mitraBranchId: mitraBranchId,
      mitraBranch: mitraBranch,
      mitraMajelisId: mitraMajelisId,
      mitraMajelis: mitraMajelis,
      isBankPartner: isBankPartner,
      isPinExpired: isPinExpired,
      isNeobank: isNeobank,
      isAvailableEwallet: isAvailableEwallet,
    );
  }

  UserProfile copyWith({
    int? id,
    String? code,
    String? customerNumber,
    String? identityNumber,
    int? identityImageId,
    Image? identityImage,
    String? name,
    String? phone,
    String? pin,
    bool? isIbuAmanah,
    bool? isMitra,
    String? email,
    bool? canAccessSaving,
    bool? validatePhoneNumber,
    String? validationMessage,
    bool? isSavingUser,
    int? coordinatorId,
    int? profileImageId,
    Image? profileImage,
    String? sessionToken,
    String? status,
    String? createdAt,
    String? updatedAt,
    String? deletedAt,
    int? mitraId,
    String? mitraName,
    String? mitraLoanStage,
    String? mitraRegion,
    int? mitraAreaId,
    String? mitraArea,
    int? mitraBranchId,
    String? mitraBranch,
    int? mitraMajelisId,
    String? mitraMajelis,
    bool? isBankPartner,
    bool? isPinExpired,
    bool? isNeobank,
    bool? isAvailableEwallet,
  }) {
    return UserProfile(
      id: id ?? this.id,
      code: code ?? this.code,
      customerNumber: customerNumber ?? this.customerNumber,
      identityNumber: identityNumber ?? this.identityNumber,
      identityImageId: identityImageId ?? this.identityImageId,
      identityImage: identityImage ?? this.identityImage,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      pin: pin ?? this.pin,
      isIbuAmanah: isIbuAmanah ?? this.isIbuAmanah,
      isAgent: isMitra ?? this.isAgent,
      email: email ?? this.email,
      canAccessSaving: canAccessSaving ?? this.canAccessSaving,
      validatePhoneNumber: validatePhoneNumber ?? this.validatePhoneNumber,
      validationMessage: validationMessage ?? this.validationMessage,
      isSavingUser: isSavingUser ?? this.isSavingUser,
      coordinatorId: coordinatorId ?? this.coordinatorId,
      profileImageId: profileImageId ?? this.profileImageId,
      profileImage: profileImage ?? this.profileImage,
      sessionToken: sessionToken ?? this.sessionToken,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      mitraId: mitraId ?? this.mitraId,
      mitraName: mitraName ?? this.mitraName,
      mitraLoanStage: mitraLoanStage ?? this.mitraLoanStage,
      mitraRegion: mitraRegion ?? this.mitraRegion,
      mitraAreaId: mitraAreaId ?? this.mitraAreaId,
      mitraArea: mitraArea ?? this.mitraArea,
      mitraBranchId: mitraBranchId ?? this.mitraBranchId,
      mitraBranch: mitraBranch ?? this.mitraBranch,
      mitraMajelisId: mitraMajelisId ?? this.mitraMajelisId,
      mitraMajelis: mitraMajelis ?? this.mitraMajelis,
      isBankPartner: isBankPartner ?? this.isBankPartner,
      isPinExpired: isPinExpired ?? this.isPinExpired,
      isNeobank: isNeobank ?? this.isNeobank,
      isAvailableEwallet: isAvailableEwallet ?? this.isAvailableEwallet,
    );
  }

  bool get isSavingVisible => canAccessSaving && (isNeobank || isSavingUser);
}

extension UserRoleExt on UserProfile {
  UserRole toUserRole() {
    if (isAgent) {
      return UserRole.agent;
    } else {
      return UserRole.mitra;
    }
  }
}
