import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mithub_app/design/theme_extension.dart';
import 'package:mithub_app/design/widget/common_dialog.dart';
import 'package:mithub_app/feature/home/mitra/homepage_const.dart';
import 'package:badges/badges.dart' as badges;

class MenuPpobSection extends StatefulWidget {
  final String source;
  final bool isAgent;

  const MenuPpobSection({
    super.key,
    required this.source,
    required this.isAgent,
  });

  @override
  State<MenuPpobSection> createState() => _MenuPpobSectionState();
}

class _MenuPpobSectionState extends State<MenuPpobSection> {

  // final List<HomePpobMenu> ppobMenus =
  // List.from(HomePpobMenu.homeDisplayMenus);
  final List<HomePpobMenu> collapsedPpobMenus = [];
  final List<HomePpobMenu> expandedPpobMenus = [];
  late bool enableCommerce;
  late bool enableEwallet;
  late bool enablePulsa;
  late bool enableTopUpGame;

  @override
  void initState() {
    super.initState();

    enableCommerce = true;
    enableEwallet = true;
    enablePulsa = true;
    enableTopUpGame = true;

    var activeMenu = List.of(HomePpobMenu.homeDisplayMenus);
    activeMenu.removeWhere((menu) {
      switch (menu) {
        case HomePpobMenu.belanja:
          return !widget.isAgent && !enableCommerce;
        case HomePpobMenu.eWallet:
          return !enableEwallet;
        case HomePpobMenu.pulsa:
          return !enablePulsa;
        case HomePpobMenu.topUpGame:
          return !enableTopUpGame;
        default:
          return false;
      }
    });

    expandedPpobMenus.addAll(activeMenu);
    if (activeMenu.length >= 8) {
      collapsedPpobMenus.addAll(activeMenu.getRange(0, 7).toList());
      collapsedPpobMenus.add(HomePpobMenu.other);
    }

    handleDeeplinkPpobOthers();
  }

  void handleDeeplinkPpobOthers() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final deeplinkAction =
          GoRouterState.of(context).uri.queryParameters['ppobOthers'];
      if (deeplinkAction == 'true') {
        _showCompleteMenu(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return buildPpobMenu(context);
  }

  Widget buildPpobMenu(BuildContext context, {bool expanded = false}) {
    final menus = expanded ? expandedPpobMenus : collapsedPpobMenus;


    return Column(
      mainAxisSize: expanded ? MainAxisSize.min : MainAxisSize.max,
      children: [
        Padding(
          padding: expanded
              ? EdgeInsets.only(left: 10.r, top: 16.r)
              : EdgeInsets.zero,
          child: Row(
            children: [
              Visibility(
                visible: expanded,
                child: IconButton(
                  icon: Icon(Icons.close, size: 20.r),
                  onPressed: () => Navigator.pop(context),
                  color: Colors.black,
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Isi Ulang & Bayar',
                  style: context.textTheme.titleSmall,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        Padding(
          padding: expanded
              ? EdgeInsets.only(left: 20.r, right: 20.r, bottom: 20.r)
              : EdgeInsets.zero,
          child: GridView.builder(
            shrinkWrap: true,
            itemCount: menus.length,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
            ),
            itemBuilder: (context, index) {
              final itemMenu = menus[index];
              return PpobMenu(
                menu: itemMenu,
                onTap: (context) {
                  HomePpobMenu menu = itemMenu;

                  switch (itemMenu) {
                    case HomePpobMenu.listrik:
                    case HomePpobMenu.pulsa:
                    case HomePpobMenu.paketData:
                    case HomePpobMenu.cicilan:
                    case HomePpobMenu.eWallet:
                    case HomePpobMenu.bpjs:
                    case HomePpobMenu.pdam:
                    case HomePpobMenu.topUpGame:
                    case HomePpobMenu.belanja:
                      return;
                    case HomePpobMenu.other:
                      return _showCompleteMenu(context);
                  }
                },
              );
            },
          ),
        ),
      ],
    );
  }

  void _showCompleteMenu(BuildContext context) {
    showCommonBottomSheet(
      context: context,
      builder: (context) {
        return buildPpobMenu(context, expanded: true);
      },
    );
  }
}

class PpobMenu extends StatelessWidget {
  final HomePpobMenu menu;
  final void Function(BuildContext context) onTap;

  const PpobMenu({super.key, required this.menu, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(context),
      splashColor: Colors.white,
      highlightColor: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          badges.Badge(
            showBadge: menu == HomePpobMenu.belanja ? true : false,
            badgeContent: const Text(
              'Baru',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 8,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
            badgeStyle: const badges.BadgeStyle(
              shape: badges.BadgeShape.square,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              padding: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
            ),
            position: badges.BadgePosition.topEnd(top: -6, end: -7),
            child: Container(
              width: 48.r,
              height: 48.r,
              padding: menu == HomePpobMenu.other
                  ? const EdgeInsets.symmetric(horizontal: 12, vertical: 12)
                  : const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
              decoration: const BoxDecoration(
                border: Border.fromBorderSide(
                  BorderSide(color: Color(0xFFE0E1E6)),
                ),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              child: Image.asset(menu.icon),
            ),
          ),
          const SizedBox(height: 4),
          Flexible(
            child: Text(
              menu.name,
              textAlign: TextAlign.center,
              style: context.textTheme.bodyMedium?.copyWith(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
