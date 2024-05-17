import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mithub_app/design/theme_extension.dart';

import '../colors.dart';

class CommonDialog extends StatelessWidget {
  final String? title;
  final List<TextSpan>? subtitle;
  final String? imageAsset;
  final String? imageAssetSvg;
  final String? primaryButtonText;
  final Function()? onClickPrimary;
  final String? secondaryButtonText;
  final bool centerTitle;

  const CommonDialog({
    super.key,
    this.title,
    this.subtitle,
    this.imageAsset,
    this.imageAssetSvg,
    this.primaryButtonText,
    this.onClickPrimary,
    this.secondaryButtonText,
    this.centerTitle = true,
  })  : assert(
          (title != null || subtitle != null),
          'Param title or subtitle must be not null',
        ),
        assert(
          (imageAsset == null && imageAssetSvg != null) ||
              (imageAsset != null && imageAssetSvg == null),
          'Cannot specify imageAsset and imageAssetSvg at the same time',
        );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 20.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          if (imageAsset != null)
            Image.asset(
              imageAsset!,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          if (imageAssetSvg != null)
            SvgPicture.asset(
              imageAssetSvg!,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          if (title?.isNotEmpty == true)
            Padding(
              padding: EdgeInsets.only(top: 8.h, bottom: 16.h),
              child: Align(
                alignment:
                    centerTitle ? Alignment.center : Alignment.centerLeft,
                child: Visibility(
                  visible: title?.isNotEmpty == true,
                  child: Text(
                    title ?? '',
                    style: context.textTheme.titleLarge
                        ?.copyWith(color: FunDsColors.primaryBase),
                  ),
                ),
              ),
            ),
          if (subtitle?.isNotEmpty == true)
            Padding(
              padding: EdgeInsets.only(bottom: 16.h),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: Colors.black,
                  ),
                  children: subtitle,
                ),
              ),
            ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Visibility(
                visible: secondaryButtonText?.isNotEmpty == true,
                child: Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            secondaryButtonText ?? '',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: primaryButtonText?.isNotEmpty == true,
                child: Expanded(
                  child: ElevatedButton(
                    child: Text(primaryButtonText ?? '',
                        textAlign: TextAlign.center),
                    onPressed: () => onClickPrimary == null
                        ? Navigator.pop(context)
                        : onClickPrimary!(),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

Future<T?> showCommonBottomSheet<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  bool isDismissible = true,
  bool enableDrag = true,
}) {
  return showModalBottomSheet<T>(
    context: context,
    backgroundColor: FunDsColors.white,
    isScrollControlled: true,
    isDismissible: isDismissible,
    enableDrag: enableDrag,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16.r),
        topRight: Radius.circular(16.r),
      ),
    ),
    builder: builder,
  );
}
