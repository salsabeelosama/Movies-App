import 'package:flutter/material.dart';
import 'package:movies_app/core/constants/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? icon;
  final String? imageIcon;
  final double fontSize;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.imageIcon,
    this.fontSize = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Center(
        child: SizedBox(
          width: 392,
          height: 56,
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.mainColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (imageIcon != null) ...[
                  Image.asset(imageIcon!, width: 26.56, height: 26.56),
                  const SizedBox(width: 8),
                ] else if (icon != null) ...[
                  Icon(icon, color: Colors.black),
                  const SizedBox(width: 8),
                ],
                Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    fontSize: fontSize,
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}