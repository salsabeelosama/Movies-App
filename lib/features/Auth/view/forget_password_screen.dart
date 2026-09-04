import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/constants/app_colors.dart';
import 'package:movies_app/core/constants/app_texts.dart';
import 'package:movies_app/core/widgets/custom_text_form_field.dart';
import 'package:movies_app/core/widgets/custom_button.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({super.key});

  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              SizedBox(height: 16.h),
              Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
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
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}