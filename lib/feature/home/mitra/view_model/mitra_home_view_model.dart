import 'dart:async';

import 'package:mithub_app/core/di/service_locator.dart';
import 'package:mithub_app/core/network/core_http_repository.dart';
import 'package:mithub_app/core/state_management/a_base_change_notifier.dart';
import 'package:mithub_app/core/storage/core_secure_storage.dart';
import 'package:mithub_app/data/repository/auth_repository.dart';
import 'package:mithub_app/data/repository/user_profile_repository.dart';
import 'package:mithub_app/data/user_profile.dart';
import 'package:mithub_app/utils/result.dart';


class MitraHomeViewModel extends ABaseChangeNotifier {
  /// Services
  final authRepository = serviceLocator.get<AuthRepository>();
  final userProfileRepository = serviceLocator.get<UserProfileRepository>();
  final coreHttpRepository = serviceLocator.get<CoreHttpRepository>();
  final secureStorage = serviceLocator.get<CoreSecureStorage>();

  UserProfile userProfile;

  ResultState<int> notifCount = ResultState(
    initalValue: 0,
    useLastDataOnError: true,
  );
  ResultState<bool> isMitraWhitelist = ResultState(
    initalValue: false,
    useLastDataOnError: true,
  );
  ResultState<int> commissionData = ResultState(
    initalValue: 0,
    useLastDataOnError: true,
  );

  MitraHomeViewModel({
    required this.userProfile,
  });

  void fetchData(bool refreshNetwork) async {
    await fetchUserProfile(refreshNetwork);

  }

  Future fetchUserProfile(bool refreshNetwork) async {
    userProfile = await userProfileRepository.getUserProfile(refresh: refreshNetwork);
  }


  @override
  void dispose() {
    super.dispose();
  }
}
