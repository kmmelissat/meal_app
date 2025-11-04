import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/datasources/meal_remote_datasource.dart';
import 'meals_event.dart';
import 'meals_state.dart';

class MealsBloc extends Bloc<MealsEvent, MealsState> {
  final MealRemoteDataSource remoteDataSource;

  MealsBloc({required this.remoteDataSource}) : super(MealsInitial()) {
    on<LoadMealsByCategoryEvent>(_onLoadMealsByCategory);
  }

  Future<void> _onLoadMealsByCategory(
    LoadMealsByCategoryEvent event,
    Emitter<MealsState> emit,
  ) async {
    emit(MealsLoading());
    try {
      final meals = await remoteDataSource.getMealsByCategory(event.category);
      emit(MealsLoaded(meals: meals, category: event.category));
    } catch (e) {
      emit(MealsError(e.toString()));
    }
  }
}

