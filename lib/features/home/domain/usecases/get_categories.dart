import 'package:aplazo_pt/core/usecase/usecase.dart';
import 'package:aplazo_pt/core/utils/typedefs.dart';

import '../repositories/home_repository.dart';

class GetMealsByCategoryUseCase
    implements UseCaseWithParams<List<String>, String> {
  final HomeRepository _homeRepository;

  GetMealsByCategoryUseCase(this._homeRepository);

  @override
  ResultFuture<List<String>> call(String params) async {
    return await _homeRepository.getCategories(params);
  }
}
