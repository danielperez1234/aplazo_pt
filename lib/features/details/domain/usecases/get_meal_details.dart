import 'package:aplazo_pt/core/usecase/usecase.dart';
import 'package:aplazo_pt/core/utils/typedefs.dart';

import '../entities/meals_details_category.dart';
import '../repositories/details_repository.dart';

class GetMealDetailsUseCase implements UseCaseWithParams<MealDetails, String> {
  final DetailsRepository _detailsRepository;

  GetMealDetailsUseCase(this._detailsRepository);

  @override
  ResultFuture<MealDetails> call(String params) async {
    return await _detailsRepository.getMealById(params);
  }
}
