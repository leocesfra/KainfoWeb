import 'brand_model.dart';
import 'category_model.dart';

class ProductModel {
  final int id;
  final String name;
  final String description;
  final double price;
  final int stock;
  final String sku;
  final DateTime createdAt;
  final BrandModel brand;
  final CategoryModel category;
  
  // ¡La magia de la flexibilidad!
  final Map<String, dynamic> specifications;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.stock,
    required this.sku,
    required this.createdAt,
    required this.brand,
    required this.category,
    required this.specifications,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: (json['price'] as num).toDouble(),
      stock: json['stock'],
      sku: json['sku'],
      createdAt: DateTime.parse(json['createdAt']),
      
      brand: BrandModel.fromJson(json['brand']),
      category: CategoryModel.fromJson(json['category']),
      
      // objeto JSON Mapa Dart
      specifications: Map<String, dynamic>.from(json['specifications'] ?? {}),
    );
  }
}