import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mithub_app/core/di/service_locator.dart';
import 'package:mithub_app/core/network/core_http_repository.dart';
import 'package:mithub_app/design/colors.dart';
import 'package:mithub_app/design/step_progress_indicator.dart';
import 'package:mithub_app/design/theme_extension.dart';
import 'package:mithub_app/design/widget/a_button.dart';
import 'package:mithub_app/feature/onboarding/onboarding_content.dart';
import 'package:mithub_app/routes/auth_routes.dart';

class OnboardingScreen extends StatefulWidget {
  final bool? activationPurpose;
  final String? code;

  const OnboardingScreen({
    super.key,
    this.activationPurpose = false,
    this.code,
  });

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _currentPage = 0;
  late PageController _pageController;
  String appVersion = '';

  @override
  void initState() {
    super.initState();
    getAppVersion();
    _pageController = PageController();
  }

  void getAppVersion() async {
    appVersion = 'v1.0.0';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          PageView.builder(
            physics: const BouncingScrollPhysics(),
            controller: _pageController,
            itemCount: newContents.length,
            onPageChanged: (value) => setState(
              () {
                _currentPage = value;
              },
            ),
            itemBuilder: (context, i) {
              return newContents[i];
            },
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.r,
                ).copyWith(
                  top: 10.r,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: 12.r,
                      ),
                      child: Text(
                        appVersion,
                        style: context.textTheme.bodySmall?.copyWith(
                          color: FunDsColors.textDefaultBlack,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Visibility(
                      visible: (_currentPage + 1) != newContents.length,
                      child: TextButton(
                        onPressed: () {
                          _currentPage = 2;
                          _pageController.animateToPage(
                            2,
                            duration: const Duration(milliseconds: 800),
                            curve: Curves.easeOutBack,
                          );
                          setState(() {});
                        },
                        child: Text(
                          'Lewati',
                          style: context.textTheme.bodyMedium,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned.fill(
            bottom: 0.h,
            child: Padding(
              padding: EdgeInsets.all(
                20.r,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  StepProgressIndicator(
                    totalSteps: newContents.length,
                    currentStep: _currentPage + 1,
                    selectedColor: FunDsColors.info,
                    unselectedColor: FunDsColors.infoLight,
                    roundedEdges: Radius.circular(10.r),
                    size: 6.h,
                    mainAxisAlignment: MainAxisAlignment.start,
                    unSelectedStepWidth: 10.r,
                    selectedStepWidth: 20.r,
                    customStep: (step, stepColor, stepSize) {
                      return Container(
                        decoration: BoxDecoration(
                          color: step != _currentPage
                              ? FunDsColors.infoLight
                              : stepColor,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      );
                    },
                  ),
                  const Spacer(),
                  (_currentPage + 1) == newContents.length
                      ? AButton(
                          variant: ButtonVariant.primary,
                          child: const Text(
                            'Lanjut Masuk',
                          ),
                          onPressed: () {
                            _login(context);
                          },
                        )
                      : AButton(
                          variant: ButtonVariant.primary,
                          child: const Text(
                            'Lanjut Aktivasi',
                          ),
                          onPressed: () {
                            _pageController.animateToPage(
                              _currentPage+1,
                              duration: const Duration(milliseconds: 800),
                              curve: Curves.easeOutBack,
                            );
                          },
                        )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void _login(BuildContext context) {
    context.pushNamed(AuthRoutes.login.name!);
  }
}
