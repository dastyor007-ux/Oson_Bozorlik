import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/product_model.dart';

class FavoritesProvider extends ChangeNotifier {
  static const _storageKey = 'favorite_product_ids';

  final Set<String> _favoriteIds = <String>{};

  Set<String> get favoriteIds => Set.unmodifiable(_favoriteIds);

  List<ProductModel> get favoriteProducts {
    return _favoriteIds
        .map(ProductModel.findById)
        .whereType<ProductModel>()
        .toList();
  }

  bool isFavorite(String productId) => _favoriteIds.contains(productId);

  Future<void> loadFavorites() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final ids = prefs.getStringList(_storageKey) ?? const [];
      _favoriteIds
        ..clear()
        ..addAll(ids);
      notifyListeners();
    } catch (e) {
      debugPrint('FavoritesProvider.loadFavorites error: $e');
    }
  }

  Future<void> _saveFavorites() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(_storageKey, _favoriteIds.toList());
    } catch (e) {
      debugPrint('FavoritesProvider._saveFavorites error: $e');
    }
  }

  void toggleFavorite(String productId) {
    if (_favoriteIds.contains(productId)) {
      _favoriteIds.remove(productId);
    } else {
      _favoriteIds.add(productId);
    }
    notifyListeners();
    _saveFavorites();
  }
}
