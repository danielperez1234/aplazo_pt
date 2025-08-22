import 'package:aplazo_pt/core/utils/storage_keys.dart';
import 'package:aplazo_pt/features/details/domain/entities/meals_details_category.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/usecases/get_meal_details.dart';

part 'details_event.dart';
part 'details_state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  final GetMealDetailsUseCase _getMealDetailsUseCase;

  // Mantenemos el mapa internamente para cachear los resultados
  List<String> mealsFav = [];

  DetailsBloc(this._getMealDetailsUseCase) : super(const DetailsInitial()) {
    on<GetMealDetailsEvent>(_getMealDetailsHandler);
    on<MealFavouritePressdEvent>(_mealFavouritePressdHandler);
  }

  Future<void> _getMealDetailsHandler(
    GetMealDetailsEvent event,
    Emitter<DetailsState> emit,
  ) async {
    emit(DetailsLoading());
    final storage = await SharedPreferences.getInstance();
    mealsFav = storage.getStringList(StorageKeys.mealsFav) ?? [];
    final result = await _getMealDetailsUseCase(event.idMeal);
    print(mealsFav);
    result.fold((failure) => emit(DetailsError(failure.message)), (meals) {
      emit(DetailsLoaded(meals));
    });
  }

  Future<void> _mealFavouritePressdHandler(
    MealFavouritePressdEvent event,
    Emitter<DetailsState> emit,
  ) async {
    if (mealsFav.contains(event.idMeal)) {
      mealsFav.remove(event.idMeal);
    } else {
      mealsFav.add(event.idMeal);
    }
    print(mealsFav);
    final storage = await SharedPreferences.getInstance();
    storage.setStringList(StorageKeys.mealsFav, mealsFav);
  }
}
