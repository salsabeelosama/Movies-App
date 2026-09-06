import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../models/movie.dart';
import '../theme/app_theme.dart';

/// Poster card used in grids (Search results, Home rails). The bundled
/// poster art already has a rating badge baked into its top-left corner,
/// so this widget only clips and displays the image — no extra badge or
/// caption is drawn on top, matching the reference design.
class MoviePosterCard extends StatelessWidget {
  final Movie movie;
  final VoidCallback onTap;

  const MoviePosterCard({super.key, required this.movie, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14.r),
        child: _image(),
      ),
    );
  }

  Widget _image() {
    final url = movie.posterUrl;
    if (url.isEmpty) return _placeholder();
    if (url.startsWith('assets/')) {
      return Image.asset(url, fit: BoxFit.cover, errorBuilder: (_, __, ___) => _placeholder());
    }
    return Image.network(url, fit: BoxFit.cover, errorBuilder: (_, __, ___) => _placeholder());
  }

  Widget _placeholder() => Container(
        color: AppColors.chipBackground,
        alignment: Alignment.center,
        child: Icon(Icons.movie_rounded, color: AppColors.textSecondary, size: 32.sp),
      );
}
