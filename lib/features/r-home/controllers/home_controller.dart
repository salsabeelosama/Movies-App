import 'package:flutter/foundation.dart';
import '../models/movie_model.dart';
import '../repositories/home_repository.dart';

class HomeController extends ChangeNotifier {
  final HomeRepository repository;

  HomeController(this.repository);

  List<MovieModel> movies = [];

  bool isLoading = false;
  String? errorMessage;

  Future<void> fetchMovies() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      movies = await repository.getMovies();
    } catch (error) {
      errorMessage = error.toString();
    }

    isLoading = false;
    notifyListeners();
  }

  List<MovieModel> get scientificMovies {
    return movies.where((movie) {
      return movie.genres.any(
        (genre) =>
            genre.toLowerCase() == 'sci-fi' ||
            genre.toLowerCase() == 'science fiction' ||
            genre.toLowerCase() == 'scientific',
      );
    }).toList();
  }

  List<MovieModel> get actionMovies {
    return movies.where((movie) {
      return movie.genres.any(
        (genre) => genre.toLowerCase() == 'action',
      );
    }).toList();
  }

  List<MovieModel> get romanceMovies {
    return movies.where((movie) {
      return movie.genres.any(
        (genre) => genre.toLowerCase() == 'romance',
      );
    }).toList();
  }
}