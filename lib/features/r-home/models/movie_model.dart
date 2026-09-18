class MovieModel {
  final int id;
  final String title;
  final String rating;
  final String imageUrl;
  final List<String> genres;

  MovieModel({
    required this.id,
    required this.title,
    required this.rating,
    required this.imageUrl,
    required this.genres,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      rating: json['rating']?.toString() ?? '0.0',
      imageUrl: json['medium_cover_image']?.toString() ?? '',
      genres: List<String>.from(json['genres'] ?? []),
    );
  }
}