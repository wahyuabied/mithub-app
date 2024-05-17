import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mithub_app/core/formatter/currency_formatter.dart';
import 'package:mithub_app/design/app_assets.dart';
import 'package:mithub_app/design/colors.dart';
import 'package:mithub_app/design/theme_extension.dart';
import 'package:mithub_app/design/widget/common_dialog.dart';
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
        selector: (_, vm) => vm.pocketState,
        builder: (_, pocketState, child) {
          switch (pocketState) {
            case ShimmerPocketState():
              return const BalanceContainerCard.shimmer();
            case HiddenPocketState():
              return const SizedBox.shrink();
            case ActivePocketState():
              return _ActivePocketCard(
                pocketCardData: pocketState.pocketCardData,
                walletName: 'Pocket',
                showEwalletPremiumUpgrade: true,
                showTransferButton: true,
                isFrozen: false,
              );
          }
        },
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
                          itemName: 'Isi Saldo',
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
                            itemName: 'Transfer',
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
      ],
    );
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

