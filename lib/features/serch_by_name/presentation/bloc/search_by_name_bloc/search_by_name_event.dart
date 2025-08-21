part of 'search_by_name_bloc.dart';

sealed class SearchByNameEvent extends Equatable {
  const SearchByNameEvent();

  @override
  List<Object> get props => [];
}

class GetMealsByNameEvent extends SearchByNameEvent {
  final String char;

  const GetMealsByNameEvent(this.char);

  @override
  List<Object> get props => [char];
}
