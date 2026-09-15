import 'movie_model.dart';
import '../../domain/entities/movie.dart';

extension MovieMapper on MovieModel {
  Movie toEntity() {
    return Movie(
      id: id,
      title: title,
      rating: rating,
      imageUrl: mediumCoverImage,
      genres: genres,
    );
  }
}