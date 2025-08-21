import 'package:aplazo_pt/core/usecase/usecase.dart';
import 'package:aplazo_pt/core/utils/typedefs.dart';

import '../entities/meals_search_by_category.dart';
import '../repositories/home_repository.dart';

class GetMealsByCategoryUseCase
    implements UseCaseWithParams<List<MealsSearchByCategory>, String> {
  final HomeRepository _homeRepository;

  GetMealsByCategoryUseCase(this._homeRepository);

  @override
  ResultFuture<List<MealsSearchByCategory>> call(String params) async {
    return await _homeRepository.getMealsByCategory(params);
  }
}
