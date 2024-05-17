import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mithub_app/feature/home/mitra/section/shimmer_column.dart';

class BalanceContainerCard extends StatelessWidget {
  final Widget child;
  final Border? border;
  final BorderRadius? borderRadius;

  const BalanceContainerCard({
    super.key,
    required this.child,
    this.border,
    this.borderRadius,
  });

  const BalanceContainerCard.shimmer({
    super.key,
    this.border,
    this.borderRadius,
  }) : child = const _BalanceLoadingShimmer();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: borderRadius ?? BorderRadius.circular(4.r),
        color: Colors.white,
        border: border ?? Border.all(color: Colors.white, width: 2.w),
        image: const DecorationImage(
          image: AssetImage('assets/images/visual_ornament_small.png'),
          fit: BoxFit.fitHeight,
          alignment: Alignment.centerRight,
        ),
      ),
      child: child,
    );
  }
}

class _BalanceLoadingShimmer extends StatelessWidget {
  const _BalanceLoadingShimmer();

  @override
  Widget build(BuildContext context) {
    return ShimmerColumn(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
      collumns: [
        ColumnConfig(height: 14.h, widthRatio: 0.4),
        ColumnConfig(height: 16.h, widthRatio: 0.5),
        ColumnConfig(height: 14.h, widthRatio: 0.3),
      ],
    );
  }
}
