import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:http/http.dart';
import 'package:mithub_app/core/storage/core_secure_storage.dart';
import 'package:mithub_app/core/type_defs.dart';
import 'package:mithub_app/data/dto_user_profile.dart';
import 'package:mithub_app/data/repository/auth_network.dart';
import 'package:mithub_app/data/repository/core/response_extension.dart';
import 'package:mithub_app/data/user_profile.dart';

class UserProfileRepository {
  final CoreSecureStorage _secureStorage;
  final AuthNetwork _authNetwork;

  UserProfile? _cachedUserProfile;

  UserProfileRepository(this._secureStorage, this._authNetwork);

  Future<int> get id async => (await getUserProfile()).id;

  Future<String> get phone async => (await getUserProfile()).phone;

  Future<String> get identityNumber async =>
      (await getUserProfile()).identityNumber;

  Future<bool> get isMitra async => (await getUserProfile()).isAgent;

  Future<int> get mitraId async => (await getUserProfile()).mitraId;

  Future<bool> get isNeobank async => (await getUserProfile()).isNeobank;

  static const userProfileKey = 'user_profile';

  /// If the data is found in cache, it will return the data from cache
  /// If the data is found in cache and [refresh] is true, it will fetch the
  /// data from the network and save it to local storage and return the data
  /// If the data is found in local storage but not in cache, it will return the
  /// data from local storage and save it to cache
  /// If the data is not found in both local storage and network, it will
  /// throw [NoUserProfileException]
  Future<UserProfile> getUserProfile({bool refresh = false}) async {
    if (!refresh && _cachedUserProfile != null) {
      return _cachedUserProfile!;
    }

    try {
      final response = await _authNetwork.getUserToken();
      if (response.isSuccess) {
        final remote = response.data;
        if (remote != null) {
          await _secureStorage.setString(
            userProfileKey,
            jsonEncode(remote.toJson()),
          );
          final userProfile = UserProfile.fromResponse(remote);
          _cacheUserProfile(userProfile);
        }
      }
    } on ClientException catch (e) {
      debugPrint(e.message);
    } catch (e) {
      debugPrint(e.toString());
    }

    final local = await _secureStorage.getString(userProfileKey);
    if (local.isEmpty) {
      throw NoUserProfileException();
    }

    final Json json = jsonDecode(local);
    final userProfile =
        UserProfile.fromResponse(PostUserProfileResponse.fromJson(json));
    _cacheUserProfile(userProfile);
    return userProfile;
  }

  void _cacheUserProfile(UserProfile userProfile) {
    _cachedUserProfile = userProfile;
  }

  Future<void> clear() async {
    await _secureStorage.deleteData(userProfileKey);
    _clearCachedUserProfile();
  }

  void _clearCachedUserProfile() {
    _cachedUserProfile = null;
  }
}

class NoUserProfileException implements Exception {
  @override
  String toString() => 'No user profile found';
}
