import 'package:aplazo_pt/features/details/domain/entities/meals_details_category.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/usecases/get_meal_details.dart';

part 'details_event.dart';
part 'details_state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  final GetMealDetailsUseCase _getMealDetailsUseCase;

  // Mantenemos el mapa internamente para cachear los resultados
  List<String> _mealsFav = [];

  DetailsBloc(this._getMealDetailsUseCase) : super(const DetailsInitial()) {
    on<GetMealDetailsEvent>(_getMealDetailsHandler);
  }

  Future<void> _getMealDetailsHandler(
    GetMealDetailsEvent event,
    Emitter<DetailsState> emit,
  ) async {
    emit(DetailsLoading());
    final result = await _getMealDetailsUseCase(event.idMeal);

    result.fold((failure) => emit(DetailsError(failure.message)), (meals) {
      emit(DetailsLoaded(meals));
    });
  }
}
