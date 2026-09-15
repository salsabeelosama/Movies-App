import '../respositories/home_repository.dart';
import '../entities/movie.dart';

class GetMoviesUseCase {
  final HomeRepository repository;

  GetMoviesUseCase(this.repository);

  Future<List<Movie>> call() async {
    return await repository.getMovies();
  }
}