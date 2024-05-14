import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mithub_app/design/colors.dart';
import 'package:mithub_app/design/theme_extension.dart';

class PinIndicator extends StatelessWidget {
  final int length;
  final int filled;
  final bool isError;
  final double space;
  final double iconSize;
  final bool isWalletPin;

  const PinIndicator({
    super.key,
    this.length = 6,
    this.filled = 0,
    this.isError = false,
    this.space = 8,
    this.iconSize = 12.0,
    this.isWalletPin = false
  });

  @override
  Widget build(BuildContext context) {
    final iconColor =
    isError ? context.colorScheme.error : context.colorScheme.primary;

    final filledIcon = Icon(
      Icons.circle,
      size: iconSize.r,
      color: iconColor,
    );
    final notFilledIcon = Icon(
      Icons.circle,
      size: iconSize.r,
      color: FunDsColors.colorPurple200,
    );
    final outlinedIcon = Icon(
      Icons.circle_outlined,
      size: iconSize.r,
      color: iconColor,
    );

    return SizedBox(
      height: iconSize.r,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: length,
        itemBuilder: (context, index) {
          if (index < filled) {
            return filledIcon;
          } else {
            if (isWalletPin) {
              return notFilledIcon;
            } else {
              return outlinedIcon;
            }
          }
        },
        separatorBuilder: (context, index) => Divider(
          indent: space,
          endIndent: space,
        ),
      ),
    );
  }
}
