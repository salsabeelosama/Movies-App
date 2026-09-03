import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/constants/app_colors.dart';
import 'package:movies_app/core/constants/app_icons.dart';
import 'package:movies_app/core/constants/app_images.dart';
import 'package:movies_app/core/constants/app_texts.dart';
import 'package:movies_app/core/widgets/custom_button.dart';
import 'package:movies_app/core/widgets/red_custom_button.dart';
import 'package:movies_app/features/Profile/widgets/customWidgets.dart';
import 'package:movies_app/features/Profile/widgets/custom_tabBar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late final TabController tabController;
  final List<String> watchlist = [];
  final List<String> history = [];
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 400.h,
                color: AppColors.subColor,
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Column(
                              children: [
                                CircleAvatar(
                                  backgroundImage: AssetImage(
                                    AppImages.proImage,
                                  ),
                                  radius: 56.r,
                                ),
                                SizedBox(height: 8.h),
                                Text(
                                  'John Safwat',
                                  style: TextStyle(
                                    color: AppColors.whiteColor,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20.sp,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 46.w),
                            CustomWidgets(
                              num: '12',
                              text: AppTexts.wichList.tr(),
                            ),
                            SizedBox(width: 38.w),
                            CustomWidgets(
                              num: '10',
                              text: AppTexts.history.tr(),
                            ),
                          ],
                        ),
                        SizedBox(height: 23.h),
                        Row(
                          children: [
                            Expanded(
                              child: CustomButton(
                                text: AppTexts.editProfile.tr(),
                                onPressed: () {},
                              ),
                            ),
                            SizedBox(width: 10.w),
                            RedCustomButton(
                              text: AppTexts.exit.tr(),
                              icon: AppIcons.exit,
                              width: 135.w,
                              fontSize: 20.sp,
                              onPressed: () {},
                            ),
                          ],
                        ),
                        SizedBox(height: 12.h),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: TabBar(
                  tabs: [
                    CustomTabBar(
                      text: AppTexts.wichList.tr(),
                      image: AppIcons.whatchlist,
                    ),
                    CustomTabBar(
                      text: AppTexts.history.tr(),
                      image: AppIcons.history,
                    ),
                  ],
                  labelColor: AppColors.whiteColor,
                  labelStyle: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  controller: tabController,
                  dividerColor: Colors.transparent,
                  indicatorColor: AppColors.mainColor,
                  unselectedLabelColor: AppColors.whiteColor,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorWeight: 3.w,
                ),
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                watchlist.isEmpty
                    ? Center(child: Image.asset(AppImages.empty, width: 125.w))
                    : ListView.builder(
                        itemCount: watchlist.length,
                        itemBuilder: (context, index) {
                          return Text(watchlist[index]);
                        },
                      ),

                history.isEmpty
                    ? Center(child: Image.asset(AppImages.empty, width: 125.w))
                    : ListView.builder(
                        itemCount: history.length,
                        itemBuilder: (context, index) {
                          return Text(history[index]);
                        },
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
