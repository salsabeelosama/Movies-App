import '../../domain/respositories/home_repository.dart';
import '../../domain/entities/movie.dart';
import '../models/movie_model.dart';
import '../models/movie_mapper.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeRepositoryImpl implements HomeRepository {
  @override
  Future<List<Movie>> getMovies() async {
    List<Movie> allMovies = [];

    for (int page = 1; page <= 5; page++) {
      final response = await http.get(
        Uri.parse(
          'https://movies-api.accel.li/api/v2/list_movies.json?page=$page&limit=50',
        ),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List moviesList = data['data']['movies'] ?? [];

        final movies = moviesList
            .map((json) => MovieModel.fromJson(json).toEntity())
            .toList();

        allMovies.addAll(movies);
      }
    }

    return allMovies;
  }
}