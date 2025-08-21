import 'package:aplazo_pt/core/utils/typedefs.dart';
import 'package:aplazo_pt/features/serch_by_name/data/datasources/themealdb_api.dart';
import 'package:aplazo_pt/features/serch_by_name/domain/entities/meals_search_by_name.dart';
import 'package:aplazo_pt/features/serch_by_name/domain/repositories/search_by_name_repository.dart';
import 'package:dartz/dartz.dart';

class SearchByNameRepositoryImpl implements SearchByNameRepository {
  const SearchByNameRepositoryImpl(this._remoteDataSource);

  final SearchByNameRemoteDataSource _remoteDataSource;

  @override
  ResultFuture<List<MealsSearchByName>> getMealsByChar(String char) async {
    final result = await _remoteDataSource.getMealsByChar(char);
    return result.fold(
      (failure) => Left(failure),
      (mealsResponse) => Right(
        mealsResponse.meals
            .map(
              (meal) => MealsSearchByName(
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
}
