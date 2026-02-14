import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../l10n/app_strings.dart';
import '../models/product_model.dart';
import '../providers/cart_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/app_image.dart';
import 'cart_screen.dart';
import 'product_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _clearQuery() {
    _controller.clear();
    setState(() {});
  }

  List<ProductModel> _filteredProducts() {
    final strings = context.strings;
    final query = _controller.text.trim().toLowerCase();
    if (query.isEmpty) return const [];
    return ProductModel.products.where((product) {
      final name = strings.productName(product).toLowerCase();
      final description = strings.productDescription(product).toLowerCase();
      return name.contains(query) || description.contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.strings;
    final hasQuery = _controller.text.trim().isNotEmpty;
    final products = _filteredProducts();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        surfaceTintColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
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
        centerTitle: true,
        title: Text(
          strings.t('search'),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
            letterSpacing: -0.3,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
            child: TextField(
              controller: _controller,
              onChanged: (_) => setState(() {}),
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                hintText: strings.t('searchProducts'),
                hintStyle: TextStyle(
                  color: AppColors.textSecondary.withValues(alpha: 0.6),
                ),
                prefixIcon: const Icon(
                  Icons.search_rounded,
                  color: AppColors.darkGreen,
                ),
                suffixIcon: hasQuery
                    ? IconButton(
                        icon: const Icon(
                          Icons.close_rounded,
                          color: AppColors.textSecondary,
                        ),
                        onPressed: _clearQuery,
                      )
                    : null,
                filled: true,
                fillColor: AppColors.white,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(
                    color: AppColors.lightGreen.withValues(alpha: 0.3),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(
                    color: AppColors.lightGreen.withValues(alpha: 0.3),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(
                    color: AppColors.accentGreen,
                    width: 1.2,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: hasQuery && products.isNotEmpty
                ? ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                    itemBuilder: (context, index) {
                      return _SearchProductTile(product: products[index]);
                    },
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 10),
                    itemCount: products.length,
                  )
                : Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.search_off_rounded,
                            size: 56,
                            color: AppColors.textSecondary.withValues(
                              alpha: 0.5,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            strings.t('nothingFound'),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            hasQuery
                                ? strings.t('tryDifferentQuery')
                                : strings.t('enterQuery'),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 13,
                              color: AppColors.textSecondary.withValues(
                                alpha: 0.7,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
        ],
      ),
      bottomNavigationBar: Consumer<CartProvider>(
        builder: (context, cart, _) {
          if (cart.totalPrice <= 0) return const SizedBox.shrink();
          return Container(
            padding: EdgeInsets.fromLTRB(
              16,
              10,
              16,
              MediaQuery.of(context).padding.bottom + 10,
            ),
            decoration: BoxDecoration(
              color: AppColors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: 12,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        strings.t('sumOrder'),
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary.withValues(alpha: 0.8),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '${cart.totalPrice.toInt()} SOM',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: AppColors.darkGreen,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 46,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const CartScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.accentGreen,
                      foregroundColor: AppColors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: Text(strings.t('openCart')),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _SearchProductTile extends StatelessWidget {
  const _SearchProductTile({required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    final strings = context.strings;
    final quantity = cart.getQuantity(product.id);
    final step = product.unit == 'кг' ? 0.5 : 1.0;

    return Material(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => ProductDetailScreen(product: product),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: AppColors.lightGreen.withValues(alpha: 0.28),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: AppColors.paleGreen,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: AppImage(
                    path: product.imagePath,
                    fit: BoxFit.cover,
                    placeholder: Icon(
                      Icons.shopping_basket_outlined,
                      color: AppColors.accentGreen.withValues(alpha: 0.65),
                      size: 22,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      strings.productName(product),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${product.price.toInt()} SOM / ${strings.unitWithOne(product.unit)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                        color: AppColors.darkGreen,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 6),
              _QtyButton(
                icon: Icons.remove,
                onTap: quantity > 0
                    ? () => cart.setItem(product, quantity - step)
                    : null,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: Text(
                  strings.quantityLabel(quantity, product.unit),
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              _QtyButton(
                icon: Icons.add,
                isPrimary: true,
                onTap: product.isAvailable
                    ? () => cart.setItem(product, quantity + step)
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _QtyButton extends StatelessWidget {
  const _QtyButton({
    required this.icon,
    required this.onTap,
    this.isPrimary = false,
  });

  final IconData icon;
  final VoidCallback? onTap;
  final bool isPrimary;

  @override
  Widget build(BuildContext context) {
    final enabled = onTap != null;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: enabled
              ? (isPrimary
                    ? AppColors.accentGreen
                    : AppColors.accentGreen.withValues(alpha: 0.15))
              : AppColors.divider.withValues(alpha: 0.35),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          size: 14,
          color: enabled
              ? (isPrimary ? AppColors.white : AppColors.darkGreen)
              : AppColors.textSecondary.withValues(alpha: 0.5),
        ),
      ),
    );
  }
}
