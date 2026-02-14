import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'l10n/app_strings.dart';
import 'providers/app_settings_provider.dart';
import 'providers/cart_provider.dart';
import 'providers/favorites_provider.dart';
import 'screens/home_screen.dart';
import 'theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const OsonBozorlikApp());
}

class OsonBozorlikApp extends StatelessWidget {
  const OsonBozorlikApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppSettingsProvider()..loadSettings(),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => CartProvider()..loadCart()),
          ChangeNotifierProvider(
            create: (_) => FavoritesProvider()..loadFavorites(),
          ),
        ],
        child: Consumer<AppSettingsProvider>(
          builder: (context, settings, _) {
            return MaterialApp(
              title: 'Oson Bozorlik',
              debugShowCheckedModeBanner: false,
              theme: AppTheme.lightTheme,
              locale: settings.locale,
              supportedLocales: AppStrings.supportedLocales,
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              home: const HomeScreen(),
            );
          },
        ),
      ),
    );
  }
}
