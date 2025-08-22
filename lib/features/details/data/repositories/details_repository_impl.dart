import 'package:aplazo_pt/core/utils/typedefs.dart';
import 'package:dartz/dartz.dart';

import '../../domain/entities/meals_details_category.dart';
import '../../domain/repositories/details_repository.dart';
import '../datasources/themealdb_api.dart';

class DetailsRepositoryImpl implements DetailsRepository {
  const DetailsRepositoryImpl(this._remoteDataSource);

  final DetailsRemoteDataSource _remoteDataSource;

  @override
  ResultFuture<MealDetails> getMealById(String idMeal) async {
    final result = await _remoteDataSource.getMealById(idMeal);
    return result.fold((failure) => Left(failure), (mealsResponse) {
      final meal = mealsResponse.meals.first;
      return Right(
        MealDetails(
          name: meal.name,
          id: meal.id,
          ingredients: meal.ingredients
              .map(
                (element) =>
                    Ingredient(name: element.name, measure: element.measure),
              )
              .toList(),
          instructions: meal.instructions,
          image: meal.thumbnailUrl != null
              ? MealDetailsImage(meal.thumbnailUrl!)
              : null,
          category: meal.category,
          area: meal.area,
          youtube: meal.youtubeUrl,
        ),
      );
    });
  }
}
