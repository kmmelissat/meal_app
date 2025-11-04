import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/datasources/category_remote_datasource.dart';
import 'categories_event.dart';
import 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final CategoryRemoteDataSource remoteDataSource;

  CategoriesBloc({required this.remoteDataSource})
      : super(CategoriesInitial()) {
    on<LoadCategoriesEvent>(_onLoadCategories);
    on<SearchCategoriesEvent>(_onSearchCategories);
  }

  Future<void> _onLoadCategories(
    LoadCategoriesEvent event,
    Emitter<CategoriesState> emit,
  ) async {
    emit(CategoriesLoading());
    try {
      final categories = await remoteDataSource.getCategories();
      emit(CategoriesLoaded(
        categories: categories,
        filteredCategories: categories,
      ));
    } catch (e) {
      emit(CategoriesError(e.toString()));
    }
  }

  void _onSearchCategories(
    SearchCategoriesEvent event,
    Emitter<CategoriesState> emit,
  ) {
    if (state is CategoriesLoaded) {
      final currentState = state as CategoriesLoaded;
      if (event.query.isEmpty) {
        emit(currentState.copyWith(
          filteredCategories: currentState.categories,
        ));
      } else {
        final filtered = currentState.categories
            .where((category) => category.strCategory
                .toLowerCase()
                .contains(event.query.toLowerCase()))
            .toList();
        emit(currentState.copyWith(filteredCategories: filtered));
      }
    }
  }
}

