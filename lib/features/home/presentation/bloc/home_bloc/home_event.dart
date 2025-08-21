part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class GetMealsByCategoryEvent extends HomeEvent {
  final String category;

  const GetMealsByCategoryEvent(this.category);

  @override
  List<Object> get props => [category];
}

class GetCategoriesEvent extends HomeEvent {
  const GetCategoriesEvent();

  @override
  List<Object> get props => [];
}
