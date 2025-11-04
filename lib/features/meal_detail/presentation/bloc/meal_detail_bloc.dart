import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/datasources/meal_detail_remote_datasource.dart';
import 'meal_detail_event.dart';
import 'meal_detail_state.dart';

class MealDetailBloc extends Bloc<MealDetailEvent, MealDetailState> {
  final MealDetailRemoteDataSource remoteDataSource;

  MealDetailBloc({required this.remoteDataSource})
      : super(MealDetailInitial()) {
    on<LoadMealDetailEvent>(_onLoadMealDetail);
  }

  Future<void> _onLoadMealDetail(
    LoadMealDetailEvent event,
    Emitter<MealDetailState> emit,
  ) async {
    emit(MealDetailLoading());
    try {
      final meal = await remoteDataSource.getMealById(event.mealId);
      emit(MealDetailLoaded(meal));
    } catch (e) {
      emit(MealDetailError(e.toString()));
    }
  }
}

