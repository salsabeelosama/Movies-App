import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/constants/app_colors.dart';
import 'package:movies_app/core/constants/app_icons.dart';
import 'package:movies_app/core/constants/app_images.dart';
import 'package:movies_app/core/constants/app_texts.dart';
import 'package:movies_app/core/widgets/custom_button.dart';
import 'package:movies_app/core/widgets/red_custom_button.dart';
import 'package:movies_app/features/Auth/repository/auth_repository.dart';
import 'package:movies_app/features/Profile/controller/cubit/profile_cubit.dart';
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

  String getAvatarPath(String avatar) {
    switch (avatar) {
      case 'avatar1':
        return AppImages.avatar1;
      case 'avatar2':
        return AppImages.avatar2;
      case 'avatar3':
        return AppImages.avatar3;
      case 'avatar4':
        return AppImages.avatar4;
      case 'avatar5':
        return AppImages.avatar5;
      case 'avatar6':
        return AppImages.avatar6;
      case 'avatar7':
        return AppImages.avatar7;
      case 'avatar8':
        return AppImages.avatar8;
      case 'avatar9':
        return AppImages.avatar9;
      default:
        return AppImages.avatar1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(AuthRepository())..getProfile(),
      child: Scaffold(
        body: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is ProfileError) {
              return Center(
                child: Text(
                  state.message,
                  style: TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: 16.sp,
                  ),
                ),
              );
            }
            if (state is ProfileSuccess) {
              return Column(
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
                                            getAvatarPath(state.avatar),
                                          ),
                                          radius: 56.r,
                                        ),
                                        SizedBox(height: 8.h),
                                        Text(
                                          state.name,
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
                                      text: AppTexts.wishList.tr(),
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
                              text: AppTexts.wishList.tr(),
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
                            ? Center(
                                child: Image.asset(
                                  AppImages.empty,
                                  width: 125.w,
                                ),
                              )
                            : ListView.builder(
                                itemCount: watchlist.length,
                                itemBuilder: (context, index) {
                                  return Text(watchlist[index]);
                                },
                              ),

                        history.isEmpty
                            ? Center(
                                child: Image.asset(
                                  AppImages.empty,
                                  width: 125.w,
                                ),
                              )
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
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
