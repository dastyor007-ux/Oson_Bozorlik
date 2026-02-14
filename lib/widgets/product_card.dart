import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../l10n/app_strings.dart';
import '../models/product_model.dart';
import '../providers/cart_provider.dart';
import '../providers/favorites_provider.dart';
import '../theme/app_theme.dart';
import 'app_image.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  final VoidCallback? onTap;

  const ProductCard({super.key, required this.product, this.onTap});

  @override
  Widget build(BuildContext context) {
    final isOutOfStock = !product.isAvailable;

    return Consumer2<CartProvider, FavoritesProvider>(
      builder: (context, cart, favorites, child) {
        final quantity = cart.getQuantity(product.id);
        final step = product.unit == 'кг' ? 0.5 : 1.0;
        final isFavorite = favorites.isFavorite(product.id);
        final strings = context.strings;

        String quantityLabel() {
          return strings.quantityLabel(quantity, product.unit);
        }

        String totalLabel() {
          final total = (product.price * quantity).toInt();
          return '$total SOM';
        }

        void increment() {
          if (!product.isAvailable) return;
          cart.setItem(product, quantity + step);
        }

        void decrement() {
          if (quantity <= 0) return;
          if (quantity <= step) {
            _showRemoveDialog(context, product, cart);
          } else {
            cart.setItem(product, quantity - step);
          }
        }

        return GestureDetector(
          onTap: onTap,
          child: Opacity(
            opacity: isOutOfStock ? 0.5 : 1.0,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
                border: Border.all(
                  color: AppColors.lightGreen.withValues(alpha: 0.2),
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
                        Hero(
                          tag: 'product_image_${product.id}',
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: AppColors.paleGreen.withValues(alpha: 0.5),
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),
                            ),
                            child: AppImage(
                              path: product.imagePath,
                              fit: BoxFit.cover,
                              placeholder: Center(
                                child: Icon(
                                  _getCategoryIcon(product.categoryId),
                                  size: 48,
                                  color: AppColors.accentGreen.withValues(
                                    alpha: 0.4,
                                  ),
                                ),
                              ),
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
                                strings.t('outOfStock'),
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.red.shade400,
                                ),
                              ),
                            ),
                          ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: GestureDetector(
                            onTap: () {
                              favorites.toggleFavorite(product.id);
                            },
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                color: AppColors.white.withValues(alpha: 0.92),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.08),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Icon(
                                isFavorite
                                    ? Icons.favorite_rounded
                                    : Icons.favorite_border_rounded,
                                size: 17,
                                color: isFavorite
                                    ? Colors.red.shade400
                                    : AppColors.darkGreen,
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
                            strings.productName(product),
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
                            '${product.price.toInt()} SOM / ${strings.unitWithOne(product.unit)}',
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
                                '${quantityLabel()} · ${totalLabel()}',
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
                                onTap: quantity > 0 && !isOutOfStock
                                    ? decrement
                                    : null,
                              ),
                              Expanded(
                                child: Center(
                                  child: Text(
                                    quantityLabel(),
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: quantity > 0
                                          ? AppColors.textPrimary
                                          : AppColors.textSecondary,
                                    ),
                                  ),
                                ),
                              ),
                              _buildQuantityButton(
                                icon: Icons.add,
                                onTap: !isOutOfStock ? increment : null,
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
      },
    );
  }

  void _showRemoveDialog(
    BuildContext context,
    ProductModel product,
    CartProvider cart,
  ) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          context.strings.t('removeProductTitle'),
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        content: Text(
          context.strings.tr('removeProductMessage', {
            'name': context.strings.productName(product),
          }),
          style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(
              context.strings.t('cancel'),
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              cart.removeItem(product.id);
              Navigator.of(ctx).pop();
            },
            child: Text(
              context.strings.t('yes'),
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.red.shade400,
              ),
            ),
          ),
        ],
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
                    : AppColors.accentGreen.withValues(alpha: 0.15))
              : AppColors.divider.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          icon,
          size: 16,
          color: isEnabled
              ? (isPrimary ? AppColors.white : AppColors.darkGreen)
              : AppColors.textSecondary.withValues(alpha: 0.4),
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
      case 'meat':
        return Icons.set_meal_outlined;
      case 'sausage':
        return Icons.lunch_dining_outlined;
      case 'hygiene':
        return Icons.cleaning_services_outlined;
      case 'drinks':
        return Icons.local_drink_outlined;
      case 'snacks':
        return Icons.fastfood_outlined;
      default:
        return Icons.shopping_basket_outlined;
    }
  }
}
