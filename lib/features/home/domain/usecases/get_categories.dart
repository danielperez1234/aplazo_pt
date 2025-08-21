import 'package:aplazo_pt/core/usecase/usecase.dart';
import 'package:aplazo_pt/core/utils/typedefs.dart';

import '../repositories/home_repository.dart';

class GetCategoriesUseCase implements UseCaseWithoutParams<List<String>> {
  final HomeRepository _homeRepository;

  GetCategoriesUseCase(this._homeRepository);

  @override
  ResultFuture<List<String>> call() async {
    return await _homeRepository.getCategories();
  }
}
