import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../l10n/app_strings.dart';
import '../models/category_model.dart';
import '../providers/app_settings_provider.dart';
import '../providers/cart_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/category_card.dart';
import 'cart_screen.dart';
import 'category_screen.dart';
import 'favorites_screen.dart';
import 'placeholder_screen.dart';
import 'search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<String> _cities = const ['zarafshan', 'uchkuduk', 'navoi'];
  late String _selectedCity;

  @override
  void initState() {
    super.initState();
    _selectedCity = _cities.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          _buildAppBar(context),
          _buildCategoriesList(context),
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
      drawer: _buildDrawer(context),
      floatingActionButton:
          FloatingActionButton(
            onPressed: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => const SearchScreen()));
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
                  if (value == null || value != _cities.first) return;
                  setState(() => _selectedCity = value);
                },
                items: _cities
                    .map(
                      (city) => DropdownMenuItem<String>(
                        value: city,
                        enabled: city == _cities.first,
                        child: Text(
                          context.strings.cityName(city),
                          style: TextStyle(
                            color: city == _cities.first
                                ? AppColors.textPrimary
                                : AppColors.textSecondary.withValues(
                                    alpha: 0.45,
                                  ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
      actions: [
        Consumer<CartProvider>(
          builder: (context, cart, _) {
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: IconButton(
                icon: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
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
                        Icons.shopping_cart_outlined,
                        color: AppColors.darkGreen,
                        size: 20,
                      ),
                    ),
                    if (cart.itemCount > 0)
                      Positioned(
                        right: -2,
                        top: -2,
                        child: Container(
                          constraints: const BoxConstraints(
                            minWidth: 16,
                            minHeight: 16,
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: const BoxDecoration(
                            color: AppColors.accentGreen,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              cart.itemCount > 99
                                  ? '99+'
                                  : cart.itemCount.toString(),
                              style: const TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.w700,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                onPressed: () {
                  Navigator.of(
                    context,
                  ).push(MaterialPageRoute(builder: (_) => const CartScreen()));
                },
              ),
            );
          },
        ),
      ],
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
    final strings = context.strings;
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
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        strings.t('loginProfile'),
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
            strings.t('cart'),
            onTap: () {
              _navigateFromDrawer(const CartScreen());
            },
          ),
          _buildDrawerItem(
            Icons.notifications_none_rounded,
            strings.t('notifications'),
            onTap: () {
              _navigateFromDrawer(
                PlaceholderScreen(
                  title: strings.t('notifications'),
                  icon: Icons.notifications_none_rounded,
                  message: strings.t('notificationsEmpty'),
                  subtitle: strings.t('notificationsSubtitle'),
                ),
              );
            },
          ),
          _buildDrawerItem(
            Icons.history_rounded,
            strings.t('orderHistory'),
            onTap: () {
              _navigateFromDrawer(
                PlaceholderScreen(
                  title: strings.t('orderHistory'),
                  icon: Icons.history_rounded,
                  message: strings.t('orderHistoryEmpty'),
                  subtitle: strings.t('orderHistorySubtitle'),
                ),
              );
            },
          ),
          _buildDrawerItem(
            Icons.favorite_outline_rounded,
            strings.t('favorites'),
            onTap: () {
              _navigateFromDrawer(const FavoritesScreen());
            },
          ),
          _buildDrawerItem(
            Icons.location_on_outlined,
            strings.t('addresses'),
            onTap: () {
              _navigateFromDrawer(
                PlaceholderScreen(
                  title: strings.t('addresses'),
                  icon: Icons.location_on_outlined,
                  message: strings.t('addressesEmpty'),
                  subtitle: strings.t('addressesSubtitle'),
                ),
              );
            },
          ),
          _buildDrawerItem(
            Icons.language_rounded,
            strings.t('language'),
            onTap: () {
              Navigator.of(context).pop();
              _showLanguageSheet(context);
            },
          ),
          const Divider(indent: 24, endIndent: 24, height: 40),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 2, 24, 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                strings.t('support'),
                style: TextStyle(
                  color: AppColors.textSecondary.withValues(alpha: 0.7),
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.2,
                ),
              ),
            ),
          ),
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
          const Padding(
            padding: EdgeInsets.fromLTRB(24, 10, 24, 10),
            child: Divider(height: 1, color: AppColors.divider),
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
            strings.t('about'),
            onTap: () {
              Navigator.of(context).pop();
              _showAboutSheet(context);
            },
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Text(
                  '${strings.t('version')} 1.0.0',
                  style: const TextStyle(
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

  void _navigateFromDrawer(Widget page) {
    Navigator.of(context).pop();
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => page)).then((
      _,
    ) {
      if (!mounted) return;
      Future<void>.delayed(const Duration(milliseconds: 120), () {
        if (!mounted) return;
        _scaffoldKey.currentState?.openDrawer();
      });
    });
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
      ScaffoldMessenger.of(this.context).showSnackBar(
        SnackBar(content: Text(this.context.strings.t('supportOpenFailed'))),
      );
    }
  }

  void _showLanguageSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        final strings = context.strings;
        final selectedCode = context
            .watch<AppSettingsProvider>()
            .locale
            .languageCode;
        const options = ['ru', 'uz', 'en'];
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
              Text(
                strings.t('language'),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 12),
              ...options.map((code) {
                final isSelected = selectedCode == code;
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(_languageName(code, strings)),
                  trailing: isSelected
                      ? const Icon(
                          Icons.check_rounded,
                          color: AppColors.accentGreen,
                        )
                      : null,
                  onTap: () {
                    context.read<AppSettingsProvider>().setLocale(code);
                    Navigator.of(context).pop();
                  },
                );
              }),
            ],
          ),
        );
      },
    );
  }

  String _languageName(String code, AppStrings strings) {
    switch (code) {
      case 'ru':
        return strings.t('langRu');
      case 'uz':
        return strings.t('langUz');
      case 'en':
        return strings.t('langEn');
      default:
        return code;
    }
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
              Text(
                context.strings.t('about'),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                context.strings.t('aboutDescription'),
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
}
