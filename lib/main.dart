import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/categories/data/datasources/category_remote_datasource.dart';
import 'features/categories/presentation/bloc/categories_bloc.dart';
import 'features/categories/presentation/bloc/categories_event.dart';
import 'features/categories/presentation/categories_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize Dio
    final dio = Dio();

    // Initialize DataSource
    final categoryRemoteDataSource = CategoryRemoteDataSource(dio: dio);

    return MaterialApp(
      title: 'Meal Finder',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: BlocProvider(
        create: (context) => CategoriesBloc(
          remoteDataSource: categoryRemoteDataSource,
        )..add(LoadCategoriesEvent()),
        child: const CategoriesScreen(),
      ),
    );
  }
}
