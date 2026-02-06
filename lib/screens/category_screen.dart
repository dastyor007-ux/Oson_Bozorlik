import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/category_model.dart';
import '../models/product_model.dart';
import '../models/subcategory_model.dart';
import '../theme/app_theme.dart';
import '../widgets/product_card.dart';

class CategoryScreen extends StatefulWidget {
  final CategoryModel category;

  const CategoryScreen({super.key, required this.category});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  late final List<SubcategoryModel> _subcategories;
  late final ScrollController _scrollController;
  final Map<String, GlobalKey> _sectionKeys = {};
  int _selectedTabIndex = 0;
  bool _isTabTap = false;

  @override
  void initState() {
    super.initState();
    _subcategories = SubcategoryModel.getByCategoryId(widget.category.id);
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);

    for (final sub in _subcategories) {
      _sectionKeys[sub.id] = GlobalKey();
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isTabTap) return;

    final pos = _scrollController.position;

    // At the very top — select first subcategory
    if (pos.pixels <= 0) {
      if (_selectedTabIndex != 0) {
        setState(() => _selectedTabIndex = 0);
      }
      return;
    }

    // At the very bottom — select last subcategory
    if (pos.pixels >= pos.maxScrollExtent - 1) {
      final lastIndex = _subcategories.length - 1;
      if (_selectedTabIndex != lastIndex) {
        setState(() => _selectedTabIndex = lastIndex);
      }
      return;
    }

    // Reference line: just below the pinned AppBar + tabs
    const referenceY = 160.0;

    // Find the last section header that scrolled above the reference line
    int newIndex = 0;
    for (int i = 0; i < _subcategories.length; i++) {
      final key = _sectionKeys[_subcategories[i].id];
      if (key?.currentContext != null) {
        final box = key!.currentContext!.findRenderObject() as RenderBox;
        final position = box.localToGlobal(Offset.zero);
        if (position.dy <= referenceY) {
          newIndex = i;
        }
      }
    }

    if (_selectedTabIndex != newIndex) {
      setState(() => _selectedTabIndex = newIndex);
    }
  }

  void _scrollToSection(int tabIndex) async {
    setState(() {
      _selectedTabIndex = tabIndex;
      _isTabTap = true;
    });

    final subId = _subcategories[tabIndex].id;
    final key = _sectionKeys[subId];
    if (key?.currentContext != null) {
      await Scrollable.ensureVisible(
        key!.currentContext!,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
        alignmentPolicy: ScrollPositionAlignmentPolicy.explicit,
      );
    }

    _isTabTap = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        slivers: [
          _buildAppBar(context),
          _buildSubcategoryTabs(),
          ..._buildProductSections(),
          const SliverToBoxAdapter(child: SizedBox(height: 40)),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      floating: true,
      backgroundColor: AppColors.white.withOpacity(0.9),
      elevation: 0,
      scrolledUnderElevation: 2,
      surfaceTintColor: AppColors.white,
      leading: IconButton(
        icon: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.accentGreen.withOpacity(0.15),
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.lightGreen.withOpacity(0.2),
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
        widget.category.name,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
          letterSpacing: -0.3,
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: IconButton(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.accentGreen.withOpacity(0.15),
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.lightGreen.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: const Icon(
                Icons.search_rounded,
                color: AppColors.darkGreen,
                size: 20,
              ),
            ),
            onPressed: () {
              // TODO: Navigate to search screen
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSubcategoryTabs() {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _SubcategoryTabsDelegate(
        tabNames: _subcategories.map((s) => s.name).toList(),
        selectedIndex: _selectedTabIndex,
        onTabTap: _scrollToSection,
      ),
    );
  }

  List<Widget> _buildProductSections() {
    final List<Widget> slivers = [];

    for (int i = 0; i < _subcategories.length; i++) {
      final sub = _subcategories[i];
      final products = ProductModel.getBySubCategoryId(
        widget.category.id,
        sub.id,
      );

      if (products.isEmpty) continue;

      // Section header
      slivers.add(
        SliverToBoxAdapter(
          child: Padding(
            key: _sectionKeys[sub.id],
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
            child: Row(
              children: [
                Container(
                  width: 4,
                  height: 20,
                  decoration: BoxDecoration(
                    color: AppColors.accentGreen,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  sub.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                    letterSpacing: -0.3,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '${products.length}',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ).animate().fadeIn(duration: 300.ms),
        ),
      );

      // Product grid
      slivers.add(
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 0.58,
            ),
            delegate: SliverChildBuilderDelegate((context, index) {
              return ProductCard(
                    product: products[index],
                    onTap: () {
                      // TODO: Navigate to product details
                    },
                  )
                  .animate(delay: (index * 50).ms)
                  .fadeIn()
                  .scale(
                    begin: const Offset(0.95, 0.95),
                    end: const Offset(1, 1),
                    duration: 300.ms,
                    curve: Curves.easeOut,
                  );
            }, childCount: products.length),
          ),
        ),
      );
    }

    return slivers;
  }
}

class _SubcategoryTabsDelegate extends SliverPersistentHeaderDelegate {
  final List<String> tabNames;
  final int selectedIndex;
  final ValueChanged<int> onTabTap;

  const _SubcategoryTabsDelegate({
    required this.tabNames,
    required this.selectedIndex,
    required this.onTabTap,
  });

  @override
  double get minExtent => 60;

  @override
  double get maxExtent => 60;

  @override
  bool shouldRebuild(covariant _SubcategoryTabsDelegate oldDelegate) {
    return oldDelegate.selectedIndex != selectedIndex ||
        oldDelegate.tabNames != tabNames;
  }

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return SizedBox(
      height: 60,
      child: Container(
        color: AppColors.white,
        alignment: Alignment.center,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: Row(
            children: List.generate(tabNames.length, (index) {
              final isSelected = selectedIndex == index;
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: GestureDetector(
                  onTap: () => onTabTap(index),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeInOut,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.accentGreen
                          : AppColors.accentGreen.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: isSelected
                            ? AppColors.accentGreen
                            : AppColors.lightGreen.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      tabNames[index],
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: isSelected
                            ? AppColors.white
                            : AppColors.darkGreen,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
