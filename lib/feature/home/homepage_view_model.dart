import 'package:mithub_app/core/di/service_locator.dart';
import 'package:mithub_app/core/state_management/a_base_change_notifier.dart';
import 'package:mithub_app/data/repository/user_profile_repository.dart';
import 'package:mithub_app/data/user_profile.dart';
import 'package:mithub_app/utils/result.dart';

class HomepageViewModel extends ABaseChangeNotifier {
  /// Services
  final _userProfileRepository = serviceLocator.get<UserProfileRepository>();

  /// State
  Result<UserProfile> userProfileResult = const Result.initial();

  HomepageViewModel() {
    fetchUserProfile();
  }

  Future<bool> fetchUserProfile() {
    return Result.call(
      future: _userProfileRepository.getUserProfile(refresh: true),
      onResult: (result) {
        userProfileResult = result;
        notifyListeners();
      },
    );
  }
}
