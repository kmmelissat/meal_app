import 'package:dio/dio.dart';
import '../../../../core/constants/api_constants.dart';
import '../models/meal_model.dart';

class MealRemoteDataSource {
  final Dio dio;

  MealRemoteDataSource({required this.dio});

  Future<List<MealModel>> getMealsByCategory(String category) async {
    try {
      final response = await dio.get(
        '${ApiConstants.baseUrl}${ApiConstants.filterByCategoryEndpoint}',
        queryParameters: {'c': category},
      );

      if (response.statusCode == 200) {
        final List<dynamic> mealsJson = response.data['meals'] ?? [];
        return mealsJson.map((json) => MealModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load meals');
      }
    } catch (e) {
      throw Exception('Error fetching meals: $e');
    }
  }
}

