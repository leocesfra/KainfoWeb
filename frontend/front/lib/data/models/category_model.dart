class CategoryModel {
  final int id;
  final String name;
  final List<CategoryModel> subCategories;

  CategoryModel({
    required this.id,
    required this.name,
    required this.subCategories,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'],
      // Mapeamos los hijos recursivamente
      subCategories: json['subCategories'] != null
          ? (json['subCategories'] as List)
              .map((i) => CategoryModel.fromJson(i))
              .toList()
          : [],
    );
  }
}