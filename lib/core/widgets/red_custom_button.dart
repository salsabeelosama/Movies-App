import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/constants/app_colors.dart';

class RedCustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final String? icon;
  final double width;
  final double fontSize;

  RedCustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width = 392,
    this.icon,
    this.fontSize = 20,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        fixedSize: Size(width, 56.h),
        backgroundColor: AppColors.redButtonColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: fontSize,
                height: 1.2,
              ),
            ),
            if (icon != null) ...[
              SizedBox(width: 10.w),
              Image.asset(icon!, width: 20.w, height: 20.h),
            ],
          ],
        ),
      ),
    );
  }
}
