import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/usecases/get_categories.dart';
import '../../../domain/usecases/get_meals_by_category.dart';
import '../../../domain/entities/home_list_item.dart';
import '../../../domain/entities/meals_search_by_category.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetCategoriesUseCase _getCategoriesUseCase;
  final GetMealsByCategoryUseCase _getMealsByCategoryUseCase;

  // Caché de platillos por categoría para evitar solicitudes de red redundantes.
  Map<String, List<MealsSearchByCategory>> _mealsData = {};

  HomeBloc(this._getMealsByCategoryUseCase, this._getCategoriesUseCase)
    : super(const HomeInitial()) {
    on<GetCategoriesEvent>(_getCategoriesHandler);
    on<GetMealsByCategoryEvent>(_getMealsByCategoryHandler);
  }

  /// Convierte el mapa de datos en una lista plana para la UI.
  List<HomeListItem> _generateItemsFromData() {
    final items = <HomeListItem>[];
    _mealsData.forEach((category, meals) {
      items.add(HomeCategoryItem(category));
      items.addAll(meals.map((meal) => HomeMealItem(meal)));
    });
    return items;
  }

  Future<void> _getMealsByCategoryHandler(
    GetMealsByCategoryEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading(items: state.items));
    final result = await _getMealsByCategoryUseCase(event.category);
    result.fold(
      (failure) => emit(HomeError(failure.message, items: state.items)),
      (meals) {
        // Actualiza el caché con los platillos de la categoría solicitada.
        _mealsData[event.category] = meals;
        emit(HomeLoaded(items: _generateItemsFromData()));
      },
    );
  }

  Future<void> _getCategoriesHandler(
    GetCategoriesEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(const HomeLoading(items: []));
    final result = await _getCategoriesUseCase();
    result.fold(
      (failure) => emit(HomeError(failure.message, items: state.items)),
      (categories) {
        // Inicializa el mapa de caché con las categorías obtenidas.
        _mealsData = {for (var category in categories) category: []};
        emit(HomeLoaded(items: _generateItemsFromData()));
      },
    );
  }
}
