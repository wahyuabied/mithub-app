import 'package:flutter/material.dart';
import 'package:mithub_app/design/colors.dart';
import 'package:mithub_app/design/theme_extension.dart';

class IconText extends StatelessWidget {
  final String itemImage;
  final String itemName;
  final VoidCallback onPressed;

  const IconText({
    super.key,
    required this.itemImage,
    required this.itemName,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      type: MaterialType.button,
      child: InkWell(
        splashColor: FunDsColors.primaryLight,
        highlightColor: FunDsColors.primaryInvert.withOpacity(0.5),
        borderRadius: BorderRadius.circular(4),
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ImageIcon(AssetImage(itemImage)),
              Text(
                itemName,
                style: context.textTheme.labelSmall?.copyWith(
                  color: FunDsColors.neutralTwo,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
