import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mithub_app/design/app_assets.dart';
import 'package:mithub_app/design/colors.dart';
import 'package:mithub_app/design/theme_extension.dart';

class PremiumBadge extends StatelessWidget {
  const PremiumBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24.h,
      decoration: BoxDecoration(
        color: FunDsColors.cautionInvert,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
      child: Row(
        children: [
          Image.asset(
            AppAssets.icPoketPremiumStar,
            width: 20.r,
            height: 20.r,
          ),
          SizedBox(width: 4.w),
          Text(
            'Premium',
            style: context.textTheme.labelMedium?.copyWith(
              color: FunDsColors.semanticWarningText,
            ),
          ),
        ],
      ),
    );
  }
}
