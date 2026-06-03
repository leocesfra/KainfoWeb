import 'package:flutter/material.dart';
import '../data/models/brand_model.dart';
import '../data/repositories/brand_repository.dart';

enum BrandViewState { initial, loading, loaded, error }

class BrandViewModel extends ChangeNotifier {
  final BrandRepository _repository;

  BrandViewModel(this._repository);

  List<BrandModel> _brands = [];
  BrandViewState _state = BrandViewState.initial;

  List<BrandModel> get brands => _brands;
  BrandViewState get state => _state;

  Future<void> fetchBrands() async {
    _state = BrandViewState.loading;
    notifyListeners();

    try {
      _brands = await _repository.fetchBrands();
      _state = BrandViewState.loaded;
    } catch (e) {
      _state = BrandViewState.error;
    }
    notifyListeners();
  }
}