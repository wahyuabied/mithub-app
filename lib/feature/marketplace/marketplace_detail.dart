import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:go_router/go_router.dart';
import 'package:mithub_app/design/app_assets.dart';
import 'package:mithub_app/design/colors.dart';
import 'package:mithub_app/design/theme_extension.dart';
import 'package:mithub_app/design/widget/common_dialog.dart';
import 'package:mithub_app/feature/marketplace/marketplace_detail_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class MarketplaceDetail extends StatelessWidget{
  const MarketplaceDetail({
    super.key,
    required this.productId,
  });
  final int productId;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MarketplaceDetailViewModel>(
      create: (context) => MarketplaceDetailViewModel()..onViewLoaded(productId),
      child: _MarketplaceDetailView(),
    );
  }

}

class _MarketplaceDetailView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var vm = context.watch<MarketplaceDetailViewModel>();
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 8.h),
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
                    color: Colors.black,
                  ),
                ),
                SizedBox(width: 8.w),
                Text(
                  'Detail Produk',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: 18.sp,
                        color: Colors.black,
                      ),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(16.r),
                  child: Column(
                    children: [
                      Image.network(
                        'http://20.20.24.134:3000' + (vm.data.lastData?.file?.path ?? ''),
                        height: 200.h,
                      ),
                      SizedBox(height: 16.h),
                      HtmlWidget(vm.data.lastData?.description ?? ''),
                    ],
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                _generateQrCode(context, (vm.data.lastData?.id ?? 0).toString(), vm.data.lastData?.borrower?.phoneNumber ?? '');
              },
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.all(20.r),
                padding: EdgeInsets.all(16.r),
                decoration: BoxDecoration(
                    color: FunDsColors.primaryBase,
                    borderRadius: BorderRadius.all(Radius.circular(12.r))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(AppAssets.icBelanja),
                    SizedBox(width: 4.w),
                    Text(
                      'Tunjukan QR Code',
                      style: context.textTheme.titleSmall
                          ?.copyWith(color: FunDsColors.white),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _generateQrCode(
    BuildContext context,
    String productId,
    String customerNumber,
  ) {
    showCommonBottomSheet(
        context: context,
        isDismissible: true,
        builder: (ctx) {
          final qrCode = 'marketplace-$productId-$customerNumber';
          return Container(
            padding: EdgeInsets.all(16.r),
            child: Wrap(
              children: [
                Center(
                  child: QrImageView(
                    data: qrCode,
                    size: 280,
                  ),
                ),
              ],
            )
          );
        });
  }
}
