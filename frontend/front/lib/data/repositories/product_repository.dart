import '../models/product_model.dart';
import '../../core/network/api_client.dart';

class ProductRepository {
  final ApiClient api;

  ProductRepository(this.api);

  Future<List<ProductModel>> fetchAllProducts() async {
    final jsonList = await api.getJsonList('/products');
    
    return jsonList.map((json) => ProductModel.fromJson(json)).toList();
  }

  /// Obtiene productos filtrados por el "Embudo Híbrido" de Spring Boot
  Future<List<ProductModel>> fetchFilteredProducts({
    String? categoryId,
    String? brandId,
    String? minPrice,
    String? maxPrice,
    Map<String, String>? dynamicFilters,
  }) async {
    

    final queryParams = <String, String>{};
    
    if (categoryId != null) queryParams['categoryId'] = categoryId;
    if (brandId != null) queryParams['brandId'] = brandId;
    if (minPrice != null) queryParams['minPrice'] = minPrice;
    if (maxPrice != null) queryParams['maxPrice'] = maxPrice;

    if (dynamicFilters != null) {
      queryParams.addAll(dynamicFilters);
    }

    final jsonList = await api.getJsonList('/products/search', queryParams: queryParams);

    return jsonList.map((json) => ProductModel.fromJson(json)).toList();
  }
}