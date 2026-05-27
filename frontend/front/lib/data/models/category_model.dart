class CategoryModel {
  final int id;
  final String name;
  final CategoryModel? parentCategory; 

  CategoryModel({
    required this.id,
    required this.name,
    this.parentCategory,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'],
      parentCategory: json['parentCategory'] != null 
          ? CategoryModel.fromJson(json['parentCategory']) 
          : null,
    );
  }
}