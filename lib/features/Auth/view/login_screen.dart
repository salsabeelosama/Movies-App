import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/constants/app_colors.dart';
import 'package:movies_app/core/constants/app_texts.dart';
import 'package:movies_app/core/widgets/custom_text_form_field.dart';
import 'package:movies_app/core/widgets/custom_button.dart';
import 'package:movies_app/core/widgets/language_toggle.dart';
import 'forget_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 67.h),
                Center(child: Image.asset("assets/Images/Login_Icon.png")),
                SizedBox(height: 69.h),
                CustomTextFormField(
                  controller: emailController,
                  hintText: AppTexts.email.tr(),
                  prefixIcon: Icons.email_rounded,
                ),
                CustomTextFormField(
                  controller: passwordController,
                  hintText: AppTexts.password.tr(),
                  prefixIcon: Icons.lock,
                  isPassword: true,
                ),
                SizedBox(height: 9.h),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: 24.w),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ForgetPasswordScreen(),
                          ),
                        );
                      },
                      child: Text(
                        AppTexts.forgetPassword.tr(),
                        style: TextStyle(
                          color: AppColors.mainColor,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 33.h),
                CustomButton(
                  text: AppTexts.login.tr(),
                  fontSize: 20.sp,
                  onPressed: () {},
                ),
                SizedBox(height: 12.h),
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      color: AppColors.whiteColor,
                      fontSize: 14.sp,
                    ),
                    children: [
                      TextSpan(text: AppTexts.dontHaveAccount.tr()),
                      TextSpan(
                        text: AppTexts.createOne.tr(),
                        style: TextStyle(
                          color: AppColors.mainColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 60.w),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: AppColors.mainColor,
                          thickness: 1.8,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        child: Text(
                          AppTexts.or.tr(),
                          style: TextStyle(color: AppColors.mainColor),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: AppColors.mainColor,
                          thickness: 1.8,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                CustomButton(
                  text: AppTexts.loginWithGoogle.tr(),
                  imageIcon: "assets/Images/Google.png",
                  fontSize: 16.sp,
                  onPressed: () {},
                ),
                SizedBox(height: 33.2.h),
                LanguageToggle(),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}