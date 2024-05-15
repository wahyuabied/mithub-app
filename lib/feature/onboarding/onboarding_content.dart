import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mithub_app/core/di/service_locator.dart';
import 'package:mithub_app/core/routing/a_route.dart';
import 'package:mithub_app/design/app_assets.dart';
import 'package:mithub_app/design/colors.dart';
import 'package:mithub_app/design/theme_extension.dart';

BuildContext? get context =>
    serviceLocator.get<ARouter>().rootSheelNavigatorKey.currentContext;


List<OnboardingContent> newContents = [
  OnboardingContent(
    title: 'Imbal Hasil Hingga 7%',
    description: 'Nikmati hasil per tahun dengan investasi mulai dari 10 ribu rupiah, keuntungan otomatis masuk pocket setiap bulan',
    background: AppAssets.bgNewOnboardingFirst,
    painter: CustomBackgroundOnboardingPainter(index: 0),
    animationPosition: {
      'image': 0.1.sh,
      'star': 0.12.sw,
      'opacity': 1,
    },
    animationContent: (position, opacity, starPosition) {
      return [
        AnimatedPositioned(
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeIn,
          width: 1.sw,
          top: position,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 1000),
            curve: Curves.easeIn,
            opacity: opacity,
            child: Center(
              child: Image.asset(
                AppAssets.imgOnboardingFirst,
                width: 304.r,
                height: 304.r,
              ),
            ),
          ),
        ),
        AnimatedPositioned(
          duration: const Duration(
            milliseconds: 350,
          ),
          curve: Curves.easeIn,
          left: starPosition - 0.02.sh,
          top: 0.1.sh,
          child: Image.asset(
            AppAssets.imgStarOnboarding,
          ),
        ),
        AnimatedPositioned(
          duration: const Duration(
            milliseconds: 350,
          ),
          curve: Curves.easeIn,
          right: starPosition,
          top: 0.45.sh,
          child: Image.asset(
            AppAssets.imgStarOnboarding,
            width: 39.r,
            height: 39.r,
          ),
        ),
      ];
    },
  ),
  OnboardingContent(
      title: 'Solusi Pintar Keuangan Anda',
      description: 'Gunakan pinjaman sesuai kebutuhan, ajukan pencairan selama limit tersedia.',
      background: AppAssets.bgNewOnboardingTwo,
      painter: CustomBackgroundOnboardingPainter(
        index: 1,
      ),
      animationPosition: {
        'image': 0.04.sw,
        'star': 0.1.sh,
        'opacity': 1,
      },
      animationContent: (position, opacity, starPosition) {
        return [
          AnimatedPositioned(
            duration: const Duration(
              milliseconds: 350,
            ),
            curve: Curves.easeIn,
            width: 1.sw,
            right: position,
            top: 0.1.sh,
            child: AnimatedOpacity(
              duration: const Duration(
                milliseconds: 1000,
              ),
              curve: Curves.easeIn,
              opacity: opacity,
              child: Image.asset(
                AppAssets.imgOnboardingTwo,
                width: 283.r,
                height: 283.r,
              ),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(
              milliseconds: 350,
            ),
            curve: Curves.easeIn,
            right: 0.2.sw,
            top: starPosition,
            child: Image.asset(
              AppAssets.imgStarOnboarding,
              width: 60.r,
              height: 60.r,
            ),
          ),
        ];
      }),
  OnboardingContent(
      title: 'Transaksi dalam Satu Aplikasi',
      description: 'Beli pulsa? Bayar listrik? Bayar BPJS? Bisa semua di AmarthaFin.',
      background: AppAssets.bgNewOnboardingThree,
      painter: CustomBackgroundOnboardingPainter(
        index: 2,
      ),
      animationPosition: {
        'image': -8,
        'star': 0.35.sh,
        'opacity': 1,
      },
      animationContent: (double position, double opacity, double starPosition) {
        return [
          AnimatedPositioned(
            duration: const Duration(
              milliseconds: 350,
            ),
            curve: Curves.easeIn,
            width: 1.sw,
            bottom: position == 0 ? -40 : position,
            child: AnimatedOpacity(
              duration: const Duration(
                milliseconds: 1000,
              ),
              curve: Curves.easeIn,
              opacity: opacity,
              child: Center(
                child: Image.asset(
                  AppAssets.imgOnboardingThree,
                  width: 334.r,
                  height: 456.r,
                ),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(
              milliseconds: 350,
            ),
            curve: Curves.easeIn,
            top: starPosition == 0 ? 0.2.sh : position + 0.05.sh,
            left: 0.08.sw,
            child: Image.asset(
              AppAssets.imgStarOnboarding,
              height: 78.r,
              width: 78.r,
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(
              milliseconds: 350,
            ),
            curve: Curves.easeIn,
            top: starPosition == 0 ? 0.4.sh : position + 0.2.sh,
            right: 0.07.sw,
            child: Image.asset(
              AppAssets.imgStarOnboarding,
              width: 45.r,
              height: 45.r,
            ),
          ),
        ];
      }),
];

class OnboardingContent extends StatefulWidget {
  final String title;
  final String description;
  final String background;
  final CustomBackgroundOnboardingPainter painter;
  final Map<String, double> animationPosition;
  final List<Widget> Function(
    double imagePosition,
    double opacity,
    double starPosition,
  ) animationContent;
  const OnboardingContent({
    super.key,
    required this.title,
    required this.description,
    required this.background,
    required this.painter,
    required this.animationPosition,
    required this.animationContent,
  });

  @override
  State<OnboardingContent> createState() => _OnboardingContentState();
}

class _OnboardingContentState extends State<OnboardingContent> {
  double? imagePosititon = 0;
  double? starPosititon = 0;
  double? opacity = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1000), () {
      if (mounted) {
        setState(() {
          imagePosititon = widget.animationPosition['image'];
          opacity = widget.animationPosition['opacity'];
          starPosititon = widget.animationPosition['star'];
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            widget.background,
          ),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SafeArea(
              child: Stack(
                children: widget.animationContent(
                    imagePosititon!, opacity!, starPosititon!),
              ),
            ),
          ),
          CustomPaint(
            painter: widget.painter,
            child: Container(
              padding: EdgeInsets.only(
                bottom: 80.h,
                top: 10.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0.r),
                    child: Text(
                      widget.title,
                      textAlign: TextAlign.center,
                      style: context.textTheme.bodyLarge?.copyWith(fontSize: 20.sp),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.r),
                    child: Text(
                      widget.description,
                      style: context.textTheme.bodyLarge,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomBackgroundOnboardingPainter extends CustomPainter {
  final int index;

  CustomBackgroundOnboardingPainter({
    this.index = 0,
  });
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = FunDsColors.white
      ..style = PaintingStyle.fill;

    Path? path;
    switch (index) {
      case 0:
        path = Path()
          ..moveTo(0, size.height)
          ..lineTo(size.width, size.height)
          ..lineTo(size.width, -size.height / 1.85)
          ..quadraticBezierTo(
            size.height / 4,
            -size.height * -0.1,
            -size.height / 2,
            -size.width / 4,
          )
          ..lineTo(0, size.height / 4);
        break;
      case 1:
        path = Path()
          ..moveTo(0, size.width)
          ..lineTo(size.width, size.height)
          ..lineTo(size.width, -size.height / 1.36)
          ..quadraticBezierTo(
            size.height,
            -size.height * 1.2,
            -size.height * 0.5,
            -size.width / 4,
          )
          ..lineTo(0, size.height / 4);
        break;
      default:
        path = Path()
          ..moveTo(0, size.height)
          ..lineTo(size.width, size.height)
          ..lineTo(size.width, -size.height / 1.8)
          ..quadraticBezierTo(
            size.height * 1.5,
            size.width * 0.04,
            0,
            -size.height * 0.735,
          );
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) =>
      oldDelegate != this;
}
