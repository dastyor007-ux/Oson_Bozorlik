import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/category_model.dart';
import '../theme/app_theme.dart';
import '../widgets/category_card.dart';
import 'cart_screen.dart';
import 'category_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> _cities = const ['Зарафшан', 'Учкудук', 'Навои'];
  late String _selectedCity;

  @override
  void initState() {
    super.initState();
    _selectedCity = _cities.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          _buildAppBar(context),
          _buildGreeting(context),
          _buildCategoriesList(context),
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
      drawer: _buildDrawer(context),
      floatingActionButton:
          FloatingActionButton(
            onPressed: () {
              // TODO: Navigate to search screen
            },
            backgroundColor: AppColors.accentGreen,
            elevation: 4,
            child: const Icon(
              Icons.search_rounded,
              size: 28,
              color: AppColors.white,
            ),
          ).animate().scale(
            delay: 400.ms,
            duration: 400.ms,
            curve: Curves.easeOutBack,
          ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      floating: true,
      backgroundColor: AppColors.white,
      elevation: 0,
      scrolledUnderElevation: 2,
      surfaceTintColor: AppColors.white,
      leading: Builder(
        builder: (context) => IconButton(
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
            child: const Icon(Icons.menu, color: AppColors.darkGreen, size: 20),
          ),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      centerTitle: true,
      title: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppColors.lightGreen.withValues(alpha: 0.2),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.location_on,
              color: AppColors.accentGreen,
              size: 18,
            ),
            const SizedBox(width: 8),
            DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedCity,
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                  color: AppColors.accentGreen,
                  size: 18,
                ),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.darkGreen,
                ),
                dropdownColor: AppColors.white,
                onChanged: (value) {
                  if (value == null) return;
                  setState(() => _selectedCity = value);
                },
                items: _cities
                    .map(
                      (city) => DropdownMenuItem<String>(
                        value: city,
                        child: Text(city),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: IconButton(
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
                Icons.notifications_none_rounded,
                color: AppColors.darkGreen,
                size: 20,
              ),
            ),
            onPressed: () {
              // TODO: Open notifications
            },
          ),
        ),
      ],
    );
  }

  Widget _buildGreeting(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Oson Bozorlik',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: AppColors.accentGreen,
                letterSpacing: 1.2,
              ),
            ).animate().fadeIn().slideX(begin: -0.2),
            const SizedBox(height: 8),
            const Text(
              'Свежие продукты\nпрямо к вам домой',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color: AppColors.textPrimary,
                height: 1.1,
                letterSpacing: -0.5,
              ),
            ).animate().fadeIn(delay: 100.ms).slideY(begin: 0.2),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoriesList(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          final category = CategoryModel.categories[index];
          return CategoryCard(
            category: category,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => CategoryScreen(category: category),
                ),
              );
            },
          ).animate(delay: (index * 50).ms).fadeIn().slideX(begin: 0.1);
        }, childCount: CategoryModel.categories.length),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(24, 60, 24, 32),
            decoration: BoxDecoration(
              color: AppColors.lightGreen.withValues(alpha: 0.2),
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(32),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: const BoxDecoration(
                    color: AppColors.accentGreen,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.person,
                    color: AppColors.white,
                    size: 32,
                  ),
                ),
                const SizedBox(width: 16),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Войти в профиль',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      Text(
                        'oson@bozorlik.uz',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _buildDrawerItem(
            Icons.shopping_cart_outlined,
            'Корзина',
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => const CartScreen()));
            },
          ),
          _buildDrawerItem(Icons.history_rounded, 'История заказов'),
          _buildDrawerItem(Icons.favorite_outline_rounded, 'Избранное'),
          _buildDrawerItem(Icons.location_on_outlined, 'Мои адреса'),
          _buildDrawerItem(Icons.language_rounded, 'Выбор языка'),
          const Divider(indent: 24, endIndent: 24, height: 40),
          _buildDrawerItem(
            Icons.phone_outlined,
            '+998 50 099 33 37',
            onTap: () {
              Navigator.of(context).pop();
              _openUrl(context, 'tel:+998500993337');
            },
          ),
          _buildDrawerItem(
            Icons.send_outlined,
            'Telegram',
            onTap: () {
              Navigator.of(context).pop();
              _openUrl(context, 'https://t.me/osonbozorlik');
            },
          ),
          _buildDrawerItem(
            Icons.camera_alt_outlined,
            'Instagram',
            onTap: () {
              Navigator.of(context).pop();
              _openUrl(context, 'https://instagram.com/osonbozorlik');
            },
          ),
          _buildDrawerItem(
            Icons.info_outline_rounded,
            'О приложении',
            onTap: () {
              Navigator.of(context).pop();
              _showAboutSheet(context);
            },
          ),
          _buildDrawerItem(
            Icons.help_outline_rounded,
            'Поддержка',
            onTap: () {
              Navigator.of(context).pop();
              _showSupportSheet(context);
            },
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const Text(
                  'Версия 1.0.0',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Oson Bozorlik 2026',
                  style: TextStyle(
                    fontSize: 11,
                    color: AppColors.textSecondary.withValues(alpha: 0.5),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, {VoidCallback? onTap}) {
    return ListTile(
      dense: true,
      visualDensity: const VisualDensity(vertical: -2),
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
      leading: Icon(icon, color: AppColors.darkGreen, size: 22),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 12,
        color: AppColors.textSecondary,
      ),
      onTap: onTap ?? () {},
    );
  }

  Future<void> _openUrl(BuildContext context, String url) async {
    final uri = Uri.parse(url);
    final didLaunch = await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );
    if (!didLaunch) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Не удалось открыть ссылку')),
      );
    }
  }

  void _showSupportSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.fromLTRB(
            20,
            20,
            20,
            MediaQuery.of(context).padding.bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Поддержка',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 12),
              _buildInfoRow(Icons.phone, '+998 50 099 33 37'),
              const SizedBox(height: 8),
              _buildInfoRow(Icons.send, '@osonbozorlik'),
              const SizedBox(height: 8),
              _buildInfoRow(Icons.camera_alt, 'osonbozorlik'),
            ],
          ),
        );
      },
    );
  }

  void _showAboutSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.fromLTRB(
            20,
            20,
            20,
            MediaQuery.of(context).padding.bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'О приложении',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Oson Bozorlik — свежие продукты и товары первой необходимости с доставкой на дом.',
                style: TextStyle(
                  fontSize: 14,
                  height: 1.4,
                  color: AppColors.textSecondary.withValues(alpha: 0.9),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildInfoRow(IconData icon, String value) {
    return Row(
      children: [
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: AppColors.paleGreen,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 18, color: AppColors.accentGreen),
        ),
        const SizedBox(width: 10),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}
