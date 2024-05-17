import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mithub_app/feature/home/homepage_view_model.dart';
import 'package:mithub_app/feature/home/mitra/section/appbar_homepage.dart';
import 'package:mithub_app/feature/home/mitra/section/menu_ppob_section.dart';
import 'package:mithub_app/feature/home/mitra/section/poket_card.dart';
import 'package:mithub_app/feature/home/mitra/view_model/mitra_home_view_model.dart';
import 'package:mithub_app/utils/page_resume.dart';
import 'package:mithub_app/utils/result.dart';
import 'package:provider/provider.dart';

class MitraHomePage extends StatefulWidget {
  const MitraHomePage({super.key});

  @override
  State<MitraHomePage> createState() => _MitraHomePageKeepAlive();
}

class _MitraHomePageKeepAlive extends State<MitraHomePage>
    with AutomaticKeepAliveClientMixin {
  late final MitraHomeViewModel mitraHomeViewModel;

  @override
  void initState() {
    super.initState();
    final userProfile = context.read<HomepageViewModel>().userProfileResult;

    mitraHomeViewModel = MitraHomeViewModel(userProfile: userProfile.dataOrNull!)
      ..fetchData(false);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MitraHomeViewModel>.value(
          value: mitraHomeViewModel,
        ),
      ],
      builder: (context, child) {
        return const _MitraHomeContent();
      },
    );
  }

  @override
  void dispose() {
    mitraHomeViewModel.dispose();
    super.dispose();
  }

  /// always keep-alive
  @override
  bool get wantKeepAlive => true;
}

class _MitraHomeContent extends StatelessWidget {
  const _MitraHomeContent();

  @override
  Widget build(BuildContext context) {
    return PageResume(
      onResume: () {
        context.read<MitraHomeViewModel>().fetchData(true);
      },
      child: Scaffold(
        appBar: AppBarHomepage(
          appbar: AppBar(),
        ),
        backgroundColor: const Color(0xFFF4F6FB),
        body: RefreshIndicator.adaptive(
          onRefresh: () async {
            context.read<MitraHomeViewModel>().fetchData(true);
          },
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              const PocketCard(),
              SizedBox(height: 8.h),
              _SectionContainer(
                child: Column(
                  children: [
                    Visibility(
                      visible: true,
                      child: SizedBox(height: 16.h),
                    ),
                    SizedBox(height: 20.h),
                    Visibility(
                      visible: true,
                      child: Column(
                        children: [
                          MenuPpobSection(
                              source: 'homepage',
                              isAgent: context
                                  .watch<MitraHomeViewModel>()
                                  .userProfile.isAgent),
                          SizedBox(height: 20.h),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionContainer extends StatelessWidget {
  final Widget child;

  const _SectionContainer({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 20.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.r),
          topRight: Radius.circular(16.r),
        ),
      ),
      child: child,
    );
  }
}
