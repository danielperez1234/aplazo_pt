import 'package:aplazo_pt/core/utils/typedefs.dart';
import 'package:aplazo_pt/features/serch_by_name/domain/entities/meals_search_by_name.dart';

abstract class SearchByNameRepository {
  const SearchByNameRepository();

  ResultFuture<List<MealsSearchByName>> getMealsByChar(String char);
}
