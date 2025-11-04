import '../../data/models/category_model.dart';

abstract class CategoriesState {}

class CategoriesInitial extends CategoriesState {}

class CategoriesLoading extends CategoriesState {}

class CategoriesLoaded extends CategoriesState {
  final List<CategoryModel> categories;
  final List<CategoryModel> filteredCategories;

  CategoriesLoaded({
    required this.categories,
    required this.filteredCategories,
  });

  CategoriesLoaded copyWith({
    List<CategoryModel>? categories,
    List<CategoryModel>? filteredCategories,
  }) {
    return CategoriesLoaded(
      categories: categories ?? this.categories,
      filteredCategories: filteredCategories ?? this.filteredCategories,
    );
  }
}

class CategoriesError extends CategoriesState {
  final String message;

  CategoriesError(this.message);
}
