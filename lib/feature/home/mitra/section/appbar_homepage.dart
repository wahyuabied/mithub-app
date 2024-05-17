import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mithub_app/design/colors.dart';
import 'package:mithub_app/design/theme_extension.dart';
import 'package:mithub_app/feature/home/mitra/view_model/mitra_home_view_model.dart';
import 'package:mithub_app/utils/result.dart';
import 'package:mithub_app/utils/result_builder.dart';
import 'package:provider/provider.dart';

class AppBarHomepage extends StatelessWidget implements PreferredSizeWidget {
  final AppBar appbar;
  const AppBarHomepage({
    Key? key,
    required this.appbar,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(appbar.preferredSize.height);

  @override
  Widget build(BuildContext context) {
    final userProfile = context.select((MitraHomeViewModel p) => p.userProfile);
    final notifCount = context.select((MitraHomeViewModel p) => p.notifCount);
    final bool isAgent = userProfile.isAgent;
    final String userAvatar = userProfile.profileImage?.path ?? '';
    final String userName = userProfile.name;
    final typeMitra = isAgent
        ? 'Agen':'Mitra';

    return AppBar(
      backgroundColor: const Color(0xFFF4F6FB),
      elevation: 0,
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 32.r,
            height: 32.r,
            child: Image.network(
              userAvatar,
              errorBuilder: (context, error, stackTrace) {
                return CircleAvatar(
                    radius: 32.r,
                    backgroundColor: FunDsColors.neutralFive,
                    child: Text(
                      userName.isNotEmpty ? userName[0].toUpperCase() : '',
                      style: context.textTheme.bodyLarge?.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: FunDsColors.neutralTwo,
                      ),
                    ));
              },
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Halo $typeMitra,',
                  style: GoogleFonts.inter(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                    color: FunDsColors.neutralFour,
                  ),
                ),
                Text(
                  userName,
                  maxLines: 2,
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w800,
                    color: FunDsColors.neutralTwo,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      actions: [
        Center(
          child: SizedBox(
            width: 32.r,
            height: 32.r,
            child: ResultBuilder(
              result: notifCount.result,
              defaultBuilder: (BuildContext context, Result<int> result) {
                final notifCount = result.dataOrNull ?? 0;
                return badges.Badge(
                  showBadge: notifCount > 0,
                  badgeContent: Text(
                    notifCount > 5 ? '5+' : notifCount.toString(),
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 8.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  badgeStyle: badges.BadgeStyle(
                    shape: badges.BadgeShape.square,
                    borderRadius: BorderRadius.circular(4.r),
                    padding:
                        EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
                  ),
                  position: badges.BadgePosition.topEnd(top: 2.h, end: 4.w),
                  child: IconButton(
                    onPressed: () {

                    },
                    icon: Image.asset(
                      'assets/images/icon_notification.png',
                      width: 18.w,
                      height: 18.h,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
