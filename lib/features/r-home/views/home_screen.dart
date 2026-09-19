import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:movies_app/features/Profile/view/profile_screen.dart';
import '../controllers/home_controller.dart';
import '../models/movie_model.dart';
import '../repositories/home_repository.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeContentView(),
    const Center(
      child: Text(
        'Search Screen',
        style: TextStyle(
          color: Colors.white,
          fontSize: 22,
        ),
      ),
    ),
    const Center(
      child: Text(
        'Explore Screen',
        style: TextStyle(
          color: Colors.white,
          fontSize: 22,
        ),
      ),
    ),
    const ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        height: 65,
        margin: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E1E),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              enableFeedback: false,
              onPressed: () {
                setState(() {
                  _currentIndex = 0;
                });
              },
              icon: Icon(
                Icons.home,
                color: _currentIndex == 0
                    ? Colors.amber
                    : Colors.white54,
                size: 26,
              ),
            ),
            IconButton(
              enableFeedback: false,
              onPressed: () {
                setState(() {
                  _currentIndex = 1;
                });
              },
              icon: Icon(
                Icons.search,
                color: _currentIndex == 1
                    ? Colors.amber
                    : Colors.white54,
                size: 26,
              ),
            ),
            IconButton(
              enableFeedback: false,
              onPressed: () {
                setState(() {
                  _currentIndex = 2;
                });
              },
              icon: Icon(
                Icons.explore_outlined,
                color: _currentIndex == 2
                    ? Colors.amber
                    : Colors.white54,
                size: 26,
              ),
            ),
            IconButton(
              enableFeedback: false,
              onPressed: () {
                setState(() {
                  _currentIndex = 3;
                });
              },
              icon: Icon(
                Icons.person_outline,
                color: _currentIndex == 3
                    ? Colors.amber
                    : Colors.white54,
                size: 26,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeContentView extends StatefulWidget {
  const HomeContentView({super.key});

  @override
  State<HomeContentView> createState() => _HomeContentViewState();
}

class _HomeContentViewState extends State<HomeContentView> {
  late final HomeController _controller;

  int _featuredCurrentIndex = 0;

  late final PageController _pageController;

  @override
  void initState() {
    super.initState();

    _controller = HomeController(
      HomeRepository(),
    );

    _pageController = PageController(
      viewportFraction: 0.45,
    );

    _controller.fetchMovies();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        if (_controller.isLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.amber,
            ),
          );
        }

        if (_controller.errorMessage != null) {
          return Center(
            child: Text(
              _controller.errorMessage!,
              style: const TextStyle(
                color: Colors.red,
              ),
            ),
          );
        }

        if (_controller.movies.isEmpty) {
          return const Center(
            child: Text(
              'No movies available',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          );
        }

        if (_featuredCurrentIndex >= _controller.movies.length) {
          _featuredCurrentIndex = 0;
        }

        final currentMovie =
            _controller.movies[_featuredCurrentIndex];

        return Stack(
          children: [
            Positioned.fill(
              child: AnimatedSwitcher(
                duration: const Duration(
                  milliseconds: 450,
                ),
                switchInCurve: Curves.easeIn,
                switchOutCurve: Curves.easeOut,
                child: _buildFullScreenBackground(
                  currentMovie,
                ),
              ),
            ),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [
                      0.0,
                      0.40,
                      0.65,
                      0.82,
                      1.0,
                    ],
                    colors: [
                      Colors.black.withOpacity(0.15),
                      Colors.black.withOpacity(0.25),
                      Colors.black.withOpacity(0.45),
                      Colors.black.withOpacity(0.78),
                      const Color(0xFF121212),
                    ],
                  ),
                ),
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      _buildFeaturedMoviesSlider(
                        _controller.movies,
                      ),
                      const SizedBox(height: 24),
                      _buildSectionHeader(
                        context,
                        'Scientific',
                        _controller.scientificMovies,
                      ),
                      const SizedBox(height: 12),
                      _buildMoviesHorizontalList(
                        _controller.scientificMovies,
                      ),
                      const SizedBox(height: 24),
                      _buildSectionHeader(
                        context,
                        'Action',
                        _controller.actionMovies,
                      ),
                      const SizedBox(height: 12),
                      _buildMoviesHorizontalList(
                        _controller.actionMovies,
                      ),
                      const SizedBox(height: 24),
                      _buildSectionHeader(
                        context,
                        'Romance',
                        _controller.romanceMovies,
                      ),
                      const SizedBox(height: 12),
                      _buildMoviesHorizontalList(
                        _controller.romanceMovies,
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildFullScreenBackground(
    MovieModel movie,
  ) {
    return SizedBox.expand(
      key: ValueKey(movie.imageUrl),
      child: ClipRect(
        child: ImageFiltered(
          imageFilter: ImageFilter.blur(
            sigmaX: 7,
            sigmaY: 7,
          ),
          child: Transform.scale(
            scale: 1.45,
            child: Image.network(
              movie.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (
                context,
                error,
                stackTrace,
              ) {
                return Container(
                  color: const Color(0xFF121212),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeaturedMoviesSlider(
    List<MovieModel> movies,
  ) {
    return SizedBox(
      height: 390,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: -12,
            child: Text(
              'Available Now',
              style: TextStyle(
                fontFamily: 'DancingScript',
                fontSize: 48,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    blurRadius: 10.0,
                    color: Colors.black.withOpacity(0.8),
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 50,
            bottom: 75,
            left: 0,
            right: 0,
            child: PageView.builder(
              controller: _pageController,
              physics: const BouncingScrollPhysics(),
              itemCount: movies.length,
              onPageChanged: (index) {
                setState(() {
                  _featuredCurrentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                final movie = movies[index];

                return AnimatedBuilder(
                  animation: _pageController,
                  builder: (context, child) {
                    double value = 1.0;

                    if (_pageController
                        .position
                        .haveDimensions) {
                      value =
                          _pageController.page! - index;

                      value = (1 -
                              (value.abs() * 0.3))
                          .clamp(0.7, 1.0);
                    }

                    return Center(
                      child: SizedBox(
                        height:
                            Curves.easeOut.transform(value) *
                                230,
                        width:
                            Curves.easeOut.transform(value) *
                                145,
                        child: child,
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 6,
                    ),
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.circular(16),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.network(
                            movie.imageUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (
                              context,
                              error,
                              stackTrace,
                            ) {
                              return Container(
                                color:
                                    const Color(0xFF252525),
                                child: const Center(
                                  child: Icon(
                                    Icons.broken_image,
                                    color: Colors.red,
                                    size: 40,
                                  ),
                                ),
                              );
                            },
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              margin:
                                  const EdgeInsets.all(8),
                              padding:
                                  const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black54,
                                borderRadius:
                                    BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisSize:
                                    MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 14,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    movie.rating,
                                    style:
                                        const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Positioned(
            bottom: 15,
            child: Text(
              'Watch Now',
              style: TextStyle(
                fontFamily: 'DancingScript',
                fontSize: 48,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    blurRadius: 10.0,
                    color: Colors.black.withOpacity(0.8),
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(
    BuildContext context,
    String title,
    List<MovieModel> movies,
  ) {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        GestureDetector(
          onTap: () {
            if (movies.isEmpty) {
              return;
            }

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'See more $title movies',
                ),
              ),
            );
          },
          child: Row(
            children: const [
              Text(
                'See More',
                style: TextStyle(
                  color: Colors.amber,
                  fontSize: 14,
                ),
              ),
              SizedBox(width: 4),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.amber,
                size: 12,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMoviesHorizontalList(
    List<MovieModel> movies,
  ) {
    if (movies.isEmpty) {
      return const SizedBox(
        height: 100,
        child: Center(
          child: Text(
            'No movies available',
            style: TextStyle(
              color: Colors.white54,
              fontSize: 14,
            ),
          ),
        ),
      );
    }

    return SizedBox(
      height: 240,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];

          return Container(
            width: 140,
            margin: const EdgeInsets.only(
              right: 12,
            ),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.circular(16),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.network(
                          movie.imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (
                            context,
                            error,
                            stackTrace,
                          ) {
                            return Container(
                              color:
                                  const Color(0xFF252525),
                              child: const Center(
                                child: Icon(
                                  Icons.broken_image,
                                  color: Colors.red,
                                  size: 40,
                                ),
                              ),
                            );
                          },
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            margin:
                                const EdgeInsets.all(8),
                            padding:
                                const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black54,
                              borderRadius:
                                  BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisSize:
                                  MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 14,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  movie.rating,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}