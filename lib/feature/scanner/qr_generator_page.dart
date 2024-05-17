import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mithub_app/design/colors.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrGeneratorPage extends StatelessWidget {
  const QrGeneratorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 32.h),
              Center(
                child: QrImageView(
                  data: 'QR-GENERATOR',
                  size: 280,
                ),
              ),
              SizedBox(height: 32.h),
              Container(
                width: double.infinity,
                height: 8.h,
                color: FunDsColors.black07,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
