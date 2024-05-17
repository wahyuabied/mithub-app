import 'package:mithub_app/core/state_management/a_base_change_notifier.dart';
import 'package:mithub_app/data/user_profile.dart';
import 'package:mithub_app/feature/home/mitra/section/poket_data.dart';
import 'package:mithub_app/utils/result.dart';

class PocketCardViewModel extends ABaseChangeNotifier {
  final UserProfile userProfile;

  PocketCardViewModel(this.userProfile);

  final ResultState<PocketCardData> _pocketCardData = ResultState(
    useLastDataOnError: true,
  );

  Result<PocketCardData> get pocketResult => _pocketCardData.result;

  bool get isVisible => true;

  bool get isActive {
    final lastData = _pocketCardData.lastData;
    if (lastData == null) return false;

    return lastData.isWalletRegistered && lastData.isWalletActive;
  }

  bool get showTransferButton {
    final lastData = _pocketCardData.lastData;
    if (lastData == null) return false;

    return lastData.isWalletRegistered;
  }

  bool get showEwalletPremiumUpgrade {
    final lastData = _pocketCardData.lastData;
    if (lastData == null) return false;

    return lastData.isWalletEntryVisible;
  }

  PocketState get pocketState {
    if (!isVisible) {
      return HiddenPocketState();
    }

    final result = _pocketCardData.result;
    switch (result) {
      case Initial<PocketCardData>():
        return ShimmerPocketState();
      case ResultError<PocketCardData>():
        return HiddenPocketState();
      case Loading<PocketCardData>():
        final lastData = _pocketCardData.lastData;
        if (lastData != null) {
          return _emitPocketState(lastData);
        }
        return ShimmerPocketState();
      case Success<PocketCardData>():
        return _emitPocketState(result.data);
    }
  }

  void fetchPocket() {
    Result.call(
      future: _internalFetchPocket(),
      onResult: (result) {
        _pocketCardData.setResult(result);
        notifyListeners();
      },
      onSuccess: (data){
        notifyListeners();
      }
    );
  }

  Future<PocketCardData> _internalFetchPocket() async {
    return PocketCardData(
      userProfile: userProfile,
      isWalletActive: true,
      isWalletRegistered: true,
      isWalletPremium: true,
      isWalletEntryVisible: true,
      amount: '2000',
      currency: '',
      hasPIN: true,
      webview: '',
    );
  }

  PocketState _emitPocketState(PocketCardData pocketCardData) {
    return ActivePocketState(pocketCardData);
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class NavigateToWebView {
  final String? urlWebView;
  final Map<String, String>? headers;
  final String? javascript;
  final List<String> additionalForcePopUrlList;

  NavigateToWebView({
    this.urlWebView,
    this.headers,
    this.javascript,
    this.additionalForcePopUrlList = const [],
  });
}

class ShowWalletRegistrationDialog {
  final String userPhoneNumber;
  final Map<String, String>? headers;
  final String urlRegistrationWebView;
  final String walletProductName;

  ShowWalletRegistrationDialog(
    this.urlRegistrationWebView,
    this.headers,
    this.userPhoneNumber,
    this.walletProductName,
  );
}

class ShowPocketFrozenDialog {
  final String walletProductName;

  ShowPocketFrozenDialog(this.walletProductName);
}

sealed class PocketState {}

final class HiddenPocketState implements PocketState {}

final class ShimmerPocketState implements PocketState {}

final class ActivePocketState implements PocketState {
  PocketCardData pocketCardData;

  ActivePocketState(this.pocketCardData);
}
