import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/constants/app_colors.dart';
import 'package:movies_app/core/constants/app_texts.dart';
import 'package:movies_app/core/widgets/custom_text_form_field.dart';
import 'package:movies_app/core/widgets/custom_button.dart';
import 'package:movies_app/features/Auth/controller/forget_password_cubit.dart';
import 'package:movies_app/features/Auth/controller/forget_password_state.dart';
import 'package:movies_app/features/Auth/repository/auth_repository.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.locale;

    return BlocProvider(
      create: (_) => ForgetPasswordCubit(AuthRepository()),
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
              listener: (context, state) {
                if (state is ForgetPasswordFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                }
                if (state is ForgetPasswordSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Reset link sent. Check your email.')),
                  );
                }
              },
              builder: (context, state) {
                final isLoading = state is ForgetPasswordLoading;
                return Column(
                  children: [
                    SizedBox(height: 16.h),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Icon(Icons.arrow_back, color: AppColors.mainColor),
                          ),
                        ),
                        Text(
                          AppTexts.forgetPassword.tr(),
                          style: TextStyle(
                            color: AppColors.mainColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24.h),
                    Image.asset("assets/Images/Forgot_Password.png"),
                    SizedBox(height: 24.h),
                    CustomTextFormField(
                      controller: emailController,
                      hintText: AppTexts.email.tr(),
                      prefixIcon: Icons.email_rounded,
                    ),
                    SizedBox(height: 10.h),
                    CustomButton(
                      text: AppTexts.verifyEmail.tr(),
                      fontSize: 20.sp,
                      isLoading: isLoading,
                      onPressed: () {
                        context.read<ForgetPasswordCubit>().sendResetLink(
                          email: emailController.text,
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}