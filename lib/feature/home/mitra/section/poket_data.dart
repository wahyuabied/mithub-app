import 'package:equatable/equatable.dart';
import 'package:mithub_app/data/user_profile.dart';

class PocketCardData with EquatableMixin {
  final bool isWalletActive;
  final bool isWalletRegistered;
  final bool isWalletPremium;
  final bool isWalletEntryVisible;
  final String? amount;
  final String? currency;
  final String? registrationStatusCode;
  final String urlWebView;
  final String? displayText;
  final String? buttonText;
  final UserProfile? userProfile;
  final String? accountNo;
  final String? deviceId;
  final bool hasPIN;
  final String webview;

  const PocketCardData({
    this.isWalletActive = false,
    this.isWalletRegistered = false,
    this.isWalletPremium = false,
    this.isWalletEntryVisible = false,
    this.amount,
    this.currency,
    this.registrationStatusCode,
    this.urlWebView = '',
    this.displayText,
    this.buttonText,
    this.userProfile,
    this.accountNo,
    this.deviceId,
    this.hasPIN = true,
    this.webview = '',
  });

  @override
  List<Object?> get props => List.unmodifiable([
        isWalletActive,
        isWalletRegistered,
        isWalletPremium,
        isWalletEntryVisible,
        amount,
        currency,
        registrationStatusCode,
        urlWebView,
        displayText,
        buttonText,
        userProfile,
        accountNo,
        deviceId,
        hasPIN,
        webview,
      ]);
}
