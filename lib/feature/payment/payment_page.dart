import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mithub_app/core/formatter/currency_formatter.dart';
import 'package:mithub_app/data/dto_verify_body.dart';
import 'package:mithub_app/design/colors.dart';
import 'package:mithub_app/design/theme_extension.dart';
import 'package:mithub_app/design/widget/a_button.dart';
import 'package:mithub_app/design/widget/app_bar.dart';
import 'package:mithub_app/design/widget/error_loading_dialog.dart';
import 'package:mithub_app/design/widget/loading_dialog.dart';
import 'package:mithub_app/feature/payment/payment_provider.dart';
import 'package:mithub_app/feature/scanner/qr_scanner_provider.dart';
import 'package:mithub_app/routes/auth_routes.dart';
import 'package:provider/provider.dart';

class PaymentPage extends StatelessWidget {
  final QrPaymentExtra? extra;

  const PaymentPage({
    super.key,
    required this.extra,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => PaymentProvider(extra),
        child: _TransferInternalSearchView());
  }
}

class _TransferInternalSearchView extends StatelessWidget {
  void showErrorDialog({
    required BuildContext context,
    required String title,
    required String subtitle,
    required String imageAsset,
    String? primaryText,
    String? secondaryText,
  }) {
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
          title: title,
          subtitle: subtitle,
          centerTitle: false,
          imageAsset: imageAsset,
          primaryButtonText: primaryText ?? '',
          secondaryButtonText: secondaryText ?? '',
          showButtonSecondary: secondaryText != null,
        );
      },
    );
  }

  void showErrorNoData(BuildContext context) {
    showErrorDialog(
      context: context,
      title: 'Nomor tidak terdaftar',
      subtitle: 'Nomor Poket tidak ditemukan',
      imageAsset: 'assets/images/error_ibu_amanah_whistle.png',
      primaryText: 'Oke Mengerti',
    );
  }

  // void navigateToNextPage(
  //     BuildContext context, TransferSearchPhoneResponse data) {
  //   final name = data.name;
  //   final accountNo = data.accountNo;
  //   final phoneNo = data.additionalInfo?.phoneNo;
  //   final balance = data.accountInfo?[0].amount?.value;
  //   final monthlyInLimit = data.additionalInfo?.customerMonthlyInLimit;
  //
  //   context
  //       .pushNamed(EwalletRoutes.ewalletTransferInternalNominal.name!, extra: {
  //     'name': name,
  //     'phoneNo': phoneNo,
  //     'balance': balance,
  //     'monthlyInLimit': monthlyInLimit,
  //     'accountNo': accountNo,
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PaymentProvider>();

    return Scaffold(
      appBar: textAppBar('Pembayaran'),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16.r),
                child: Column(
                  children: [
                    Wrap(
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 24.r,
                              backgroundColor: FunDsColors.primaryBase,
                              child: Text((provider.data.lastData?.borrower?.name ?? '')[0] ?? '',
                                  style: context.textTheme.titleSmall
                                      ?.copyWith(color: FunDsColors.white)),
                            ),
                            SizedBox(width: 16.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  provider.data.lastData?.borrower?.name ?? '',
                                  style: context.textTheme.titleSmall,
                                ),
                                SizedBox(height: 2.h),
                                Text(provider.customerNumber,
                                    style: context.textTheme.titleSmall),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 40.h),
                    Wrap(
                      children: [
                        Row(
                          children: [
                            Image.network(
                              'http://20.20.24.134:3000' +
                                  (provider.data.lastData?.file?.path ?? ''),
                              height: 60.h,
                            ),
                            SizedBox(width: 16.w),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 2.h),
                                Text(provider.data.lastData?.name ?? '',
                                    style:
                                        context.textTheme.titleSmall?.copyWith(
                                      fontSize: 12.sp,
                                    )),
                                Text(
                                    CurrencyFormatter.getCurrencyFormat(
                                        double.parse(
                                            (provider.data.lastData?.price ?? 0)
                                                .toString())),
                                    style:
                                        context.textTheme.titleSmall?.copyWith(
                                      fontSize: 12.sp,
                                    )),
                                SizedBox(height: 20.h),
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () => provider.minusQuantity(),
                                      child: CircleAvatar(
                                        radius: 16.r,
                                        backgroundColor:
                                            FunDsColors.primaryBase,
                                        child: Text("-",
                                            style: context.textTheme.titleSmall
                                                ?.copyWith(
                                                    color: FunDsColors.white)),
                                      ),
                                    ),
                                    SizedBox(width: 12.w),
                                    Text(provider.quantity.toString(),
                                        style: context.textTheme.titleSmall),
                                    SizedBox(width: 12.w),
                                    InkWell(
                                      onTap: () => provider.plusQuantity(),
                                      child: CircleAvatar(
                                        radius: 16.r,
                                        backgroundColor:
                                            FunDsColors.primaryBase,
                                        child: Text("+",
                                            style: context.textTheme.titleSmall
                                                ?.copyWith(
                                                    color: FunDsColors.white)),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(8.r),
              child: Row(
                children: [
                  Text('Total',
                      style: context.textTheme.titleSmall?.copyWith(
                        fontSize: 12.sp,
                      )),
                  SizedBox(width: 8.w),
                  Text(
                      CurrencyFormatter.getCurrencyFormat(
                          provider.amount.toDouble()),
                      style: context.textTheme.titleSmall?.copyWith(
                        fontSize: 12.sp,
                      )),
                ],
              ),
            ),
            AButton(
              variant: ButtonVariant.primary,
              flat: true,
              child: const Text('Lanjutkan'),
              onPressed: () {
                LoadingDialog.runWithLoading(
                  context,
                  () {
                    return provider.inquiry();
                  },
                ).then((value) {
                  final body = VerifyTransferBody(
                    accountNumber: provider.accountNumber,
                    beneficiaryAccountNumber: provider.beneficiaryAccountNumber,
                    amount: provider.amount,
                    receiptNumber: value?.receiptNumber ?? '',
                    transactionId: (value?.transactionId ?? 0).toString(),
                  );

                  context.pushNamed(AuthRoutes.pinPage.name!, extra: body);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
