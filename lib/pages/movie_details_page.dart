import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../models/movie.dart';
import '../theme/app_theme.dart';
import '../widgets/app_bottom_nav.dart';

/// "Movie Details" screen: poster hero image with play-icon overlay,
/// title/year, Watch CTA, stat chips (likes / duration / rating), and a
/// horizontal screenshots strip.
///
/// The hero image (`movie.posterUrl`) is expected to be clean poster art
/// with no app UI baked in; the back/bookmark/play controls are drawn by
/// this widget using the bundled `assets/icons/ic_play.png` asset.
class MovieDetailsPage extends StatefulWidget {
  final Movie movie;
  final bool initiallyBookmarked;

  /// Which bottom-nav tab to highlight while this page is on screen.
  final int navIndex;

  /// Called when a bottom-nav icon is tapped. Defaults to popping this
  /// page back to the root tab view — override for real cross-tab
  /// navigation (e.g. via a router).
  final ValueChanged<int>? onNavTap;

  const MovieDetailsPage({
    super.key,
    required this.movie,
    this.initiallyBookmarked = false,
    this.navIndex = 0,
    this.onNavTap,
  });

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  late bool _bookmarked = widget.initiallyBookmarked;

  @override
  Widget build(BuildContext context) {
    final movie = widget.movie;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Movie Details',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20.r),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Poster art matches a 2:3 ratio (e.g. the
                          // bundled 430x645 doctor_strange_poster.png).
                          // Update if your art uses a different ratio.
                          AspectRatio(
                            aspectRatio: 2 / 3,
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                _posterImage(movie.detailsPosterUrl ?? movie.posterUrl),
                                // Gradient scrim fades the poster to
                                // black toward the bottom so it blends
                                // into the screen background instead of
                                // cutting off abruptly. Same size as the
                                // poster it sits on top of.
                                if (movie.posterGradientUrl != null)
                                  _scrimImage(movie.posterGradientUrl!),
                              ],
                            ),
                          ),
                          Positioned(
                            top: 12.h,
                            left: 12.w,
                            right: 12.w,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _circleIconButton(
                                  icon: Icons.arrow_back_ios_new_rounded,
                                  onTap: () => Navigator.maybePop(context),
                                ),
                                _circleIconButton(
                                  icon: _bookmarked
                                      ? Icons.bookmark_rounded
                                      : Icons.bookmark_border_rounded,
                                  onTap: () => setState(() => _bookmarked = !_bookmarked),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // TODO: hook up trailer/player launch
                            },
                            child: Image.asset(
                              'assets/icons/ic_play.png',
                              width: 64.w,
                              height: 64.w,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      movie.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Center(
                      child: Text(
                        '${movie.year}',
                        style: TextStyle(color: AppColors.textSecondary, fontSize: 13.sp),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    SizedBox(
                      width: double.infinity,
                      height: 48.h,
                      child: ElevatedButton(
                        onPressed: () {
                          // TODO: hook up watch/stream action
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.accentRed,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.r)),
                          elevation: 0,
                        ),
                        child: Text('Watch', style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600)),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _statChip(icon: Icons.favorite, iconColor: AppColors.accentRed, label: '${movie.likes}'),
                        _statChip(
                            icon: Icons.access_time_rounded,
                            iconColor: AppColors.accentOrange,
                            label: '${movie.durationMinutes}'),
                        _statChip(
                            icon: Icons.star_rounded,
                            iconColor: AppColors.accentOrange,
                            label: movie.rating.toStringAsFixed(1)),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      'Screen Shots',
                      style: TextStyle(color: AppColors.textPrimary, fontSize: 15.sp, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 10.h),
                    SizedBox(
                      height: 80.h,
                      child: movie.screenshotUrls.isEmpty
                          ? _screenshotPlaceholderRow()
                          : ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: movie.screenshotUrls.length,
                              separatorBuilder: (_, __) => SizedBox(width: 10.w),
                              itemBuilder: (context, index) {
                                final url = movie.screenshotUrls[index];
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(12.r),
                                  child: url.startsWith('assets/')
                                      ? Image.asset(url, width: 120.w, height: 80.h, fit: BoxFit.cover)
                                      : Image.network(
                                          url,
                                          width: 120.w,
                                          height: 80.h,
                                          fit: BoxFit.cover,
                                          errorBuilder: (_, __, ___) =>
                                              Container(width: 120.w, height: 80.h, color: AppColors.chipBackground),
                                        ),
                                );
                              },
                            ),
                    ),
                    SizedBox(height: 12.h),
                  ],
                ),
              ),
            ),
            AppBottomNav(
              currentIndex: widget.navIndex,
              onTap: widget.onNavTap ?? (_) => Navigator.popUntil(context, (r) => r.isFirst),
            ),
          ],
        ),
      ),
    );
  }

  Widget _posterImage(String posterUrl) {
    if (posterUrl.isEmpty) return _posterPlaceholder();
    if (posterUrl.startsWith('assets/')) {
      return Image.asset(posterUrl, fit: BoxFit.cover, errorBuilder: (_, __, ___) => _posterPlaceholder());
    }
    return Image.network(posterUrl, fit: BoxFit.cover, errorBuilder: (_, __, ___) => _posterPlaceholder());
  }

  Widget _scrimImage(String url) {
    final image = url.startsWith('assets/')
        ? Image.asset(url, fit: BoxFit.fill, errorBuilder: (_, __, ___) => const SizedBox.shrink())
        : Image.network(url, fit: BoxFit.fill, errorBuilder: (_, __, ___) => const SizedBox.shrink());
    return IgnorePointer(child: image);
  }

  Widget _circleIconButton({required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36.w,
        height: 36.w,
        decoration: BoxDecoration(color: Colors.black.withOpacity(0.45), shape: BoxShape.circle),
        child: Icon(icon, color: Colors.white, size: 16.sp),
      ),
    );
  }

  Widget _statChip({required IconData icon, required Color iconColor, required String label}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(color: AppColors.chipBackground, borderRadius: BorderRadius.circular(20.r)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: iconColor, size: 16.sp),
          SizedBox(width: 6.w),
          Text(label, style: TextStyle(color: AppColors.textPrimary, fontSize: 13.sp, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _posterPlaceholder() => Container(
        color: AppColors.chipBackground,
        alignment: Alignment.center,
        child: Icon(Icons.movie_rounded, size: 48.sp, color: AppColors.textSecondary),
      );

  Widget _screenshotPlaceholderRow() => ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        separatorBuilder: (_, __) => SizedBox(width: 10.w),
        itemBuilder: (_, __) => ClipRRect(
          borderRadius: BorderRadius.circular(12.r),
          child: Container(width: 120.w, height: 80.h, color: AppColors.chipBackground),
        ),
      );
}
