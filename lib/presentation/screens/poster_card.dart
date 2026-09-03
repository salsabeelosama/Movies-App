import 'package:flutter/material.dart';
class PosterCard extends StatelessWidget {
  final String? imagePath;

  const PosterCard({
    Key? key,
    this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 170,
      height: 255,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.6),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(
            imagePath ?? 'assets/images/Card (2).png',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}