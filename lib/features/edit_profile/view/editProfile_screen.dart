import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/constants/app_colors.dart';
import 'package:movies_app/core/constants/app_images.dart';
import 'package:movies_app/core/constants/app_texts.dart';
import 'package:movies_app/core/widgets/custom_button.dart';
import 'package:movies_app/core/widgets/custom_text_form_field.dart';
import 'package:movies_app/core/widgets/red_custom_button.dart';
import 'package:movies_app/features/Auth/repository/auth_repository.dart';
import 'package:movies_app/features/edit_profile/controller/cubit/edit_profile_cubit.dart';
import 'package:movies_app/features/edit_profile/controller/cubit/edit_profile_state.dart';
import 'package:movies_app/features/edit_profile/widgets/buttom_sheet.dart';

class EditProfileScreen extends StatefulWidget {
  EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController nameController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  String selectedAvatar = 'avatar1';

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
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

  void _showDeleteAccountDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Delete account'),
          content: const Text('Are you sure you want to delete your account?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => EditProfileCubit(AuthRepository())..getProfile(),

      child: BlocListener<EditProfileCubit, EditProfileState>(
        listener: (context, state) {
          if (state is EditProfileLoaded) {
            setState(() {
              selectedAvatar = state.avatar;
            });
          }

          if (state is EditProfileUpdated) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Profile updated successfully')),
            );

            Navigator.pop(context);
          }

          if (state is EditProfileError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },

        child: BlocBuilder<EditProfileCubit, EditProfileState>(
          builder: (context, state) {
            if (state is EditProfileLoading) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }

            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                backgroundColor: Colors.transparent,
                title: Text(
                  AppTexts.pickAvatar.tr(),
                  style: TextStyle(
                    color: AppColors.mainColor,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: AppColors.mainColor,
                  ),
                ),
              ),

              body: SafeArea(
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return ButtomSheet(
                              onAvatarSelected: (avatar) {
                                setState(() {
                                  selectedAvatar = avatar;
                                });
                              },
                            );
                          },
                        );
                      },
                      child: CircleAvatar(
                        radius: 60.r,
                        backgroundImage: AssetImage(
                          getAvatarPath(selectedAvatar),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    CustomTextFormField(
                      controller: nameController,
                      hintText: state is EditProfileLoaded ? state.name : "",
                      prefixIcon: Icons.co_present,
                    ),
                    CustomTextFormField(
                      controller: phoneController,
                      hintText: state is EditProfileLoaded ? state.phone : "",
                      prefixIcon: Icons.phone,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          AppTexts.resetPassword.tr(),
                          style: TextStyle(
                            color: AppColors.whiteColor,
                            fontSize: 20.sp,
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                    RedCustomButton(
                      text: AppTexts.deleteAccount.tr(),
                      onPressed: () {
                        _showDeleteAccountDialog(context);
                      },
                    ),
                    CustomButton(
                      text: AppTexts.updateData.tr(),
                      onPressed: () {
                        context.read<EditProfileCubit>().updateProfile(
                          name: nameController.text.trim(),
                          phone: phoneController.text.trim(),
                          avatar: selectedAvatar,
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
