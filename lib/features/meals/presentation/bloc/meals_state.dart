import '../../data/models/meal_model.dart';

abstract class MealsState {}

class MealsInitial extends MealsState {}

class MealsLoading extends MealsState {}

class MealsLoaded extends MealsState {
  final List<MealModel> meals;
  final String category;

  MealsLoaded({required this.meals, required this.category});
}

class MealsError extends MealsState {
  final String message;

  MealsError(this.message);
}

