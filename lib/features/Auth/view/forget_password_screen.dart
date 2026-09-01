import 'package:flutter/material.dart';
import 'package:movies_app/core/constants/app_colors.dart';
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
        child: Column(
          children: [
            const SizedBox(height: 16),
            Stack(
              alignment: Alignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(Icons.arrow_back, color: AppColors.mainColor),
                    ),
                  ),
                ),
                Text(
                  "Forget Password",
                  style: TextStyle(
                    color: AppColors.mainColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),

            Image.asset("assets/Images/Forgot_Password.png"),

            const SizedBox(height: 24),

            CustomTextFormField(
              controller: emailController,
              hintText: "Email",
              prefixIcon: Icons.email_rounded,
            ),

            const SizedBox(height: 10),

            CustomButton(
              text: "Verify Email",
              fontSize: 20,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}