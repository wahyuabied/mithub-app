import 'dart:convert';
import 'dart:developer';

import 'package:mithub_app/core/network/http/core_http_builder.dart';
import 'package:mithub_app/data/dto_check_mitra.dart';
import 'package:mithub_app/data/dto_check_pin.dart';
import 'package:mithub_app/data/dto_check_register_phone.dart';
import 'package:mithub_app/data/dto_fcm_token.dart';
import 'package:mithub_app/data/dto_user_login.dart';
import 'package:mithub_app/data/dto_user_profile.dart';
import 'package:mithub_app/data/repository/core/api_response.dart';
import 'package:mithub_app/data/repository/core/json_response.dart';
import 'package:mithub_app/data/repository/core/scalar_response.dart';

class AuthNetwork {
  static const _checkRegisterPhone = 'register/checkRegisterPhone';
  static const _checkMitra = 'register/checkMitra';

  // Login
  static const _userToken = 'users/token';
  static const _userLogin = 'users/login';
  static const _userInquiry = 'inquiry-account?account_number=4000000001';

  // Profile
  static const _profileCheckPin = 'user/checkPin';

  static const _validateRequestUpdate =
      'user/requestUpdate/validateRequestUpdate';

  // Device FCM token
  static const _fcmToken = 'fcmToken';
  static const _deleteFcmToken = 'fcmToken/token';

  final CoreHttpBuilder _http;

  AuthNetwork(this._http);

  Future<ApiResponse> getValidateRequestUpdatePhone(String typeUpdate) async {
    var param = {'update_type': typeUpdate};
    final response = await _http
        .aplus(
      path: _validateRequestUpdate,
      query: param,
    )
        .get();
    return ApiResponse(response);
  }


  Future<JsonResponse<PostCheckMitraResponse>> postCheckMitra({
    required int mitraId,
  }) async {
    final response = await _http.aplus(path: _checkMitra).post(
      PostCheckMitraRequest(
        mitraId: mitraId,
      ),
    );

    final apiResponse = ApiResponse.json(
      response,
      PostCheckMitraResponse.fromJson,
    );

    return apiResponse;
  }


  Future<JsonResponse<PostCheckRegisterPhoneResponse>> postCheckRegisterPhone(
      String phone,
      ) async {
    final response = await _http.aplus(path: _checkRegisterPhone).post(
      PostCheckRegisterPhoneRequest(
        phone: phone,
      ),
    );
    log(jsonEncode(response.body));
    return ApiResponse.json(response, PostCheckRegisterPhoneResponse.fromJson);
  }

  Future<JsonResponse<PostUserLoginResponse>> postLogin(
      String phone,
      String pin,
      ) async {
    final request = PostUserLoginRequest(
      phoneNumber: phone,
      pin: pin,
    );
    final response = await _http.localHost(path: _userLogin).post(request);

    return ApiResponse.json(response, PostUserLoginResponse.fromJson);
  }

  Future<JsonResponse<PostUserProfileResponse>> getUserToken() async {
    final response = await _http.localHost(path: _userToken).get();

    return ApiResponse.json(response, PostUserProfileResponse.fromJson);
  }

  /// Get the newest FCM token for a [userId] or null
  /// return null if there is no FCM token in the server
  Future<JsonResponse<GetFcmTokenResponse?>> getFcmToken(String userId) async {
    final response = await _http.aplus(path: '$_fcmToken/$userId').get();

    return ApiResponse.json(response, GetFcmTokenResponse.fromJson);
  }

  /// return db table user_fcm_tokens id [int] or null
  Future<ScalarResponse<int>> postFcmToken({
    required String token,
    required String platform,
    required String version,
  }) async {
    final response = await _http.aplus(path: _fcmToken).post(
      PostFcmTokenRequest(
        token: token,
        type: platform,
        version: version,
      ),
    );

    return ApiResponse.scalar(response);
  }

  /// should call this when logging out
  /// return db table user_fcm_tokens id [int] or null
  Future<ScalarResponse<int>> deleteFcmToken(String token) async {
    final response =
    await _http.aplus(path: '$_deleteFcmToken/$token').delete();

    return ApiResponse.scalar(response);
  }


  Future<JsonResponse<PostCheckPinRequest>> checkPin(
      {required String pin}) async {
    final response = await _http.aplus(path: _profileCheckPin).post(
      {
        'pin': pin,
      },
    );

    final apiResponse = ApiResponse.json(
      response,
      PostCheckPinRequest.fromJson,
    );

    return apiResponse;
  }
}
