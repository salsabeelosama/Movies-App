class Movie {
  final int id;
  final String title;
  final String rating;
  final String imageUrl;
  final List<String> genres;

  Movie({
    required this.id,
    required this.title,
    required this.rating,
    required this.imageUrl,
    required this.genres,
  });
}