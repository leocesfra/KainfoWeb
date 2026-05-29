import 'package:flutter/material.dart';
import '../data/models/product_model.dart';
import '../data/repositories/product_repository.dart';

// Manejo de errores
enum ViewState { initial, loading, loaded, error }

class ProductViewModel extends ChangeNotifier {
  final ProductRepository _repository;

  ProductViewModel(this._repository);

  List<ProductModel> _products = [];
  List<ProductModel> _allProducts = [];
  ViewState _state = ViewState.initial;
  Set<String> activeFilters = {};
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
      _allProducts = List.from(_products);
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

  // --- VARIABLES DE PAGINACIÓN ---
  int _currentPage = 1;
  final int _itemsPerPage = 20;

  int get currentPage => _currentPage;
  int get totalPages => (_products.length / _itemsPerPage).ceil() == 0
      ? 1
      : (_products.length / _itemsPerPage).ceil();

  List<ProductModel> get paginatedProducts {
    int start = (_currentPage - 1) * _itemsPerPage;
    return _products.skip(start).take(_itemsPerPage).toList();
  }

  void setPage(int page) {
    if (page >= 1 && page <= totalPages) {
      _currentPage = page;
      notifyListeners();
    }
  }

  // --- EXTRACCIÓN DINÁMICA ---
  List<String> get availableBrands =>
      _products.map((p) => p.brand.name).toSet().toList();

  Map<String, Set<String>> get availableFilters {
    Map<String, Set<String>> filters = {};
    for (var product in _products) {
      product.specifications.forEach((key, value) {
        if (!filters.containsKey(key)) filters[key] = {};
        filters[key]!.add(value.toString());
      });
    }
    return filters;
  }

  // --- ORDENACIÓN LOCAL ---
  void sortProducts(String criteria) {
    switch (criteria) {
      case 'Novedades':
        _products.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        break;
      case 'Precio ascendente':
        _products.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'Precio descendente':
        _products.sort((a, b) => b.price.compareTo(a.price));
        break;
      case 'A-Z':
        _products.sort((a, b) => a.name.compareTo(b.name));
        break;
      case 'Z-A':
        _products.sort((a, b) => b.name.compareTo(a.name));
        break;
    }
    _currentPage = 1; // Resetea paginación al ordenar
    notifyListeners();
  }

  void applyLocalFilters(Set<String> selectedFilters) {
    activeFilters = Set.from(selectedFilters);
    if (selectedFilters.isEmpty) {
      clearFilters();
      return;
    }

    _products = _allProducts.where((p) {
      // Coincide marca
      bool brandMatch = selectedFilters.contains(p.brand.name);
      // Coincide alguna especificación
      bool specMatch = p.specifications.values.any(
        (val) => selectedFilters.contains(val.toString()),
      );

      return brandMatch || specMatch;
    }).toList();

    _currentPage = 1;
    notifyListeners();
  }

  void clearFilters() {
    activeFilters.clear();
    _products = List.from(_allProducts);
    _currentPage = 1;
    notifyListeners();
  }
}
