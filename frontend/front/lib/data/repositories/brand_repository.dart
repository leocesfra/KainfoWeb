import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/brand_model.dart';

class BrandRepository {
  // Asegúrate de que esta URL coincide con tu backend
  final String baseUrl = 'http://localhost:8080/api/brands'; 

  Future<List<BrandModel>> fetchBrands() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      // Usamos utf8.decode para que los acentos o caracteres especiales se lean bien
      final List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
      return data.map((json) => BrandModel.fromJson(json)).toList();
    } else {
      throw Exception('Error al cargar las marcas desde el servidor');
    }
  }
}