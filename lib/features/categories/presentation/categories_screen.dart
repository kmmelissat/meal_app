import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../meals/data/datasources/meal_remote_datasource.dart';
import '../../meals/presentation/bloc/meals_bloc.dart';
import '../../meals/presentation/bloc/meals_event.dart';
import '../../meals/presentation/meals_screen.dart';
import 'bloc/categories_bloc.dart';
import 'bloc/categories_event.dart';
import 'bloc/categories_state.dart';
import 'widgets/category_card.dart';
import 'widgets/search_bar_widget.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: CustomAppBar(
        title: 'Meal Finder',
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black87),
            onPressed: () {
              // Additional search action if needed
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          SearchBarWidget(
            hintText: 'Buscar categoría...',
            onChanged: (query) {
              context.read<CategoriesBloc>().add(SearchCategoriesEvent(query));
            },
          ),
          // Categories list
          Expanded(
            child: BlocBuilder<CategoriesBloc, CategoriesState>(
              builder: (context, state) {
                if (state is CategoriesLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is CategoriesLoaded) {
                  if (state.filteredCategories.isEmpty) {
                    return Center(
                      child: Text(
                        'No se encontraron categorías',
                        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                      ),
                    );
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.only(bottom: 16),
                    itemCount: state.filteredCategories.length,
                    itemBuilder: (context, index) {
                      final category = state.filteredCategories[index];
                      return CategoryCard(
                        category: category,
                        onTap: () {
                          // Navigate to meals screen for this category
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                create: (context) =>
                                    MealsBloc(
                                      remoteDataSource: MealRemoteDataSource(
                                        dio: Dio(),
                                      ),
                                    )..add(
                                      LoadMealsByCategoryEvent(
                                        category.strCategory,
                                      ),
                                    ),
                                child: MealsScreen(
                                  categoryName: category.strCategory,
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                } else if (state is CategoriesError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline,
                          size: 60,
                          color: Colors.red[300],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Error al cargar categorías',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[800],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          child: Text(
                            state.message,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton.icon(
                          onPressed: () {
                            context.read<CategoriesBloc>().add(
                              LoadCategoriesEvent(),
                            );
                          },
                          icon: const Icon(Icons.refresh),
                          label: const Text('Reintentar'),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
