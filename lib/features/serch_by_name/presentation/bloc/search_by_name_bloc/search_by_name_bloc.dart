import 'package:aplazo_pt/features/serch_by_name/domain/entities/meals_search_by_name.dart';
import 'package:aplazo_pt/features/serch_by_name/domain/usecases/get_meals_bychar.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'search_by_name_event.dart';
part 'search_by_name_state.dart';

class SearchByNameBloc extends Bloc<SearchByNameEvent, SearchByNameState> {
  final GetMealsByCharUseCase _getMealsByCharUseCase;
  SearchByNameBloc(this._getMealsByCharUseCase) : super(SearchByNameInitial()) {
    on<GetMealsByNameEvent>(_getMealsByCharHandler);
  }

  Future<void> _getMealsByCharHandler(
    GetMealsByNameEvent event,
    Emitter<SearchByNameState> emit,
  ) async {
    try {
      emit(SearchByNameLoading());
      final result = await _getMealsByCharUseCase(event.char);
      result.fold(
        (failure) => emit(SearchByNameError(failure.message)),
        (meals) => emit(SearchByNameLoaded(meals)),
      );
    } catch (e) {
      emit(SearchByNameError("Error en la busqueda"));
    }
  }
}
