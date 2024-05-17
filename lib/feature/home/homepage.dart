import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mithub_app/data/user_profile.dart';
import 'package:mithub_app/design/app_assets.dart';
import 'package:mithub_app/design/colors.dart';
import 'package:mithub_app/design/theme_extension.dart';
import 'package:mithub_app/design/widget/error_loading_dialog.dart';
import 'package:mithub_app/design/widget/loading_dialog.dart';
import 'package:mithub_app/feature/home/homepage_view_model.dart';
import 'package:mithub_app/feature/home/mitra/mitra_home_page.dart';
import 'package:mithub_app/feature/scanner/qr_scanner.dart';
import 'package:mithub_app/feature/scanner/qr_scanner_provider.dart';
import 'package:mithub_app/routes/auth_routes.dart';
import 'package:mithub_app/utils/result.dart';
import 'package:mithub_app/utils/result_builder.dart';
import 'package:provider/provider.dart';

class Homepage extends StatelessWidget {
  const Homepage({
    super.key,
    required this.selectedPage,
    this.showAlreadyLogin = false,
  });

  final int selectedPage;
  final bool showAlreadyLogin;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomepageViewModel(),
      child: _HomepageContent(
        selectedPage: selectedPage,
        showAlreadyLogin: showAlreadyLogin,
      ),
    );
  }
}

class _HomepageContent extends StatefulWidget {
  const _HomepageContent({
    this.selectedPage = 0,
    this.showAlreadyLogin = false,
  });

  final int selectedPage;
  final bool showAlreadyLogin;

  @override
  State<_HomepageContent> createState() => _HomepageContentState();
}

class _HomepageContentState extends State<_HomepageContent> {
  int _currentPage = 0;
  PageController? _pageController;

  @override
  void initState() {
    super.initState();
    _currentPage = widget.selectedPage;
    _pageController = PageController(initialPage: _currentPage);
  }

  @override
  void didUpdateWidget(covariant _HomepageContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    if ((widget.selectedPage != oldWidget.selectedPage) &&
        (widget.selectedPage != _currentPage)) {
      setState(() {
        _currentPage = widget.selectedPage;
        _pageController?.jumpToPage(_currentPage);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final showScanMenu = true;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ResultSelectorBuilder<HomepageViewModel, UserProfile>(
          resultSelector: (context, p) => p.userProfileResult,
          defaultBuilder: (context, result) => const LoadingDialog(),
          errorBuilder: (context, error) => RefreshIndicator(
            onRefresh: () async {
              unawaited(context.read<HomepageViewModel>().fetchUserProfile());
            },
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 16.sp),
              children: [
                SizedBox(height: 16.h),
                Image.asset(
                  AppAssets.errorIbuAmanahWhistle,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Text(
                  'Terjadi Kesalahan, ulangi beberapa saat lagi atau hubungi Amartha Care untuk bantuan ya.',
                  textAlign: TextAlign.center,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          successBuilder: (context, success) => PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _pageController,
            children: [
              // if the order of one of these screen changed, make sure
              const MitraHomePage(),
              const QrScanner(),
              const SizedBox.shrink(),
            ],
            onPageChanged: (value) {
              setState(() {
                _currentPage = value;
              });
            },
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              AppAssets.icHomeInactive,
              width: 25.r,
              height: 25.r,
            ),
            activeIcon: Image.asset(
              AppAssets.icHomeActive,
              width: 25.r,
              height: 25.r,
            ),
            label: 'Home',
          ),
          if (showScanMenu)
            BottomNavigationBarItem(
              icon: Image.asset(
                AppAssets.icScanHomePage,
                width: 40.r,
                height: 40.r,
              ),
              label: 'Scan',
            ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AppAssets.icProfileInactive,
              width: 25.r,
              height: 25.r,
            ),
            activeIcon: SvgPicture.asset(
              AppAssets.icProfileActive,
              width: 25.r,
              height: 25.r,
            ),
            label: 'Profile',
          ),
        ],
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle:
            context.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w700),
        selectedItemColor: FunDsColors.primaryBase,
        unselectedLabelStyle:
            context.textTheme.bodySmall?.copyWith(fontSize: 10.sp),
        unselectedItemColor: FunDsColors.primaryBase200,
        showUnselectedLabels: true,
        onTap: (index) {
          _onTapNavbar(index, showScanMenu);
        },
        currentIndex: _currentPage,
      ),
    );
  }

  void _onTapNavbar(int index, bool showScanMenu) {
    Result<UserProfile> userProfile =
        context.read<HomepageViewModel>().userProfileResult;

    // disable user ability to change page during pre-drawn page
    if (userProfile.isInitialOrLoading || userProfile.dataOrNull == null) {
      return;
    }

    if (index == 1) {
      _openQrScanner(context);
    } else {
      context.goNamed(
        AuthRoutes.homepage.name!,
        queryParameters: {
          'page': index.toString(),
        },
      );
    }
  }

  void _openQrScanner(BuildContext context) async {
    var extra = QrScannerExtra(
      isTransaction: true,
    );
    await context.pushNamed(
      AuthRoutes.qrScanner.name!,
      extra: extra,
    );
  }

  Future showBlockedFeatureDialog(BuildContext context) {
    return showModalBottomSheet<void>(
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
        return const ErrorDialog(
          title: 'Mohon Maaf',
          subtitle:
              'Fitur ini hanya tersedia untuk Mitra Amartha, Hubungi Amartha Care untuk tahu caranya',
          imageAsset: AppAssets.errorIbuAmanahWhistle,
          primaryButtonText: 'WA Amartha',
          secondaryButtonText: 'Kembali',
        );
      },
    );
  }

  String getInitial(String name) {
    return name.isNotEmpty ? name[0].toUpperCase() : '';
  }
}
