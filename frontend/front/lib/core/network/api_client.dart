import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

class ApiClient {
  final http.Client _client;
  
  // URL base 
  final String baseUrl = 'http://localhost:8080/api';

  ApiClient({http.Client? client}) : _client = client ?? http.Client();

  // Método genérico para peticiones GET que devuelven una Lista
  Future<List<dynamic>> getJsonList(String endpoint, {Map<String, String>? queryParams}) async {
    final uri = Uri.parse('$baseUrl$endpoint').replace(queryParameters: queryParams);

    try {
      final response = await _client.get(
        uri,
        headers: {'Accept': 'application/json'},
      ).timeout(const Duration(seconds: 10)); // Timeout de los apuntes

      if (response.statusCode != 200) {
        throw Exception('Error en GET ${uri.path} -> ${response.statusCode}');
      }

      final decoded = jsonDecode(response.body);

      if (decoded is! List) {
        throw Exception('Se esperaba lista JSON, llegó: ${decoded.runtimeType}');
      }

      return decoded;
      
    } on TimeoutException {
      throw Exception('Tiempo de espera agotado conectando con el servidor');
    } catch (e) {
      throw Exception('Error de red: $e');
    }
  }
}