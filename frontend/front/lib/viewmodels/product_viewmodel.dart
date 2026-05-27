import 'package:flutter/material.dart';
import '../data/models/product_model.dart';
import '../data/repositories/product_repository.dart';

// Manejo de errores
enum ViewState { initial, loading, loaded, error }

class ProductViewModel extends ChangeNotifier {
  final ProductRepository _repository;

  ProductViewModel(this._repository);

  List<ProductModel> _products = [];
  ViewState _state = ViewState.initial;
  String _errorMessage = '';

  // Getters 
  List<ProductModel> get products => _products;
  ViewState get state => _state;
  String get errorMessage => _errorMessage;

  /// Método pacargar los productos (Llamado desde la UI)
  Future<void> fetchProducts() async {
    _setState(ViewState.loading);
    
    try {
      // 1. Pedimos los datos al repositorio
      _products = await _repository.fetchAllProducts();
      // 2. Si todo va bien, cambiamos a estado loaded
      _setState(ViewState.loaded);
    } catch (e) {
      // 3. Si hay un error, lo guardamos y cambiamos a estado error
      _errorMessage = e.toString();
      _setState(ViewState.error);
    }
  }

  /// Método para aplicar los filtros
  Future<void> applyFilters({
    String? categoryId,
    String? brandId,
    String? minPrice,
    String? maxPrice,
    Map<String, String>? dynamicFilters,
  }) async {
    _setState(ViewState.loading);
    
    try {
      _products = await _repository.fetchFilteredProducts(
        categoryId: categoryId,
        brandId: brandId,
        minPrice: minPrice,
        maxPrice: maxPrice,
        dynamicFilters: dynamicFilters,
      );
      _setState(ViewState.loaded);
    } catch (e) {
      _errorMessage = e.toString();
      _setState(ViewState.error);
    }
  }

  // Método para cambiar estado y avisar a la UI
  void _setState(ViewState newState) {
    _state = newState;
    notifyListeners(); 
  }
}