part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState({this.items = const []});
  final List<HomeListItem> items;

  @override
  List<Object> get props => [items];
}

final class HomeInitial extends HomeState {
  const HomeInitial() : super();
}

class HomeLoading extends HomeState {
  const HomeLoading({required super.items});
}

class HomeLoaded extends HomeState {
  const HomeLoaded({required super.items});

  @override
  List<Object> get props => [items];
}

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message, {required super.items});

  @override
  List<Object> get props => [message];
}
