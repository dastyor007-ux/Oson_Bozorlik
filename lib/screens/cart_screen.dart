import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../l10n/app_strings.dart';
import '../models/cart_item_model.dart';
import '../providers/cart_provider.dart';
import '../theme/app_theme.dart';
import 'checkout_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Consumer<CartProvider>(
        builder: (context, cart, child) {
          return Column(
            children: [
              _buildAppBar(context, cart),
              Expanded(
                child: cart.isEmpty
                    ? _buildEmptyState(context)
                    : _buildCartList(cart),
              ),
              if (!cart.isEmpty) _buildBottomBar(context, cart),
            ],
          );
        },
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, CartProvider cart) {
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: SizedBox(
        height: 56,
        child: Row(
          children: [
            const SizedBox(width: 8),
            IconButton(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.accentGreen.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.lightGreen.withValues(alpha: 0.2),
                    width: 1,
                  ),
                ),
                child: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: AppColors.darkGreen,
                  size: 16,
                ),
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            Expanded(
              child: Text(
                context.strings.t('cart'),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                  letterSpacing: -0.3,
                ),
              ),
            ),
            if (!cart.isEmpty)
              IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.red.shade100, width: 1),
                  ),
                  child: Icon(
                    Icons.delete_outline_rounded,
                    color: Colors.red.shade400,
                    size: 18,
                  ),
                ),
                onPressed: () => _showClearCartDialog(context),
              )
            else
              const SizedBox(width: 48),
            const SizedBox(width: 8),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: AppColors.paleGreen,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.shopping_cart_outlined,
                  size: 48,
                  color: AppColors.accentGreen.withValues(alpha: 0.5),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                context.strings.t('cartEmptyTitle'),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                context.strings.t('cartEmptySubtitle'),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textSecondary.withValues(alpha: 0.7),
                ),
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(duration: 400.ms)
        .scale(
          begin: const Offset(0.9, 0.9),
          end: const Offset(1, 1),
          duration: 400.ms,
          curve: Curves.easeOut,
        );
  }

  Widget _buildCartList(CartProvider cart) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      physics: const BouncingScrollPhysics(),
      itemCount: cart.items.length,
      itemBuilder: (context, index) {
        final item = cart.items[index];
        return _CartItemCard(item: item, index: index);
      },
    );
  }

  Widget _buildBottomBar(BuildContext context, CartProvider cart) {
    final canCheckout = !cart.hasUnavailableItems;
    final strings = context.strings;
    final productTotal = cart.totalPrice.toInt();
    final deliveryFee = cart.deliveryFee;
    final total = cart.totalWithDelivery;
    final weightLabel = _formatWeight(context, cart.totalWeightKg);

    return Container(
      padding: EdgeInsets.fromLTRB(
        20,
        16,
        20,
        MediaQuery.of(context).padding.bottom + 16,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: AppColors.divider,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          // Info text
          _buildSummaryRow(
            '${strings.t('products')} (${cart.itemCount} ${strings.itemsWord(cart.itemCount)})',
            '$productTotal SOM',
          ),
          const SizedBox(height: 6),
          _buildSummaryRow(
            '${strings.t('delivery')} ($weightLabel)',
            '$deliveryFee SOM',
          ),
          const SizedBox(height: 10),
          _buildSummaryRow(strings.t('total'), '$total SOM', isTotal: true),
          if (cart.hasUnavailableItems) ...[
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.red.shade100),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.warning_amber_rounded,
                    size: 18,
                    color: Colors.red.shade400,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      strings.t('removeUnavailable'),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.red.shade600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: 14),
          // Checkout button
          SizedBox(
            width: double.infinity,
            height: 54,
            child: ElevatedButton(
              onPressed: canCheckout
                  ? () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const CheckoutScreen(),
                        ),
                      );
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accentGreen,
                disabledBackgroundColor: AppColors.divider,
                foregroundColor: AppColors.white,
                disabledForegroundColor: AppColors.textSecondary,
                elevation: canCheckout ? 4 : 0,
                shadowColor: AppColors.accentGreen.withValues(alpha: 0.4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text(
                strings.t('checkout'),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showClearCartDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          context.strings.t('clearCartTitle'),
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        content: Text(
          context.strings.t('clearCartMessage'),
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
              context.read<CartProvider>().clearCart();
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

  String _formatWeight(BuildContext context, double weightKg) {
    return context.strings.weightLabel(weightKg);
  }

  Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) {
    final valueStyle = isTotal
        ? const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: AppColors.darkGreen,
          )
        : TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.textSecondary.withValues(alpha: 0.9),
          );
    final labelStyle = isTotal
        ? const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          )
        : TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: AppColors.textSecondary.withValues(alpha: 0.9),
          );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: labelStyle),
        Text(value, style: valueStyle),
      ],
    );
  }
}

class _CartItemCard extends StatelessWidget {
  final CartItemModel item;
  final int index;

  const _CartItemCard({required this.item, required this.index});

  @override
  Widget build(BuildContext context) {
    final isOutOfStock = !item.product.isAvailable;
    final strings = context.strings;

    return Opacity(
          opacity: isOutOfStock ? 0.55 : 1.0,
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
              border: Border.all(
                color: isOutOfStock
                    ? Colors.red.shade100
                    : AppColors.lightGreen.withValues(alpha: 0.25),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                // Thumbnail
                Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    color: AppColors.paleGreen.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Stack(
                    children: [
                      Center(
                        child: Icon(
                          _getCategoryIcon(item.product.categoryId),
                          size: 32,
                          color: AppColors.accentGreen.withValues(alpha: 0.4),
                        ),
                      ),
                      if (isOutOfStock)
                        Positioned(
                          bottom: 4,
                          left: 4,
                          right: 4,
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.red.shade50,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              strings.t('outOfStock'),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 8,
                                fontWeight: FontWeight.w600,
                                color: Colors.red.shade400,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                // Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        strings.productName(item.product),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                          height: 1.2,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${item.product.price.toInt()} SOM / ${strings.unitWithOne(item.product.unit)}',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          // Quantity controls
                          _buildQuantityButton(
                            icon: Icons.remove,
                            onTap: !isOutOfStock
                                ? () {
                                    if (item.quantity <= item.step) {
                                      _showDeleteItemDialog(
                                        context,
                                        item.product.id,
                                        strings.productName(item.product),
                                      );
                                    } else {
                                      context
                                          .read<CartProvider>()
                                          .decrementItem(item.product.id);
                                    }
                                  }
                                : null,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              strings.quantityLabel(
                                item.quantity,
                                item.product.unit,
                              ),
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ),
                          _buildQuantityButton(
                            icon: Icons.add,
                            onTap: !isOutOfStock
                                ? () => context
                                      .read<CartProvider>()
                                      .incrementItem(item.product.id)
                                : null,
                            isPrimary: true,
                          ),
                          const Spacer(),
                          // Total for this item
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.paleGreen,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              '${item.totalPrice.toInt()} SOM',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: AppColors.darkGreen,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 4),
                // Delete button
                GestureDetector(
                  onTap: () => _showDeleteItemDialog(
                    context,
                    item.product.id,
                    strings.productName(item.product),
                  ),
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.close_rounded,
                      size: 16,
                      color: Colors.red.shade400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
        .animate(delay: (index * 60).ms)
        .fadeIn(duration: 300.ms)
        .slideX(begin: 0.05, end: 0, duration: 300.ms, curve: Curves.easeOut);
  }

  void _showDeleteItemDialog(
    BuildContext context,
    String productId,
    String productName,
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
          context.strings.tr('removeProductMessage', {'name': productName}),
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
              context.read<CartProvider>().removeItem(productId);
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
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: isEnabled
              ? (isPrimary
                    ? AppColors.accentGreen
                    : AppColors.accentGreen.withValues(alpha: 0.15))
              : AppColors.divider.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(9),
        ),
        child: Icon(
          icon,
          size: 15,
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
