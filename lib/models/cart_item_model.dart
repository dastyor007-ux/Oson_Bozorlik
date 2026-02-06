import 'product_model.dart';

class CartItemModel {
  final ProductModel product;
  double quantity; // in kg or units

  CartItemModel({required this.product, required this.quantity});

  double get step => product.unit == 'кг' ? 0.5 : 1.0;

  double get totalPrice => product.price * quantity;

  String get quantityLabel {
    if (product.unit == 'кг') {
      if (quantity < 1) {
        return '${(quantity * 1000).toInt()} г';
      }
      return '${quantity.toStringAsFixed(quantity == quantity.roundToDouble() ? 0 : 1)} кг';
    }
    return '${quantity.toInt()} ${product.unit}';
  }

  Map<String, dynamic> toJson() => {
    'productId': product.id,
    'quantity': quantity,
  };

  static CartItemModel? fromJson(Map<String, dynamic> json) {
    final product = ProductModel.findById(json['productId'] as String);
    if (product == null) return null;
    return CartItemModel(
      product: product,
      quantity: (json['quantity'] as num).toDouble(),
    );
  }
}
