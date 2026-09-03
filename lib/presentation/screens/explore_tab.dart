import 'package:flutter/material.dart';
import '../widgets/poster_card.dart';
import '../widgets/min_card.dart';

class ExploreTab extends StatelessWidget {
  const ExploreTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final List<Map<String, String>> movies = [
      {
        'image': 'assets/images/Card (2).png',
        'rating': '7.7',
        'subtitle': 'TIME IS THE ENEMY'
      },
      {
        'image': 'assets/images/Card (4).png',
        'rating': '7.7',
        'subtitle': 'CAPTAIN AMERICA'
      },
      {
        'image': 'assets/images/Card (1).png',
        'rating': '7.7',
        'subtitle': 'THE DARK KNIGHT'
      },
    ];

    final List<String> actionMovies = [
      'assets/images/Card (3).png',
      'assets/images/Card (5).png',
      'assets/images/Card (6).png',
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/Card (2).png',
            fit: BoxFit.cover,
          ),
          Positioned.fill(
            child: Opacity(
              opacity: 0.4,
              child: Image.asset(
                'assets/images/1917_-_Sam_Mendes_-_Hollywood_War_Film_Classic_English_Movie_Poster_9ef86295-4756-4c71-bb4e-20745c5fbc1a 4.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.6),
                  Colors.black.withOpacity(0.8),
                  Colors.black.withOpacity(0.95),
                ],
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.06,
                        vertical: size.height * 0.02,
                      ),
                      child: const Text(
                        "Available Now",
                        style: TextStyle(
                          fontFamily: 'MovieScript',
                          fontSize: 42,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 280,
                    child: PageView.builder(
                      itemCount: movies.length,
                      controller: PageController(viewportFraction: 0.6),
                      itemBuilder: (context, index) {
                        final int imageNumber = (index % 6) + 1;
                        return Center(
                          child: PosterCard(
                            imagePath: 'assets/images/Card ($imageNumber).png',
                          ),
                        );
                      },
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
                      child: const Text(
                        "Watch Now",
                        style: TextStyle(
                          fontFamily: 'MovieScript',
                          fontSize: 42,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "Action",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "See More →",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.amber,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: size.height * 0.015),
                  SizedBox(
                    height: size.height * 0.22,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
                      itemCount: actionMovies.length,
                      separatorBuilder: (context, index) => const SizedBox(width: 14),
                      itemBuilder: (context, index) {
                        return MinCard(
                          imagePath: actionMovies[index],
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E1E).withOpacity(0.9),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(icon: Icons.home_rounded, isSelected: true),
            _buildNavItem(icon: Icons.search_rounded, isSelected: false),
            _buildNavItem(icon: Icons.grid_view_rounded, isSelected: false),
            _buildNavItem(icon: Icons.person_outline_rounded, isSelected: false),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({required IconData icon, required bool isSelected}) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFFDDA850) : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Icon(
        icon,
        color: isSelected ? Colors.black : Colors.grey,
        size: 24,
      ),
    );
  }
}