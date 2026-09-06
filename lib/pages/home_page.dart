import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../data/sample_movies.dart';
import '../theme/app_theme.dart';
import '../widgets/movie_poster_card.dart';
import 'movie_details_page.dart';

/// "Home" screen — a simple poster grid landing page. Replace
/// [sampleMovies] with your real trending/recommended feed.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 8.h),
              child: Text(
                'Home',
                style: TextStyle(color: AppColors.textSecondary, fontSize: 16.sp, fontWeight: FontWeight.w500),
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.fromLTRB(20.w, 4.h, 20.w, 12.h),
                itemCount: sampleMovies.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 14.w,
                  mainAxisSpacing: 14.h,
                  childAspectRatio: 189 / 269,
                ),
                itemBuilder: (context, index) {
                  final movie = sampleMovies[index];
                  return MoviePosterCard(
                    movie: movie,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => MovieDetailsPage(movie: movie)),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
