import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../models/product_model.dart';
import '../providers/cart_provider.dart';
import '../theme/app_theme.dart';

class ProductDetailScreen extends StatefulWidget {
  final ProductModel product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late double _quantity;

  double get _step => widget.product.unit == 'кг' ? 0.5 : 1.0;

  @override
  void initState() {
    super.initState();
    _quantity = context.read<CartProvider>().getQuantity(widget.product.id);
  }

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

  @override
  Widget build(BuildContext context) {
    final isOutOfStock = !widget.product.isAvailable;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                // Collapsing AppBar with product image
                SliverAppBar(
                  expandedHeight: screenHeight * 0.45,
                  pinned: true,
                  backgroundColor: AppColors.white,
                  elevation: 0,
                  scrolledUnderElevation: 2,
                  surfaceTintColor: AppColors.white,
                  leadingWidth: 72,
                  leading: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.white.withValues(alpha: 0.9),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.08),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: AppColors.darkGreen,
                            size: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: GestureDetector(
                        onTap: () {
                          // TODO: Share or Favorite
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: AppColors.white.withValues(alpha: 0.9),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.08),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.favorite_border_rounded,
                              color: AppColors.darkGreen,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                  flexibleSpace: FlexibleSpaceBar(
                    background: Hero(
                      tag: 'product_image_${widget.product.id}',
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.paleGreen.withValues(alpha: 0.5),
                        ),
                        child: Stack(
                          children: [
                            Center(
                              child: Icon(
                                _getCategoryIcon(widget.product.categoryId),
                                size: 120,
                                color: AppColors.accentGreen.withValues(
                                  alpha: 0.3,
                                ),
                              ),
                            ),
                            if (isOutOfStock)
                              Positioned(
                                bottom: 16,
                                left: 16,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.red.shade50,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    'Нет в наличии',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.red.shade400,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // Product info
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Name
                        Text(
                              widget.product.name,
                              style: const TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.w800,
                                color: AppColors.textPrimary,
                                letterSpacing: -0.5,
                                height: 1.2,
                              ),
                            )
                            .animate()
                            .fadeIn(duration: 300.ms)
                            .slideY(
                              begin: 0.1,
                              end: 0,
                              duration: 300.ms,
                              curve: Curves.easeOut,
                            ),

                        const SizedBox(height: 12),

                        // Price
                        Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.paleGreen,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                '${widget.product.price.toInt()} SOM / ${widget.product.unit == 'кг' ? '1 кг' : widget.product.unit}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.darkGreen,
                                ),
                              ),
                            )
                            .animate(delay: 100.ms)
                            .fadeIn(duration: 300.ms)
                            .slideY(
                              begin: 0.1,
                              end: 0,
                              duration: 300.ms,
                              curve: Curves.easeOut,
                            ),

                        const SizedBox(height: 24),

                        // Description header
                        const Text(
                          'Описание',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                            letterSpacing: -0.3,
                          ),
                        ).animate(delay: 200.ms).fadeIn(duration: 300.ms),

                        const SizedBox(height: 8),

                        // Description text
                        Text(
                          widget.product.description.isNotEmpty
                              ? widget.product.description
                              : 'Описание товара скоро появится.',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: AppColors.textSecondary,
                            height: 1.6,
                          ),
                        ).animate(delay: 250.ms).fadeIn(duration: 300.ms),

                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Bottom action bar
          _buildBottomBar(isOutOfStock),
        ],
      ),
    );
  }

  Widget _buildBottomBar(bool isOutOfStock) {
    return Container(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 16,
        bottom: MediaQuery.of(context).padding.bottom + 16,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Quantity selector
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildQuantityButton(
                icon: Icons.remove,
                onTap: _quantity > 0 && !isOutOfStock ? _decrement : null,
              ),
              const SizedBox(width: 16),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: SizedBox(
                  width: 100,
                  child: Column(
                    key: ValueKey(_quantity),
                    children: [
                      Text(
                        _quantityLabel,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: _quantity > 0
                              ? AppColors.textPrimary
                              : AppColors.textSecondary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      if (_quantity > 0) ...[
                        const SizedBox(height: 2),
                        Text(
                          _totalLabel,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.darkGreen,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16),
              _buildQuantityButton(
                icon: Icons.add,
                onTap: !isOutOfStock ? _increment : null,
                isPrimary: true,
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Add to cart button
          SizedBox(
            width: double.infinity,
            height: 54,
            child: ElevatedButton(
              onPressed: isOutOfStock || _quantity <= 0
                  ? null
                  : () {
                      context.read<CartProvider>().setItem(
                        widget.product,
                        _quantity,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            '${widget.product.name} добавлен в корзину',
                          ),
                          backgroundColor: AppColors.accentGreen,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          margin: const EdgeInsets.all(16),
                        ),
                      );
                      Navigator.of(context).pop();
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accentGreen,
                disabledBackgroundColor: AppColors.accentGreen.withValues(
                  alpha: 0.3,
                ),
                foregroundColor: AppColors.white,
                disabledForegroundColor: AppColors.white.withValues(alpha: 0.6),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text(
                isOutOfStock
                    ? 'Нет в наличии'
                    : _quantity > 0
                    ? 'В корзину · $_totalLabel'
                    : 'Выберите количество',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.2,
                ),
              ),
            ),
          ),
        ],
      ),
    ).animate().slideY(
      begin: 1,
      end: 0,
      duration: 400.ms,
      curve: Curves.easeOutCubic,
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
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: isEnabled
              ? (isPrimary
                    ? AppColors.accentGreen
                    : AppColors.accentGreen.withValues(alpha: 0.15))
              : AppColors.divider.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(14),
          boxShadow: isEnabled && isPrimary
              ? [
                  BoxShadow(
                    color: AppColors.accentGreen.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ]
              : null,
        ),
        child: Icon(
          icon,
          size: 22,
          color: isEnabled
              ? (isPrimary ? AppColors.white : AppColors.darkGreen)
              : AppColors.textSecondary.withValues(alpha: 0.4),
        ),
      ),
    );
  }
}
