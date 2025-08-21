part of 'search_by_name_bloc.dart';

sealed class SearchByNameState extends Equatable {
  const SearchByNameState();

  @override
  List<Object> get props => [];
}

final class SearchByNameInitial extends SearchByNameState {}

class SearchByNameLoading extends SearchByNameState {}

class SearchByNameLoaded extends SearchByNameState {
  final List<MealsSearchByName> meals;

  const SearchByNameLoaded(this.meals);

  @override
  List<Object> get props => [meals];
}

class SearchByNameError extends SearchByNameState {
  final String message;

  const SearchByNameError(this.message);

  @override
  List<Object> get props => [message];
}
