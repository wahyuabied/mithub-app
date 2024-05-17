import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:mithub_app/core/network/core_http_repository.dart';
import 'package:mithub_app/core/storage/core_secure_storage.dart';
import 'package:mithub_app/data/dto_check_mitra.dart';
import 'package:mithub_app/data/dto_check_pin.dart';
import 'package:mithub_app/data/dto_content_detail_marketplace_response.dart';
import 'package:mithub_app/data/dto_content_marketplace.dart';
import 'package:mithub_app/data/dto_user_inquiry_response.dart';
import 'package:mithub_app/data/repository/auth_network.dart';
import 'package:mithub_app/data/repository/core/login_result.dart';
import 'package:mithub_app/data/repository/core/response_extension.dart';
import 'package:mithub_app/data/repository/core/scalar_response.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:uuid/uuid.dart';

/// Single Source of Truth (SSOT) for any user authentication and authorization.
/// Provide service for Session and Auth management.
/// This Repository is integrating with [CoreHttpRepository] which is vital for
/// http auth headers.
class AuthRepository {
  final AuthNetwork _authNetwork;
  final CoreSecureStorage _secureStorage;
  final CoreHttpRepository _coreHttpRepository;
  final FirebaseMessaging _firebaseMessaging;

  AuthRepository(
    this._authNetwork,
    this._secureStorage,
    this._coreHttpRepository,
    this._firebaseMessaging,
  );

  static const oauthScope = ['openid'];
  static const oauthPrompt = ['login'];
  static const deviceUuidKey = 'device_uuid';
  static const mitraAccountKey = 'mitra_account';
  final userRolesKey = 'user_roles';
  final addNik = 'add_nik';

  /// Check if [mitraId] is a valid registered user
  Future<PostCheckMitraResponse?> checkMitraId(int mitraId) async {
    final response = await _authNetwork.postCheckMitra(mitraId: mitraId);
    if (response.isSuccess) {
      return response.data;
    } else {
      return null;
    }
  }

  Future<PostCheckPinRequest> checkPin(String pin) async {
    final response = await _authNetwork.checkPin(
      pin: pin,
    );
    return PostCheckPinRequest(
      statusCode: response.statusCode,
      statusMessage: response.statMsg ?? '',
    );
  }

  /// Check [phone] is registered A+ user
  Future<bool> checkPhoneIsRegistered(String phone) {
    return _authNetwork
        .postCheckRegisterPhone(phone)
        .then((response) =>
            response.isSuccess && response.data?.isRegistered == true)
        .onError<ClientException>((
      error,
      stackTrace,
    ) {
      debugPrint(error.message);
      debugPrint(stackTrace.toString());
      return false;
    });
  }

  /// Login using [phone] and [pin].
  /// When return [PinExpired] apps should prompt reset PIN.
  /// When isDeviceRegistered equals false, repository will immediately call
  /// [AuthNetwork.postRequestLoginOtp] and return [DeviceNotRegistered], then
  /// apps should prompt Input OTP.
  /// When return [ImmediateLogin] apps should proceed login.
  /// For any general error, will return [Failed].
  Future<LoginResult> login(
    String phone,
    String pin,
  ) async {
    return _authNetwork.postLogin(phone, pin).then((response) async {
      debugPrint(response.statMsg);
      if (response.isSuccess) {
        await saveSession(
          token: response.data?.token,
        );
        unawaited(saveFirebaseTokenToServer());
        return LoginResult.immediateLogin(response.data!);
      } else if (response.statusCode == 400) {
        // somehow failed to request login
        return LoginResult.wrongPin();
      } else if (response.statusCode == 429) {
        return LoginResult.tooMuchAttempt(
          response.statMsg ?? 'Too much attempt',
        );
      } else {
        return LoginResult.failed();
      }
    }).onError<ClientException>((error, stackTrace) {
      debugPrint(error.message);
      debugPrint(stackTrace.toString());
      return LoginResult.failed();
    });
  }

  Future<List<String>> loadUserRoles() async {
    return await _secureStorage.getList(userRolesKey);
  }

  /// return existing UUID v4 if exist, else will generate new UUID
  Future<String> deviceUuid() async {
    final uuid = await _secureStorage.getString(deviceUuidKey);
    if (uuid.isEmpty) {
      final newUuid = const Uuid().v4();
      await _secureStorage.setString(deviceUuidKey, newUuid);
      return newUuid;
    } else {
      return uuid;
    }
  }

  /// will not save null or empty [token], [sessionToken], [refreshToken]
  Future<void> saveSession({
    String? tokenId,
    String? token,
    String? refreshToken,
    String? sessionToken,
  }) async {
    if (tokenId?.isNotEmpty == true) {
      await _coreHttpRepository.setTokenId(tokenId!);
    }
    if (token?.isNotEmpty == true) {
      await _coreHttpRepository.setToken(token!);
    }
    if (refreshToken?.isNotEmpty == true) {
      await _coreHttpRepository.setRefreshToken(refreshToken!);
    }
  }

  Future<bool> isLoggedIn() => _coreHttpRepository.getToken().then(
        (token) => token.isNotEmpty,
      );

  /// return [int] or null if error
  Future<ScalarResponse<int>> saveFirebaseTokenToServer() {
    return _firebaseMessaging.getToken().then((fid) {
      return PackageInfo.fromPlatform().then((value) {
        return _authNetwork.postFcmToken(
          token: fid ?? '',
          platform: Platform.operatingSystem,
          version: value.version,
        );
      });
    });
  }

  /// return [int] or null if error
  Future<ScalarResponse<int>> deleteFirebaseToken() {
    return _firebaseMessaging.getToken().then((fid) async {
      unawaited(_firebaseMessaging.deleteToken());
      return _authNetwork.deleteFcmToken(fid ?? '');
    });
  }

  Future<void> clear() async {
    await _secureStorage.deleteData(mitraAccountKey);
  }

  Future<UserInquiryResponse?> getInquiry() async {
    var response = await _authNetwork.getInquiry();
    if(response.isSuccess){
      return response.data;
    }else{
      return null;
    }
  }

  Future<List<ContentMarketPlaceResponse>?> getContentMarketPlace(String keyword) async {
    var response = await _authNetwork.getListContentMarketPlace(keyword);
    if(response.isSuccess){
      return response.data;
    }else{
      return null;
    }
  }

  Future<ContentDetailMarketPlace?> getContentDetailMarketPlace(int id) async {
    var response = await _authNetwork.getContentMarketPlace(id);
    if(response.isSuccess){
      return response.data;
    }else{
      return null;
    }
  }

}
