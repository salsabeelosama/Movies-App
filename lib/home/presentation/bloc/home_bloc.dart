import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';
import '../../domain/usecases/get_movies_usecase.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this._getMovies) : super(HomeInitial()) {
    on<FetchMoviesEvent>(_fetchMovies);
  }

  final GetMoviesUseCase _getMovies;

  Future<void> _fetchMovies(
    FetchMoviesEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());
    try {
      emit(HomeLoaded(await _getMovies()));
    } catch (error) {
      emit(HomeError(error.toString()));
    }
  }
}