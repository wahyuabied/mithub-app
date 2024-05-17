import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mithub_app/design/app_assets.dart';
import 'package:mithub_app/design/colors.dart';
import 'package:mithub_app/design/theme_extension.dart';
import 'package:mithub_app/design/widget/error_loading_dialog.dart';
import 'package:mithub_app/feature/scanner/qr_scanner_provider.dart';
import 'package:mithub_app/routes/auth_routes.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrScanner extends StatefulWidget {
  final Function(String)? onScanned;
  final bool isTransaction;

  const QrScanner({
    super.key,
    this.onScanned,
    this.isTransaction = false,
  });

  @override
  State<QrScanner> createState() => _QrScannerState();
}

class _QrScannerState extends State<QrScanner> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  void initState() {
    super.initState();
  }

  void onResulted(QrScannerState state) {
    controller!.resumeCamera();
    var messageTitle = '';
    if (state.isErrorQrCode) {
      messageTitle = 'Kode QR Tidak Sesuai';
      _showErrorDialog(
        title: messageTitle,
        subtitle: 'Pastikan kode QR sudah benar',
      );
    } else if (state.isSuccess) {
      // context.pushReplacementNamed(
      //   QrScannerRoutes.qrPayment.name!,
      //   extra: QrPaymentExtra(
      //     data: state.transactionData!,
      //     balance: state.balance,
      //     phoneNo: state.phoneNo,
      //   ),
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => QrScannerProvider(onResulted: onResulted),
      child: layout(context),
    );
  }

  Widget layout(context) {
    return Material(
      color: Colors.white,
      child: Selector<QrScannerProvider, QrScannerState>(
        selector: (context, provider) => provider.state,
        builder: (context, state, child) {
          return Stack(
            children: [
              Positioned.fill(
                child: QRView(
                  key: qrKey,
                  onQRViewCreated: ((controller) {
                    this.controller = controller;
                    controller.resumeCamera();
                    controller.scannedDataStream.listen(
                      (scanData) {
                        if (widget.onScanned != null && !widget.isTransaction) {
                          widget.onScanned!(scanData.code ?? '');
                        } else if (widget.isTransaction) {
                          controller.pauseCamera();
                          _scannerRouting(context, scanData.code ?? '');
                        } else {
                          controller.dispose();
                          context.pop(scanData.code ?? '');
                        }
                      },
                    );
                  }),
                  overlay: QrScannerOverlayShape(
                    borderColor: Colors.grey,
                    borderRadius: 10.r,
                    borderLength: 30.r,
                    borderWidth: 10.r,
                    cutOutSize: 300.r,
                  ),
                ),
              ),
              SafeArea(
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(width: 8.w),
                        IconButton(
                          onPressed: () {
                            context.pop();
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            size: 25.r,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          'QR SCAN',
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontSize: 18.sp,
                                    color: Colors.white,
                                  ),
                        ),
                        const Spacer(),
                        InkWell(
                            onTap: () {
                              controller!.toggleFlash();
                            },
                            child: SvgPicture.asset(AppAssets.icBelanja)),
                        SizedBox(width: 20.w),
                      ],
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        context.pushNamed(AuthRoutes.qrGeneratorPage.name!);
                      },
                      child: Container(
                        width: double.infinity,
                        margin: EdgeInsets.all(20.r),
                        padding: EdgeInsets.all(16.r),
                        decoration: BoxDecoration(
                            color: FunDsColors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.r))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(AppAssets.icBelanja),
                            SizedBox(width: 4.w),
                            Text(
                              'Tunjukan QR Code',
                              style: context.textTheme.titleSmall,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: state.isLoading,
                child: const Align(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void _showErrorDialog({String? title, String? subtitle}) {
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
          title: title ?? '',
          subtitle: subtitle ?? '',
          imageAsset: 'assets/images/error_ibu_amanah_whistle.png',
          primaryButtonText: 'Mengerti',
          showButtonSecondary: false,
          centerTitle: false,
          centerSubtitle: false,
          secondaryButtonText: '',
          onClickPrimary: () {
            context.pop();
          },
        );
      },
    );
  }

  void _scannerRouting(BuildContext context, String scanResult) {
    /// marketplace-productId-phoneNumber
    final rawResult = scanResult.split('-');
    if (rawResult.length == 3) {
      final productId = rawResult[1];
      final customerNumber = rawResult[2];
      debugPrint('aim => $productId-$customerNumber');
      context.pushNamed(
        AuthRoutes.paymentPage.name!,
        extra: QrPaymentExtra(
          productId: productId,
          customerNumber: customerNumber,
        ),
      );
    } else {
      _showErrorDialog(
        title: 'Kode QR Tidak Sesuai',
        subtitle: 'Pastikan kode QR sudah benar',
      );
    }
  }
}
