import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'l10n/app_strings.dart';
import 'providers/app_settings_provider.dart';
import 'providers/cart_provider.dart';
import 'providers/favorites_provider.dart';
import 'screens/home_screen.dart';
import 'theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await dotenv.load(fileName: '.env');
  } catch (_) {
    debugPrint('Could not load .env, falling back to dart-define values.');
  }

  final supabaseUrl =
      dotenv.env['SUPABASE_URL'] ??
      const String.fromEnvironment('SUPABASE_URL');
  final supabasePublishableKey =
      dotenv.env['SUPABASE_PUBLISHABLE_KEY'] ??
      const String.fromEnvironment('SUPABASE_PUBLISHABLE_KEY');

  if (supabaseUrl.isNotEmpty && supabasePublishableKey.isNotEmpty) {
    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabasePublishableKey,
    );
  } else {
    debugPrint(
      'Supabase is not initialized. Missing SUPABASE_URL or SUPABASE_PUBLISHABLE_KEY.',
    );
  }

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
