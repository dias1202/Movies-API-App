import '../../domain/entities/movie.dart';
import '../../domain/repositories/movie_repository.dart';
import '../data_sources/movie_remote_data_source.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource remoteDataSource;

  MovieRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Movie>> getPopularMovies({int page = 1}) {
    return remoteDataSource.getPopularMovies(page: page);
  }

  @override
  Future<Movie> getMovieDetail(int id) {
    return remoteDataSource.getMovieDetail(id);
  }
}
