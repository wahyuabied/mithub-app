import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mithub_app/design/colors.dart';
import 'package:mithub_app/design/theme_extension.dart';
import 'package:mithub_app/feature/home/homepage_view_model.dart';
import 'package:mithub_app/feature/home/mitra/section/appbar_homepage.dart';
import 'package:mithub_app/feature/home/mitra/section/menu_ppob_section.dart';
import 'package:mithub_app/feature/home/mitra/section/poket_card.dart';
import 'package:mithub_app/feature/home/mitra/view_model/mitra_home_view_model.dart';
import 'package:mithub_app/feature/home/mitra/view_model/poket_card_view_model.dart';
import 'package:mithub_app/feature/marketplace/marketplace_viewmodel.dart';
import 'package:mithub_app/routes/auth_routes.dart';
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
  late final PocketCardViewModel pocketCardViewModel;
  late final MarketplaceViewModel marketplaceViewModel;

  @override
  void initState() {
    super.initState();
    final userProfile = context.read<HomepageViewModel>().userProfileResult;
    mitraHomeViewModel =
        MitraHomeViewModel(userProfile: userProfile.dataOrNull!)
          ..fetchData(false);
    pocketCardViewModel = PocketCardViewModel(
      context.read<HomepageViewModel>().userProfileResult.data,
    )..fetchPocket();
    marketplaceViewModel = MarketplaceViewModel()..onViewLoaded();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MitraHomeViewModel>.value(
          value: mitraHomeViewModel,
        ),
        ChangeNotifierProvider<PocketCardViewModel>.value(
          value: pocketCardViewModel,
        ),
        ChangeNotifierProvider<MarketplaceViewModel>.value(
          value: marketplaceViewModel,
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
    pocketCardViewModel.dispose();
    marketplaceViewModel.dispose();
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
    var vm = context.watch<MarketplaceViewModel>();
    return PageResume(
      onResume: () {
        context.read<MitraHomeViewModel>().fetchData(true);
        context.read<PocketCardViewModel>().fetchPocket();
        context.read<MarketplaceViewModel>().fetchData();
      },
      child: Scaffold(
        appBar: AppBarHomepage(
          appbar: AppBar(),
        ),
        backgroundColor: const Color(0xFFF4F6FB),
        body: RefreshIndicator.adaptive(
          onRefresh: () async {
            context.read<MitraHomeViewModel>().fetchData(true);
            context.read<PocketCardViewModel>().fetchPocket();
            context.read<MarketplaceViewModel>().fetchData();
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
                                  .userProfile
                                  .isAgent),
                          SizedBox(height: 20.h),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8.h),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'MarketPlace',
                      style: context.textTheme.titleMedium,
                    ),
                    InkWell(
                      onTap: () {
                        context.pushNamed(AuthRoutes.marketPlace.name!);
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        color: FunDsColors.primaryBase,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Lihat Semua',
                            style: context.textTheme.titleSmall
                                ?.copyWith(color: FunDsColors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SizedBox(
                  height: 180.h,
                  width: 120.w,
                  child: ListView.builder(
                      physics: const ClampingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: 4,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: (){
                            context.pushNamed(AuthRoutes.marketplaceDetailPage.name!);
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.network(
                                  fit: BoxFit.fill,
                                  'http://20.20.24.134:3000' +
                                      (vm.listData.result.dataOrNull?[index].file
                                              ?.path
                                              .toString() ??
                                          ''),
                                  width: 120.w,
                                  height: 140,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 4.0, top: 8.0),
                                  child: SizedBox(
                                    width: 120,
                                    child: Text(
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      vm.listData.result.dataOrNull?[index].name ??
                                          '',
                                      style: context.textTheme.titleMedium,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 4.0, top: 8.0),
                                  child: Text(
                                    vm.listData.result.dataOrNull?[index].price
                                            .toString() ??
                                        '',
                                    style: context.textTheme.titleSmall?.copyWith(
                                      color: FunDsColors.primaryBase,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
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
