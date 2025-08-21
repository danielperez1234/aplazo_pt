import 'package:aplazo_pt/core/utils/typedefs.dart';

import '../entities/meals_search_by_category.dart';

abstract class HomeRepository {
  const HomeRepository();

  ResultFuture<List<String>> getCategories(String char);
  ResultFuture<List<MealsSearchByCategory>> getMealsByCategory(String char);
}
