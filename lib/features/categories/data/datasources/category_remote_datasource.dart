import 'package:dio/dio.dart';
import '../../../../core/constants/api_constants.dart';
import '../models/category_model.dart';

class CategoryRemoteDataSource {
  final Dio dio;

  CategoryRemoteDataSource({required this.dio});

  Future<List<CategoryModel>> getCategories() async {
    try {
      final response = await dio.get(
        '${ApiConstants.baseUrl}${ApiConstants.categoriesEndpoint}',
      );

      if (response.statusCode == 200) {
        final List<dynamic> categoriesJson = response.data['categories'];
        return categoriesJson
            .map((json) => CategoryModel.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      throw Exception('Error fetching categories: $e');
    }
  }
}
