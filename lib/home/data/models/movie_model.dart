class MovieModel {
  final int id;
  final String title;
  final String rating;
  final String mediumCoverImage;
  final List<String> genres;

  MovieModel({
    required this.id,
    required this.title,
    required this.rating,
    required this.mediumCoverImage,
    required this.genres,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      rating: json['rating']?.toString() ?? '0.0',
      mediumCoverImage: json['medium_cover_image']?.toString() ?? '',
      genres: List<String>.from(json['genres'] ?? []),
    );
  }
}