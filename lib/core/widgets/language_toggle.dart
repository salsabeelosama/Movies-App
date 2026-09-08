import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/constants/app_colors.dart';

class LanguageToggle extends StatefulWidget {
  const LanguageToggle({super.key});

  @override
  State<LanguageToggle> createState() => _LanguageToggleState();
}

class _LanguageToggleState extends State<LanguageToggle> {
  static const Locale _enLocale = Locale('en', 'US');
  static const Locale _arLocale = Locale('ar');

  Future<void> _changeLanguage(Locale targetLocale) async {
    if (context.locale == targetLocale) return;

    await context.setLocale(targetLocale);
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isArabic = context.locale.languageCode == 'ar';

    return Directionality(
      textDirection: TextDirection.ltr,
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
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 250),
                opacity: isArabic ? 0.3 : 1.0,
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
            ),
            Positioned(
              right: 8.w,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 250),
                opacity: isArabic ? 1.0 : 0.3,
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
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              left: isArabic ? 52.w : 2.w,
              top: 3.w,
              child: IgnorePointer(
                child: Container(
                  width: 36.w,
                  height: 36.w,
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
            ),
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              width: 45.w,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => _changeLanguage(_enLocale),
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            ),
            Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              width: 45.w,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => _changeLanguage(_arLocale),
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}