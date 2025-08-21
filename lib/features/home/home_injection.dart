import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'data/datasources/themealdb_api.dart';
import 'data/repositories/home_repository_impl.dart';
import 'domain/repositories/home_repository.dart';
import 'domain/usecases/get_categories.dart';
import 'domain/usecases/get_meals_by_category.dart';
import 'presentation/bloc/home_bloc/home_bloc.dart';

Future<void> homeInjection(GetIt sl) async {
  sl
    ..registerLazySingleton<HomeRemoteDataSource>(
      () => HomeRemoteDataSourceImpl(sl<Dio>()),
    )
    ..registerLazySingleton<HomeRepository>(
      () => HomeRepositoryImpl(sl<HomeRemoteDataSource>()),
    )
    ..registerLazySingleton<GetMealsByCategoryUseCase>(
      () => GetMealsByCategoryUseCase(sl<HomeRepository>()),
    )
    ..registerLazySingleton<GetCategoriesUseCase>(
      () => GetCategoriesUseCase(sl<HomeRepository>()),
    )
    ..registerLazySingleton<HomeBloc>(() => HomeBloc(sl(), sl()));
}
