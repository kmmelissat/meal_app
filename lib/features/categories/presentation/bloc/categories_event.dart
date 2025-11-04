abstract class CategoriesEvent {}

class LoadCategoriesEvent extends CategoriesEvent {}

class SearchCategoriesEvent extends CategoriesEvent {
  final String query;

  SearchCategoriesEvent(this.query);
}
