import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'data/datasources/themealdb_api.dart';
import 'data/repositories/details_repository_impl.dart';
import 'domain/repositories/details_repository.dart';
import 'domain/usecases/get_meal_details.dart';
import 'presentation/bloc/details_bloc/details_bloc.dart';

Future<void> detailsInjection(GetIt sl) async {
  sl
    ..registerLazySingleton<DetailsRemoteDataSource>(
      () => DetailsRemoteDataSourceImpl(sl<Dio>()),
    )
    ..registerLazySingleton<DetailsRepository>(
      () => DetailsRepositoryImpl(sl<DetailsRemoteDataSource>()),
    )
    ..registerLazySingleton<GetMealDetailsUseCase>(
      () => GetMealDetailsUseCase(sl<DetailsRepository>()),
    )
    ..registerFactory<DetailsBloc>(() => DetailsBloc(sl()));
}
