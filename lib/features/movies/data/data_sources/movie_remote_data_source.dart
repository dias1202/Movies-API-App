import './../../../../core/api/api_client.dart';
import '../models/movie_model.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> getPopularMovies({int page = 1});
  Future<MovieModel> getMovieDetail(int id);
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  final ApiClient client;

  MovieRemoteDataSourceImpl({required this.client});

  @override
  Future<List<MovieModel>> getPopularMovies({int page = 1}) async {
    final json = await client.get('/movie/popular', {'page': page.toString()});
    final results = json['results'] as List<dynamic>;
    return results
        .map((e) => MovieModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<MovieModel> getMovieDetail(int id) async {
    final json = await client.get('/movie/$id');
    return MovieModel.fromJson(json);
  }
}
