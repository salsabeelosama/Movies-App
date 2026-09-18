import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/constants/app_colors.dart';
import 'package:movies_app/core/constants/app_texts.dart';
import 'package:movies_app/core/widgets/custom_text_form_field.dart';
import 'package:movies_app/core/widgets/custom_button.dart';
import 'package:movies_app/core/widgets/language_toggle.dart';
import 'package:movies_app/features/Auth/controller/login_cubit.dart';
import 'package:movies_app/features/Auth/controller/login_state.dart';
import 'package:movies_app/features/Auth/repository/auth_repository.dart';
import 'forget_password_screen.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.locale;

    return BlocProvider(
      create: (_) => LoginCubit(AuthRepository()),
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: SingleChildScrollView(
              child: BlocConsumer<LoginCubit, LoginState>(
                listener: (context, state) {
                  if (state is LoginFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.message)),
                    );
                  }
                  if (state is LoginSuccess) {}
                },
                builder: (context, state) {
                  final isLoading = state is LoginLoading;
                  return Column(
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
                        alignment: AlignmentDirectional.centerEnd,
                        child: Padding(
                          padding: EdgeInsetsDirectional.only(end: 24.w),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ForgetPasswordScreen(),
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
                        isLoading: isLoading,
                        onPressed: () {
                          context.read<LoginCubit>().login(
                            email: emailController.text,
                            password: passwordController.text,
                          );
                        },
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
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const RegisterScreen(),
                                    ),
                                  );
                                },
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
                        onPressed: () {
                          context.read<LoginCubit>().loginWithGoogle();
                        },
                      ),
                      SizedBox(height: 33.2.h),
                      const LanguageToggle(),
                      SizedBox(height: 20.h),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}