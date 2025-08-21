import 'package:aplazo_pt/features/home/domain/entities/meals_search_by_category.dart';
import 'package:equatable/equatable.dart';

sealed class HomeListItem extends Equatable {
  const HomeListItem();
}

class HomeCategoryItem extends HomeListItem {
  final String category;

  const HomeCategoryItem(this.category);

  @override
  List<Object?> get props => [category];
}

class HomeMealItem extends HomeListItem {
  final MealsSearchByCategory meal;

  const HomeMealItem(this.meal);

  @override
  List<Object?> get props => [meal];
}
