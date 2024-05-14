import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:mithub_app/design/theme_extension.dart';

class ErrorDialog extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageAsset;
  final String primaryButtonText;
  final Function()? onClickPrimary;
  final String secondaryButtonText;
  final bool centerTitle;
  final bool centerSubtitle;
  final bool showButtonSecondary;
  final Function()? onClickSecondary;
  final bool isFullImage;

  const ErrorDialog({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imageAsset,
    required this.primaryButtonText,
    this.onClickPrimary,
    required this.secondaryButtonText,
    this.centerTitle = true,
    this.centerSubtitle = false,
    this.showButtonSecondary = true,
    this.onClickSecondary,
    this.isFullImage = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 20.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            imageAsset,
            width: isFullImage ? double.infinity : 200.w,
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 16.h),
            child: Align(
              alignment: centerTitle ? Alignment.center : Alignment.centerLeft,
              child: Visibility(
                visible: title.isNotEmpty,
                child: Text(
                  title,
                  style: context.textTheme.titleLarge,
                ),
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(bottom: 32.h),
              child: HtmlWidget(
                subtitle,
                textStyle: context.textTheme.bodyMedium,
              )),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Visibility(
                visible: showButtonSecondary,
                child: Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            onClickSecondary == null
                                ? Navigator.pop(context)
                                : onClickSecondary!();
                          },
                          child: Text(secondaryButtonText,
                              textAlign: TextAlign.center),
                        ),
                      ),
                      SizedBox(width: 8.w),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: primaryButtonText.isNotEmpty,
                child: Expanded(
                  child: ElevatedButton(
                    child: Text(primaryButtonText, textAlign: TextAlign.center),
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
