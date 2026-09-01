import 'package:flutter/material.dart';
import 'package:movies_app/core/constants/app_colors.dart';
import 'package:movies_app/core/widgets/custom_text_form_field.dart';
import 'package:movies_app/core/widgets/custom_button.dart';
import 'forget_password_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 67),
            Center(child: Image.asset("assets/Images/Login_Icon.png")),

            const SizedBox(height: 69),

            CustomTextFormField(
              controller: emailController,
              hintText: "Email",
              prefixIcon: Icons.email_rounded,
            ),
            CustomTextFormField(
              controller: passwordController,
              hintText: "Password",
              prefixIcon: Icons.lock,
              isPassword: true,
            ),

            const SizedBox(height: 9),

            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 24),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ForgetPasswordScreen()),
                    );
                  },
                  child: Text(
                    "Forget Password ?",
                    style: TextStyle(color: AppColors.mainColor, fontSize: 14),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 33),

            CustomButton(
              text: "Login",
              fontSize: 20,
              onPressed: () {},
            ),

            const SizedBox(height: 12),
            RichText(
              text: TextSpan(
                style: const TextStyle(color: AppColors.whiteColor, fontSize: 14),
                children: [
                  const TextSpan(text: "Don't Have Account ? "),
                  TextSpan(
                    text: "Create One",
                    style: TextStyle(color: AppColors.mainColor, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              child: Row(
                children: [
                  Expanded(child: Divider(color: AppColors.mainColor, thickness: 1.8)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text("OR", style: TextStyle(color: AppColors.mainColor)),
                  ),
                  Expanded(child: Divider(color: AppColors.mainColor, thickness: 1.8)),
                ],
              ),
            ),
            const SizedBox(height: 20),

            CustomButton(
              text: "Login With Google",
              imageIcon: "assets/Images/Google.png",
              fontSize: 16,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}