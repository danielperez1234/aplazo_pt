import 'package:aplazo_pt/core/utils/typedefs.dart';
import 'package:dartz/dartz.dart';

import '../../domain/entities/meals_search_by_category.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasources/themealdb_api.dart';

class HomeRepositoryImpl implements HomeRepository {
  const HomeRepositoryImpl(this._remoteDataSource);

  final HomeRemoteDataSource _remoteDataSource;

  @override
  ResultFuture<List<MealsSearchByCategory>> getMealsByCategory(
    String char,
  ) async {
    final result = await _remoteDataSource.getMealsByCategory(char);
    return result.fold(
      (failure) => Left(failure),
      (mealsResponse) => Right(
        mealsResponse.meals
            .map(
              (meal) => MealsSearchByCategory(
                id: meal.id,
                name: meal.name,
                image: meal.thumbnailUrl != null
                    ? MealsSearchByNameImage(meal.thumbnailUrl!)
                    : null,
              ),
            )
            .toList(),
      ),
    );
  }

  @override
  ResultFuture<List<String>> getCategories() async {
    final result = await _remoteDataSource.getCategories();
    return result.fold(
      (failure) => Left(failure),
      (categories) => Right(categories),
    );
  }
}
