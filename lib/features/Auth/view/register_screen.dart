import 'package:easy_localization/easy_localization.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:movies_app/core/constants/app_colors.dart';
import 'package:movies_app/core/constants/app_images.dart';
import 'package:movies_app/core/constants/app_routes.dart';
import 'package:movies_app/core/constants/app_texts.dart';
import 'package:movies_app/core/widgets/custom_button.dart';
import 'package:movies_app/core/widgets/custom_text_form_field.dart';
import 'package:movies_app/core/widgets/language_toggle.dart';
import 'package:movies_app/features/Auth/controller/register_cubit/register_cubit.dart';
import 'package:movies_app/features/Auth/controller/register_cubit/register_state.dart';
import 'package:movies_app/features/Auth/repository/auth_repository.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final PageController controller = PageController(
    viewportFraction: 0.3,
    initialPage: 0,
  );

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController confPassController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  final List<String> avatars = [
    AppImages.avatar1,
    AppImages.avatar2,
    AppImages.avatar3,
    AppImages.avatar4,
    AppImages.avatar5,
    AppImages.avatar6,
    AppImages.avatar7,
    AppImages.avatar8,
    AppImages.avatar9,
  ];

  String selectedAvatar = 'avatar1';

  bool isPasswordObscured = true;
  bool isConfirmPasswordObscured = true;

  void togglePasswordVisibility() {
    setState(() {
      isPasswordObscured = !isPasswordObscured;
    });
  }

  void toggleConfirmPasswordVisibility() {
    setState(() {
      isConfirmPasswordObscured = !isConfirmPasswordObscured;
    });
  }

  @override
  void dispose() {
    controller.dispose();
    nameController.dispose();
    emailController.dispose();
    passController.dispose();
    confPassController.dispose();
    phoneController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(
        AuthRepository(
        ),
      ),
      child: BlocListener<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterSuccess) {
            Navigator.pushReplacementNamed(context, AppRoutes.profile);
          }
        },
        child: Builder(
            builder: (context){
              return Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  backgroundColor: Colors.transparent,
                  title: Text(
                    AppTexts.register.tr(),
                    style: TextStyle(
                      color: AppColors.mainColor,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),

                body: Form(
                  key: formkey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 150.h,
                        child: PageView.builder(
                          dragStartBehavior: DragStartBehavior.start,
                          onPageChanged: (index) {
                            setState(() {
                              selectedAvatar = 'avatar${index + 1}';
                            });
                          },
                          controller: controller,
                          itemCount: avatars.length,
                          itemBuilder: (context, index) {
                            return AnimatedBuilder(
                              animation: controller,
                              builder: (context, child) {
                                double scale = 0.7;

                                if (controller.hasClients &&
                                    controller.positions.length == 1) {
                                  final page = controller.page ?? 0.0;

                                  final distance = (page - index).abs();

                                  scale = (1 - distance * 0.5).clamp(0.7, 1.0);
                                }

                                return Center(
                                  child: Transform.scale(
                                    scale: scale,
                                    child: Image.asset(avatars[index]),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),

                      CustomTextFormField(
                        controller: nameController,
                        hintText: AppTexts.name.tr(),
                        prefixIcon: Icons.co_present,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Name is required';
                          }

                          return null;
                        },
                      ),

                      CustomTextFormField(
                        controller: emailController,
                        hintText: AppTexts.email.tr(),
                        prefixIcon: Icons.email_rounded,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Email is required';
                          }

                          if (!value.contains('@')) {
                            return 'Enter a valid email';
                          }

                          return null;
                        },
                      ),

                      CustomTextFormField(
                        controller: passController,
                        hintText: AppTexts.password.tr(),
                        prefixIcon: Icons.lock,
                        isPassword: isPasswordObscured,
                        suffix: IconButton(
                          color: Colors.white,
                          onPressed: togglePasswordVisibility,
                          icon: Icon(
                            isPasswordObscured
                                ? Icons.visibility_off
                                : Icons.remove_red_eye_rounded,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Password is required';
                          }

                          if (value.length < 8) {
                            return 'Password must be at least 8 characters';
                          }

                          return null;
                        },
                      ),

                      CustomTextFormField(
                        controller: confPassController,
                        hintText: AppTexts.confPassword.tr(),
                        prefixIcon: Icons.lock,
                        isPassword: isConfirmPasswordObscured,
                        suffix: IconButton(
                          color: Colors.white,
                          onPressed: toggleConfirmPasswordVisibility,
                          icon: Icon(
                            isConfirmPasswordObscured
                                ? Icons.visibility_off
                                : Icons.remove_red_eye_rounded,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Password is required';
                          }

                          if (passController.text != confPassController.text) {
                            return 'Passwords must match';
                          }

                          return null;
                        },
                      ),

                      CustomTextFormField(
                        controller: phoneController,
                        hintText: AppTexts.phoneNumber.tr(),
                        prefixIcon: Icons.phone,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Phone number is required';
                          }
                        },
                      ),

                      CustomButton(
                        text: AppTexts.createAccount.tr(),
                        onPressed: () {
                          if (formkey.currentState!.validate()) {
                            context.read<RegisterCubit>().register(
                              name: nameController.text.trim(),
                              email: emailController.text.trim(),
                              password: passController.text,
                              phone: phoneController.text.trim(),
                              avatar: selectedAvatar,
                            );
                          }
                        },
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppTexts.havAcc.tr(),
                            style: TextStyle(
                              color: AppColors.whiteColor,
                              fontSize: 16.sp,
                            ),
                          ),

                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, AppRoutes.login);
                            },
                            child: Text(
                              AppTexts.login.tr(),
                              style: TextStyle(
                                color: AppColors.mainColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.sp,
                              ),
                            ),
                          ),
                        ],
                      ),

                      LanguageToggle(),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }

}