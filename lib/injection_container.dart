import 'package:get_it/get_it.dart';
import 'core/api/api_client.dart';
import 'features/movies/data/data_sources/movie_remote_data_source.dart';
import 'features/movies/data/repositories/movie_repository_impl.dart';
import 'features/movies/domain/repositories/movie_repository.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Core
  sl.registerLazySingleton<ApiClient>(() => ApiClient());

  // Data sources
  sl.registerLazySingleton<MovieRemoteDataSource>(() => MovieRemoteDataSourceImpl(client: sl()));

  // Repositories
  sl.registerLazySingleton<MovieRepository>(() => MovieRepositoryImpl(remoteDataSource: sl()));

  // NOTE: providers / notifiers akan didaftarkan di Riverpod, bukan di get_it, tapi
  // kalau mau kamu juga bisa register ViewModels di sini.
}
