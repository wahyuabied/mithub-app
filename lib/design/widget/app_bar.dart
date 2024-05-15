import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

AppBar textAppBar(String title, {bool centerTitle = false}) {
  return AppBar(
    title: Padding(
      padding: EdgeInsets.only(left: 4.w),
      child: Text(title),
    ),
    titleTextStyle: GoogleFonts.raleway(
      fontSize: 22.sp,
      color: Colors.black,
      fontWeight: FontWeight.w800,
    ),
    centerTitle: centerTitle,
    backgroundColor: Colors.white,
    foregroundColor: Colors.black,
  );
}