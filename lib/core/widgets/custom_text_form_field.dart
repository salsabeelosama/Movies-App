import 'package:flutter/material.dart';
import 'package:movies_app/core/constants/app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData? prefixIcon;
  final bool isPassword;


  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    this.prefixIcon,
    this.isPassword = false,

  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Center(
        child: SizedBox(
          width: 392,
          height: 56,
          child: TextFormField(
            controller: controller,
            obscureText: isPassword,
            style: const TextStyle(color: AppColors.whiteColor),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(color: Colors.white),
              filled: true,
              fillColor: AppColors.subColor,
              prefixIcon: prefixIcon != null
                  ? Padding(
                padding: const EdgeInsets.only(left: 19, right: 4),
                child: Icon(prefixIcon, color: Colors.grey),
              )
                  : null,
              prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      ),
    );
  }
}