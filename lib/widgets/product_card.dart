import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../theme/app_theme.dart';

class ProductCard extends StatefulWidget {
  final ProductModel product;
  final VoidCallback? onTap;

  const ProductCard({super.key, required this.product, this.onTap});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  double _quantity = 0;

  double get _step => widget.product.unit == 'кг' ? 0.5 : 1.0;

  String get _quantityLabel {
    if (widget.product.unit == 'кг') {
      if (_quantity < 1) {
        return '${(_quantity * 1000).toInt()} г';
      }
      return '${_quantity.toStringAsFixed(_quantity == _quantity.roundToDouble() ? 0 : 1)} кг';
    }
    return '${_quantity.toInt()} ${widget.product.unit}';
  }

  String get _totalLabel {
    final total = (widget.product.price * _quantity).toInt();
    return '$total SOM';
  }

  void _increment() {
    if (!widget.product.isAvailable) return;
    setState(() => _quantity += _step);
  }

  void _decrement() {
    if (_quantity <= 0) return;
    setState(() {
      _quantity -= _step;
      if (_quantity < 0) _quantity = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isOutOfStock = !widget.product.isAvailable;

    return GestureDetector(
      onTap: widget.onTap,
      child: Opacity(
        opacity: isOutOfStock ? 0.5 : 1.0,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
            border: Border.all(
              color: AppColors.lightGreen.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product image
              Expanded(
                flex: 3,
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.paleGreen.withOpacity(0.5),
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          _getCategoryIcon(widget.product.categoryId),
                          size: 48,
                          color: AppColors.accentGreen.withOpacity(0.4),
                        ),
                      ),
                    ),
                    if (isOutOfStock)
                      Positioned(
                        top: 8,
                        left: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red.shade50,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'Нет в наличии',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: Colors.red.shade400,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              // Product info
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.product.name,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                          height: 1.2,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${widget.product.price.toInt()} SOM / ${widget.product.unit == 'кг' ? '1 кг' : widget.product.unit}',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: AppColors.darkGreen,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.paleGreen,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            '$_quantityLabel · $_totalLabel',
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: AppColors.darkGreen,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          _buildQuantityButton(
                            icon: Icons.remove,
                            onTap: _quantity > 0 && !isOutOfStock
                                ? _decrement
                                : null,
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                _quantityLabel,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: _quantity > 0
                                      ? AppColors.textPrimary
                                      : AppColors.textSecondary,
                                ),
                              ),
                            ),
                          ),
                          _buildQuantityButton(
                            icon: Icons.add,
                            onTap: !isOutOfStock ? _increment : null,
                            isPrimary: true,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuantityButton({
    required IconData icon,
    VoidCallback? onTap,
    bool isPrimary = false,
  }) {
    final isEnabled = onTap != null;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: isEnabled
              ? (isPrimary
                    ? AppColors.accentGreen
                    : AppColors.accentGreen.withOpacity(0.15))
              : AppColors.divider.withOpacity(0.3),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          icon,
          size: 16,
          color: isEnabled
              ? (isPrimary ? AppColors.white : AppColors.darkGreen)
              : AppColors.textSecondary.withOpacity(0.4),
        ),
      ),
    );
  }

  IconData _getCategoryIcon(String categoryId) {
    switch (categoryId) {
      case 'fruits':
        return Icons.shopping_bag_outlined;
      case 'vegetables':
        return Icons.eco_outlined;
      case 'dairy':
        return Icons.egg_outlined;
      case 'grains':
        return Icons.bakery_dining_outlined;
      case 'tea_coffee':
        return Icons.coffee_outlined;
      case 'hygiene':
        return Icons.cleaning_services_outlined;
      case 'drinks':
        return Icons.local_drink_outlined;
      default:
        return Icons.shopping_basket_outlined;
    }
  }
}
