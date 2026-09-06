import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../data/sample_movies.dart';
import '../models/movie.dart';
import '../theme/app_theme.dart';
import '../widgets/app_bottom_nav.dart';
import '../widgets/movie_poster_card.dart';
import 'movie_details_page.dart';

/// "Search" screen: search field, empty state (popcorn icon), and a
/// 2-column poster grid. Wire `onSearch` up to your real data source
/// (API/service); defaults to filtering the bundled [sampleMovies].
class SearchPage extends StatefulWidget {
  final Future<List<Movie>> Function(String query)? onSearch;
  final int navIndex;
  final ValueChanged<int>? onNavTap;

  const SearchPage({super.key, this.onSearch, this.navIndex = 1, this.onNavTap});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();
  List<Movie> _results = [];
  bool _searched = false;

  Future<void> _runSearch(String query) async {
    if (query.trim().isEmpty) {
      setState(() {
        _results = [];
        _searched = false;
      });
      return;
    }

    final results = widget.onSearch != null
        ? await widget.onSearch!(query)
        : sampleMovies.where((m) => m.title.toLowerCase().contains(query.toLowerCase())).toList();

    setState(() {
      _results = results;
      _searched = true;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 8.h),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Search',
                  style: TextStyle(color: AppColors.textSecondary, fontSize: 16.sp, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Container(
                height: 46.h,
                padding: EdgeInsets.symmetric(horizontal: 14.w),
                decoration: BoxDecoration(color: AppColors.chipBackground, borderRadius: BorderRadius.circular(14.r)),
                child: Row(
                  children: [
                    Container(
                      width: 24.w,
                      height: 24.w,
                      decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                      child: Icon(Icons.search_rounded, color: AppColors.background, size: 14.sp),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        onChanged: _runSearch,
                        style: TextStyle(color: AppColors.textPrimary, fontSize: 14.sp),
                        decoration: InputDecoration(
                          hintText: 'Search',
                          hintStyle: TextStyle(color: AppColors.textSecondary, fontSize: 14.sp),
                          border: InputBorder.none,
                          isCollapsed: true,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 8.h),
            Expanded(
              child: !_searched
                  ? _initialEmptyState()
                  : _results.isEmpty
                      ? _noResultsState()
                      : GridView.builder(
                          padding: EdgeInsets.fromLTRB(20.w, 4.h, 20.w, 12.h),
                          itemCount: _results.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 14.w,
                            mainAxisSpacing: 14.h,
                            childAspectRatio: 189 / 269,
                          ),
                          itemBuilder: (context, index) {
                            final movie = _results[index];
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
            if (widget.onNavTap != null) AppBottomNav(currentIndex: widget.navIndex, onTap: widget.onNavTap!),
          ],
        ),
      ),
    );
  }

  /// Before any query is typed — just the popcorn icon, matching the
  /// reference design (no caption text).
  Widget _initialEmptyState() {
    return Center(
      child: Image.asset('assets/icons/ic_empty_state.png', width: 90.w, height: 90.w),
    );
  }

  /// After a query returns nothing. No reference screenshot for this
  /// state, so a short caption is kept underneath for usability.
  Widget _noResultsState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset('assets/icons/ic_empty_state.png', width: 90.w, height: 90.w),
          SizedBox(height: 10.h),
          Text('No results found', style: TextStyle(color: AppColors.textSecondary, fontSize: 13.sp)),
        ],
      ),
    );
  }
}
