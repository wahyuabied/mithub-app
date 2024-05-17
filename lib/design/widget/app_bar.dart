import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

AppBar textAppBar(
  String title, {
  bool centerTitle = false,
  List<Widget>? action,
}) {
  return AppBar(
    title: Text(title),
    titleTextStyle: GoogleFonts.raleway(
      fontSize: 18.sp,
      color: Colors.black,
      fontWeight: FontWeight.w800,
    ),
    centerTitle: centerTitle,
    backgroundColor: Colors.white,
    foregroundColor: Colors.black,
    actions: action,
  );
}
