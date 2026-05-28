import 'package:flutter/material.dart';
import '../data/models/category_model.dart';
import '../data/repositories/category_repository.dart';

enum CategoryViewState { initial, loading, loaded, error }

class CategoryViewModel extends ChangeNotifier {
  final CategoryRepository _repository;

  CategoryViewModel(this._repository);

  List<CategoryModel> _categories = [];
  CategoryViewState _state = CategoryViewState.initial;
  String _errorMessage = '';

  List<CategoryModel> get categories => _categories;
  CategoryViewState get state => _state;
  String get errorMessage => _errorMessage;

  Future<void> fetchCategories() async {
    _state = CategoryViewState.loading;
    notifyListeners();
    
    try {
      _categories = await _repository.fetchRootCategories();
      _state = CategoryViewState.loaded;
    } catch (e) {
      _errorMessage = e.toString();
      _state = CategoryViewState.error;
    }
    notifyListeners();
  }
}