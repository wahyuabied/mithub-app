import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';
import 'package:mithub_app/feature/home/mitra/section/shimmer.dart';

/// Create multiple shimmer as column
class ShimmerColumn extends StatelessWidget {
  const ShimmerColumn({
    super.key,
    required this.padding,
    required this.collumns,
    this.shrink = false,
  });

  final bool shrink;
  final EdgeInsets padding;
  final List<ColumnConfig> collumns;

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      isLoading: true,
      child: Padding(
        padding: padding,
        child: LayoutBuilder(builder: (context, constraints) {
          final columns = collumns.expandIndexed(
            (index, element) => [
              Container(
                width: constraints.maxWidth * element.widthRatio,
                height: element.height,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(5.r),
                ),
              ),
              if (index < collumns.length - 1) SizedBox(height: 4.h),
            ],
          );

          return SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisSize: shrink ? MainAxisSize.min : MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: columns.toList(),
            ),
          );
        }),
      ),
    );
  }
}

class ColumnConfig {
  ColumnConfig({required this.height, required this.widthRatio});

  double height;
  double widthRatio;
}
