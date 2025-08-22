part of 'details_bloc.dart';

sealed class DetailsEvent extends Equatable {
  const DetailsEvent();

  @override
  List<Object> get props => [];
}

class GetMealDetailsEvent extends DetailsEvent {
  final String idMeal;

  const GetMealDetailsEvent(this.idMeal);

  @override
  List<Object> get props => [idMeal];
}

class MealFavouritePressdEvent extends DetailsEvent {
  final String idMeal;

  const MealFavouritePressdEvent(this.idMeal);

  @override
  List<Object> get props => [idMeal];
}
