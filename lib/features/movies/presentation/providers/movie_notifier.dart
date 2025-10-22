import 'package:flutter_riverpod/legacy.dart';
import 'package:get_it/get_it.dart';
import '../../domain/entities/movie.dart';
import '../../domain/repositories/movie_repository.dart';

final movieListNotifierProvider =
    StateNotifierProvider<MovieListNotifier, MovieListState>(
      (ref) => MovieListNotifier(),
    );

class MovieListState {
  final bool isLoading;
  final List<Movie> movies;
  final String? error;

  MovieListState({this.isLoading = false, this.movies = const [], this.error});

  MovieListState copyWith({
    bool? isLoading,
    List<Movie>? movies,
    String? error,
  }) {
    return MovieListState(
      isLoading: isLoading ?? this.isLoading,
      movies: movies ?? this.movies,
      error: error,
    );
  }
}

class MovieListNotifier extends StateNotifier<MovieListState> {
  MovieListNotifier() : super(MovieListState()) {
    fetchPopular();
  }

  final _sl = GetIt.instance;

  Future<void> fetchPopular({int page = 1}) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final repo = _sl<MovieRepository>();
      final movies = await repo.getPopularMovies(page: page);
      state = state.copyWith(isLoading: false, movies: movies);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}
