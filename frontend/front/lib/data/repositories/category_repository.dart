import '../models/category_model.dart';
import '../../core/network/api_client.dart';

class CategoryRepository {
  final ApiClient api;

  CategoryRepository(this.api);

  Future<List<CategoryModel>> fetchRootCategories() async {
    final jsonList = await api.getJsonList('/categories/roots');
    return jsonList.map((json) => CategoryModel.fromJson(json)).toList();
  }
}