import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/constants/app_colors.dart';
import 'package:movies_app/core/constants/app_images.dart';
import 'package:movies_app/core/constants/app_texts.dart';

class CustomWidgets extends StatelessWidget {
  CustomWidgets({super.key, required this.num, required this.text});
  String num;
  String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          num,
          style: TextStyle(
            color: AppColors.whiteColor,
            fontSize: 36.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 20.h),
        Text(
          text,
          style: TextStyle(
            color: AppColors.whiteColor,
            fontSize: 24.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
