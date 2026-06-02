import 'package:flutter/material.dart';
import '../../data/models/product_model.dart';
import '../../views/screens/home.dart';
import '../../views/screens/catalog.dart';
import '../../views/screens/product_detail.dart';
import '../../views/screens/login.dart'; // O login_screen.dart según como lo llamaras
import '../../views/screens/admin_home.dart';
import '../../views/screens/admin_add_product.dart';

class AppRoutes {
  // Nombres de las rutas (URLs)
  static const String home = '/';
  static const String catalog = '/catalog';
  static const String productDetail = '/product_detail';
  static const String login = '/login';
  static const String adminHome = '/admin_home';
  static const String adminAddProduct = '/admin_add_producto';

  // Generador de rutas
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      
      case adminHome:
        return MaterialPageRoute(builder: (_) => const AdminHomeScreen());
      
      case catalog:
        // Recibe los argumentos como un Mapa
        final args = settings.arguments as Map<String, String>;
        return MaterialPageRoute(
          builder: (_) => CatalogScreen(
            categoryId: args['categoryId']!,
            categoryName: args['categoryName']!,
          ),
        );
      
      case productDetail:
        // Recibe el objeto ProductModel completo
        final product = settings.arguments as ProductModel;
        return MaterialPageRoute(
          builder: (_) => ProductDetailScreen(product: product),
        );
      
      case adminAddProduct:
        // Puede recibir null (crear) o un producto (editar)
        final product = settings.arguments as ProductModel?;
        return MaterialPageRoute(
          builder: (_) => AdminProductAddScreen(productToEdit: product),
        );
      
      default:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
    }
  }
}