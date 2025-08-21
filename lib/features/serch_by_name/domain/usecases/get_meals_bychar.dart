import 'package:aplazo_pt/core/usecase/usecase.dart';
import 'package:aplazo_pt/core/utils/typedefs.dart';
import 'package:aplazo_pt/features/serch_by_name/domain/entities/meals_search_by_name.dart';
import 'package:aplazo_pt/features/serch_by_name/domain/repositories/search_by_name_repository.dart';

class GetMealsByCharUseCase
    implements UseCaseWithParams<List<MealsSearchByName>, String> {
  final SearchByNameRepository _searchByNameRepository;

  GetMealsByCharUseCase(this._searchByNameRepository);

  @override
  ResultFuture<List<MealsSearchByName>> call(String params) async {
    return await _searchByNameRepository.getMealsByChar(params);
  }
}
