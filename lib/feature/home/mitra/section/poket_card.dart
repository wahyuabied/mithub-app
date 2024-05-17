import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mithub_app/core/formatter/currency_formatter.dart';
import 'package:mithub_app/core/type_defs.dart';
import 'package:mithub_app/design/app_assets.dart';
import 'package:mithub_app/design/colors.dart';
import 'package:mithub_app/design/theme_extension.dart';
import 'package:mithub_app/design/widget/common_dialog.dart';
import 'package:mithub_app/design/widget/error_loading_dialog.dart';
import 'package:mithub_app/design/widget/icon_text.dart';
import 'package:mithub_app/feature/home/mitra/section/balance_container_card.dart';
import 'package:mithub_app/feature/home/mitra/section/poket_data.dart';
import 'package:mithub_app/feature/home/mitra/section/premium_badge.dart';
import 'package:mithub_app/feature/home/mitra/view_model/poket_card_view_model.dart';
import 'package:provider/provider.dart';

class PocketCard extends StatelessWidget {
  const PocketCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Selector<PocketCardViewModel, PocketState>(
        selector: (context, vm) => vm.pocketState,
        builder: (context, pocketState, child) {
          switch (pocketState) {
            case ShimmerPocketState():
              return const BalanceContainerCard.shimmer();
            case HiddenPocketState():
              return const SizedBox.shrink();
            case InactivePocketState():
              return _InactivePocketCard(
                pocketCardData: pocketState.pocketCardData,
                walletName: 'Pocket',
              );
            case FrozenPocketState():
              return _ActivePocketCard(
                pocketCardData: pocketState.pocketCardData,
                walletName: context.selectModel((m) => 'Pocket'),
                showEwalletPremiumUpgrade: context.selectModel(
                  (m) => m.showEwalletPremiumUpgrade,
                ),
                showTransferButton: context.selectModel(
                  (m) => m.showTransferButton,
                ),
                isFrozen: true,
              );
            case ActivePocketState():
              return _ActivePocketCard(
                pocketCardData: pocketState.pocketCardData,
                walletName: context.selectModel((m) => 'Pocket'),
                showEwalletPremiumUpgrade: context.selectModel(
                  (m) => m.showEwalletPremiumUpgrade,
                ),
                showTransferButton: context.selectModel(
                  (m) => m.showTransferButton,
                ),
                isFrozen: false,
              );
          }
        },
      ),
    );
  }
}

extension _PocketCardViewModelExtension on BuildContext {
  T selectModel<T>(T Function(PocketCardViewModel m) selector) =>
      select<PocketCardViewModel, T>(selector);
}

class _UpgradePremium extends StatelessWidget {
  final String walletName;
  final PocketCardData pocketCardData;
  final void Function() onPressed;

  const _UpgradePremium({
    required this.walletName,
    required this.pocketCardData,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final displayText = 'Maksimalkan fitur '
        '${walletName.toLowerCase()} '
        'dengan upgrade ke premium';
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
          ),
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8)),
          gradient: LinearGradient(
            colors: [
              const Color(0xFF6664E0).withOpacity(0.8),
              const Color(0xFF853291).withOpacity(0.8)
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 3,
            child: Text(
              pocketCardData.displayText ?? displayText,
              style: context.textTheme.bodySmall?.copyWith(
                color: Colors.white,
              ),
            ),
          ),
          Flexible(
            flex: pocketCardData.buttonText?.toLowerCase() == 'perbaiki data'
                ? 2
                : 1,
            child: TextButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                pocketCardData.buttonText ?? 'Upgrade',
                style: context.textTheme.bodySmall?.copyWith(
                  fontSize: 10.sp,
                  color: FunDsColors.primaryBase,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _ActivePocketCard extends StatelessWidget {
  final PocketCardData pocketCardData;
  final String walletName;
  final bool showTransferButton;
  final bool showEwalletPremiumUpgrade;
  final bool isFrozen;

  const _ActivePocketCard({
    required this.pocketCardData,
    required this.walletName,
    required this.showTransferButton,
    required this.showEwalletPremiumUpgrade,
    required this.isFrozen,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BalanceContainerCard(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(4.r),
            bottom:
                showEwalletPremiumUpgrade ? Radius.zero : Radius.circular(4.r),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(width: 4.w),
                        Visibility(
                          visible: pocketCardData.isWalletPremium,
                          child: const PremiumBadge(),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          isFrozen ? 'Akun Dibekukan' : 'Rp',
                          style: context.textTheme.bodySmall?.copyWith(
                            color: FunDsColors.neutralThree,
                          ),
                        ),
                        SizedBox(
                          width: 3.w,
                          height: isFrozen ? 20.h : 0.h,
                        ),
                        Visibility(
                          visible: !isFrozen,
                          child: Text(
                            CurrencyFormatter.getCurrencyFormat(
                              double.parse(pocketCardData.amount!),
                              withSymbol: false,
                            ),
                            style: context.textTheme.titleLarge?.copyWith(
                              color: FunDsColors.neutralTwo,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.w),
                    InkWell(
                      onTap: () => {},
                      child: Row(
                        children: [
                          Text(
                            'Riwayat Transaksi',
                            style: context.textTheme.bodySmall?.copyWith(
                              color: FunDsColors.primaryBase,
                            ),
                          ),
                          const Icon(
                            Icons.arrow_forward,
                            size: 15,
                            color: FunDsColors.primaryBase,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconText(
                          itemImage: AppAssets.icDepositIcon,
                          itemName: 'TopUp Saldo',
                          onPressed: () => {},
                        ),
                      ],
                    ),
                    SizedBox(width: 12.w),
                    Visibility(
                      visible: showTransferButton,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconText(
                            itemImage: AppAssets.icEwalletTransfer,
                            itemName: 'Transfer Ewallet',
                            onPressed: () => {},
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Visibility(
          visible: showEwalletPremiumUpgrade,
          child: _UpgradePremium(
            walletName: walletName,
            pocketCardData: pocketCardData,
            onPressed: () => {},
          ),
        ),
      ],
    );
  }

  void _gotoEwalletBalanceScreen(BuildContext context) {
    // context.pushNamed(EwalletRoutes.ewalletLanding.name!);
  }

  void showTransferDialog(BuildContext context) {
    showCommonBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return SizedBox();
        // return const DialogPoketTransfer();
      },
    );
  }
}

class _InactivePocketCard extends StatelessWidget {
  final PocketCardData pocketCardData;
  final String walletName;

  const _InactivePocketCard({
    required this.walletName,
    required this.pocketCardData,
  });

  @override
  Widget build(BuildContext context) {
    return BalanceContainerCard(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(4.r),
        bottom: Radius.zero,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    walletName,
                    style: context.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: FunDsColors.neutralTwo,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Yuk aktifkan sekarang buat bayar '
                    'ini itu lebih mudah lewat $walletName Anda.',
                    style: context.textTheme.bodySmall?.copyWith(
                      color: FunDsColors.neutralThree,
                    ),
                    overflow: TextOverflow.visible,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 24.h,
              width: 24.w,
              child: IconButton(
                padding: EdgeInsets.zero,
                visualDensity: VisualDensity.compact,
                alignment: Alignment.center,
                onPressed: () => _onPressedInactivePocket(context),
                icon: Icon(
                  Icons.chevron_right,
                  size: 24.r,
                  color: FunDsColors.primaryBase,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onPressedInactivePocket(BuildContext context) {
    if (pocketCardData.isWalletRegistered) {
      _showErrorDialog(context, walletName);
    } else {
      _openWebView(context, walletName);
    }
  }

  void _showErrorDialog(BuildContext context, String walletName) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: FunDsColors.white,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12.r),
          topRight: Radius.circular(12.r),
        ),
      ),
      builder: (BuildContext context) {
        return ErrorDialog(
          title: 'Wallet tidak aktif',
          subtitle: 'wallet tidak aktif ya',
          imageAsset: 'assets/images/error_ibu_amanah_green.png',
          primaryButtonText: 'Ke Amartha Care',
          onClickPrimary: () => {},
          secondaryButtonText: 'Kembali',
          centerTitle: false,
        );
      },
    );
  }

  void _openWebView(BuildContext context, String walletName) {
    var data = jsonEncode(_webViewData);
    String javaScript = '''
    window.localStorage.setItem("registrationRequest", JSON.stringify($data));''';

  }

  Json get _webViewData {
    Map<String, String> deviceInfo = {
      'os': Platform.operatingSystem,
      'osVersion': '',
      'model': '',
      'manufacture': ''
    };
    Map<String, String> additionalInfo = {
      'deviceId': '',
      'channel': 'mobilephone'
    };
    Map<String, dynamic> cookies = {
      'name': pocketCardData.userProfile!.name,
      'phoneNo': pocketCardData.userProfile!.phone,
      'countryCode': '',
      'customerId': pocketCardData.userProfile!.customerNumber,
      'deviceInfo': deviceInfo,
      'lang': '',
      'locale': '',
      'additionalInfo': additionalInfo
    };
    return cookies;
  }
}
