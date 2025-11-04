abstract class MealDetailEvent {}

class LoadMealDetailEvent extends MealDetailEvent {
  final String mealId;

  LoadMealDetailEvent(this.mealId);
}

