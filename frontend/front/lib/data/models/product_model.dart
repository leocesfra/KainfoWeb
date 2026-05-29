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
  final String? primaryImageUrl;
  final List<String> galleryImages;

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
    required this.primaryImageUrl,
    required this.galleryImages,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    String? imageUrl;
    if (json['images'] != null && (json['images'] as List).isNotEmpty) {
      final images = json['images'] as List;
      final primary = images.firstWhere(
        (img) => img['isPrimary'] == true || img['is_primary'] == true,
        orElse: () => images.first,
      );
      imageUrl = primary['imageUrl'] ?? primary['image_url'];
    }

    List<String> allImages = [];
    if (json['images'] != null) {
      allImages = (json['images'] as List)
          .map((img) => (img['imageUrl'] ?? img['image_url']).toString())
          .toList();
    }

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
      primaryImageUrl: imageUrl,
      galleryImages: allImages.isNotEmpty ? allImages : [],
    );
  }
}
