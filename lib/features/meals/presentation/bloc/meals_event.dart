abstract class MealsEvent {}

class LoadMealsByCategoryEvent extends MealsEvent {
  final String category;

  LoadMealsByCategoryEvent(this.category);
}

