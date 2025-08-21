import 'package:aplazo_pt/features/serch_by_name/data/datasources/themealdb_api.dart';
import 'package:aplazo_pt/features/serch_by_name/data/repositories/search_by_name_repository_impl.dart';
import 'package:aplazo_pt/features/serch_by_name/domain/repositories/search_by_name_repository.dart';
import 'package:aplazo_pt/features/serch_by_name/domain/usecases/get_meals_bychar.dart';
import 'package:aplazo_pt/features/serch_by_name/presentation/bloc/search_by_name_bloc/search_by_name_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

Future<void> searchByNameInjection(GetIt sl) async {
  sl
    ..registerLazySingleton<SearchByNameRemoteDataSource>(
      () => SearchByNameRemoteDataSourceImpl(sl<Dio>()),
    )
    ..registerLazySingleton<SearchByNameRepository>(
      () => SearchByNameRepositoryImpl(sl<SearchByNameRemoteDataSource>()),
    )
    ..registerLazySingleton<GetMealsByCharUseCase>(
      () => GetMealsByCharUseCase(sl<SearchByNameRepository>()),
    )
    ..registerLazySingleton<SearchByNameBloc>(() => SearchByNameBloc(sl()));
}
