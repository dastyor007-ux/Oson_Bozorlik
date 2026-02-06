import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/cart_item_model.dart';
import '../models/product_model.dart';

class CartProvider extends ChangeNotifier {
  static const _storageKey = 'cart_items';

  final List<CartItemModel> _items = [];

  List<CartItemModel> get items => List.unmodifiable(_items);

  int get itemCount => _items.length;

  double get totalPrice => _items.fold(0, (sum, item) => sum + item.totalPrice);

  bool get hasUnavailableItems =>
      _items.any((item) => !item.product.isAvailable);

  bool get isEmpty => _items.isEmpty;

  double getQuantity(String productId) {
    final index = _items.indexWhere((item) => item.product.id == productId);
    return index >= 0 ? _items[index].quantity : 0;
  }

  // --- Load from local storage ---
  Future<void> loadCart() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString(_storageKey);
      if (jsonString == null) return;

      final List<dynamic> decoded = json.decode(jsonString);
      _items.clear();
      for (final itemJson in decoded) {
        final cartItem = CartItemModel.fromJson(
          itemJson as Map<String, dynamic>,
        );
        if (cartItem != null) {
          _items.add(cartItem);
        }
      }
      notifyListeners();
    } catch (e) {
      debugPrint('CartProvider.loadCart error: $e');
    }
  }

  // --- Save to local storage ---
  Future<void> _saveCart() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = json.encode(
        _items.map((item) => item.toJson()).toList(),
      );
      await prefs.setString(_storageKey, jsonString);
    } catch (e) {
      debugPrint('CartProvider._saveCart error: $e');
    }
  }

  void addItem(ProductModel product, {double? quantity}) {
    final index = _items.indexWhere((item) => item.product.id == product.id);
    if (index >= 0) {
      final step = product.unit == 'кг' ? 0.5 : 1.0;
      _items[index].quantity += quantity ?? step;
    } else {
      final step = product.unit == 'кг' ? 0.5 : 1.0;
      _items.add(CartItemModel(product: product, quantity: quantity ?? step));
    }
    notifyListeners();
    _saveCart();
  }

  void setItem(ProductModel product, double quantity) {
    final index = _items.indexWhere((item) => item.product.id == product.id);
    if (quantity <= 0) {
      if (index >= 0) {
        _items.removeAt(index);
      }
    } else if (index >= 0) {
      _items[index].quantity = quantity;
    } else {
      _items.add(CartItemModel(product: product, quantity: quantity));
    }
    notifyListeners();
    _saveCart();
  }

  void removeItem(String productId) {
    _items.removeWhere((item) => item.product.id == productId);
    notifyListeners();
    _saveCart();
  }

  void incrementItem(String productId) {
    final index = _items.indexWhere((item) => item.product.id == productId);
    if (index >= 0) {
      _items[index].quantity += _items[index].step;
      notifyListeners();
      _saveCart();
    }
  }

  void decrementItem(String productId) {
    final index = _items.indexWhere((item) => item.product.id == productId);
    if (index >= 0) {
      _items[index].quantity -= _items[index].step;
      if (_items[index].quantity <= 0) {
        _items.removeAt(index);
      }
      notifyListeners();
      _saveCart();
    }
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
    _saveCart();
  }
}
