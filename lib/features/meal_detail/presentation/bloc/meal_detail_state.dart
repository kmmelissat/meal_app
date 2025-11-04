import '../../data/models/meal_detail_model.dart';

abstract class MealDetailState {}

class MealDetailInitial extends MealDetailState {}

class MealDetailLoading extends MealDetailState {}

class MealDetailLoaded extends MealDetailState {
  final MealDetailModel meal;

  MealDetailLoaded(this.meal);
}

class MealDetailError extends MealDetailState {
  final String message;

  MealDetailError(this.message);
}

