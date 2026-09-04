import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({super.key, required this.text, required this.image});

  final String text;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Tab(
      icon: Image.asset(image, width: 36.w),
      text: text,
      iconMargin: EdgeInsets.only(bottom: 8.h),
    );
  }
}
