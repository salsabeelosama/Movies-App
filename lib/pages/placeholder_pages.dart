import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/app_theme.dart';

/// Minimal placeholder for the "Saved" tab (bookmarked movies).
/// Replace the body with a list/grid backed by your bookmarks store.
class SavedPage extends StatelessWidget {
  const SavedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 8.h),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Saved',
                  style: TextStyle(color: AppColors.textSecondary, fontSize: 16.sp, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  'Your bookmarked movies will show up here',
                  style: TextStyle(color: AppColors.textSecondary, fontSize: 13.sp),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Minimal placeholder for the "Profile" tab.
/// Replace the body with real account/settings content.
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 8.h),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Profile',
                  style: TextStyle(color: AppColors.textSecondary, fontSize: 16.sp, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  'Account settings go here',
                  style: TextStyle(color: AppColors.textSecondary, fontSize: 13.sp),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
