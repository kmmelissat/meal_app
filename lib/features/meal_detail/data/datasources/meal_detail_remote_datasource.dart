import 'package:dio/dio.dart';
import '../../../../core/constants/api_constants.dart';
import '../models/meal_detail_model.dart';

class MealDetailRemoteDataSource {
  final Dio dio;

  MealDetailRemoteDataSource({required this.dio});

  Future<MealDetailModel> getMealById(String mealId) async {
    try {
      final response = await dio.get(
        '${ApiConstants.baseUrl}${ApiConstants.lookupByIdEndpoint}',
        queryParameters: {'i': mealId},
      );

      if (response.statusCode == 200) {
        final List<dynamic> mealsJson = response.data['meals'] ?? [];
        if (mealsJson.isEmpty) {
          throw Exception('Meal not found');
        }
        return MealDetailModel.fromJson(mealsJson[0]);
      } else {
        throw Exception('Failed to load meal details');
      }
    } catch (e) {
      throw Exception('Error fetching meal details: $e');
    }
  }
}

