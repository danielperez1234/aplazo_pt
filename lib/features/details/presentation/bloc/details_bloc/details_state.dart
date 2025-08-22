part of 'details_bloc.dart';

abstract class DetailsState extends Equatable {
  const DetailsState();

  @override
  List<Object> get props => [];
}

final class DetailsInitial extends DetailsState {
  const DetailsInitial() : super();
}

class DetailsLoading extends DetailsState {
  const DetailsLoading();
}

class DetailsLoaded extends DetailsState {
  const DetailsLoaded(this.meals);
  final MealDetails meals;
  @override
  List<Object> get props => [];
}

class DetailsError extends DetailsState {
  final String message;

  const DetailsError(this.message);

  @override
  List<Object> get props => [message];
}
