import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/constants/app_colors.dart';

class LanguageToggle extends StatefulWidget {
  const LanguageToggle({super.key});

  @override
  State<LanguageToggle> createState() => _LanguageToggleState();
}

class _LanguageToggleState extends State<LanguageToggle> {
  @override
  Widget build(BuildContext context) {
    bool isArabic = context.locale.languageCode == 'ar';

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () async {
        final newLocale =
        isArabic ? const Locale('en') : const Locale('ar');

        await context.setLocale(newLocale);

        if (mounted) {
          setState(() {});
        }
      },
      child: SizedBox(
        width: 90.w,
        height: 42.w,
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 90.w,
              height: 40.w,
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.mainColor,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(30.r),
              ),
            ),
            Positioned(
              left: 8.w,
              child: ClipOval(
                child: SizedBox(
                  width: 24.w,
                  height: 24.w,
                  child: Image.asset(
                    "assets/Images/usa_flag.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned(
              right: 8.w,
              child: ClipOval(
                child: SizedBox(
                  width: 30.w,
                  height: 30.w,
                  child: Image.asset(
                    "assets/Images/egypt_flag.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              left: isArabic ? 52.w : 2.w,
              top: 3.w,
              child: Container(
                width: 36.w,
                height: 36.w,
                padding: EdgeInsets.all(0.w),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.backgroundColor,
                  border: Border.all(
                    color: AppColors.mainColor,
                    width: 5.w,
                  ),
                ),
                child: ClipOval(
                  child: Image.asset(
                    isArabic
                        ? "assets/Images/egypt_flag.png"
                        : "assets/Images/usa_flag.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}