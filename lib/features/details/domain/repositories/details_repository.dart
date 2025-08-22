import 'package:aplazo_pt/core/utils/typedefs.dart';

import '../entities/meals_details_category.dart';

abstract class DetailsRepository {
  const DetailsRepository();

  ResultFuture<MealDetails> getMealById(String idMeal);
}
